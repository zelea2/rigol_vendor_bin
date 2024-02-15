#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <stddef.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <time.h>
#include <getopt.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <termios.h>
#include <linux/i2c-dev.h>
#include <linux/spi/spidev.h>

#ifndef _MY_Uxx
#define _MY_Uxx
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#endif

#define FRAM_LEN 0x2000
#define SFLASH_LEN 0x1000000
#define SFLASH_SECTOR 0x100
#define BUF_LEN 0x200

struct
{
  u16           fram_addr;
  u8            dev[BUF_LEN];
  u8            bin[BUF_LEN];
} buf;

enum
{ OP_NONE, OP_HEXDUMP, OP_READ, OP_WRITE, OP_COMPARE, OP_BOOT };

struct switches
{
  unsigned int  operation:3;
  unsigned int  sflash:1;
  unsigned int  fastcmp:1;
  unsigned int  quiet:1;
} sw;

// Initialize new terminal I/O settings 
static void
initTermios( int echo )
{
  static struct termios old, current;

  tcgetattr( 0, &old );         // grab old terminal I/O settings 
  current = old;                // make new settings same as old settings 
  current.c_lflag &= ~ICANON;   // disable buffered I/O
  if( echo )
    current.c_lflag |= ECHO;    // set echo mode 
  else
    current.c_lflag &= ~ECHO;   // set no echo mode 
  tcsetattr( 0, TCSANOW, &current );    // use these new terminal I/O settings
}

static void
error( char *fmt, ... )
{
  va_list       ap;
  va_start( ap, fmt );
  vfprintf( stderr, fmt, ap );
  va_end( ap );
  exit( 0 );
}

static void
confirm( char *msg, ... )
{
  int           key;
  va_list       ap;
  if( sw.quiet )
    return;
  va_start( ap, msg );
  vprintf( msg, ap );
  va_end( ap );
  printf( "Confirm [Y/n] " );
  fflush( stdout );
  initTermios( 0 );
  key = getchar(  );
  initTermios( 1 );
  printf( "\n" );
  if( key != 'Y' )
    exit( 0 );
}

u8
get_hex( char *s )
{
  u8            h, l;

  h = ( *( s + 0 ) | 0x20 ) - '0';
  l = ( *( s + 1 ) | 0x20 ) - '0';
  if( h > 9 )
    h -= 0x27;
  if( l > 9 )
    l -= 0x27;
  return ( h << 4 ) | l;
}

static int
pause_wait_for_key( void )
{
  int           key;
  initTermios( 0 );
  key = getchar(  );
  initTermios( 1 );
  if( key == 'q' || key == 'Q' || key == 0x1b )
    return 1;
  return 0;
}

static void
spi_mode( int dev, u8 mode )
{
  if( ioctl( dev, SPI_IOC_WR_MODE, &mode ) == -1 )
    error( "Can't set SPI mode\n" );
  if( ioctl( dev, SPI_IOC_RD_MODE, &mode ) == -1 )
    error( "Can't get SPI mode\n" );
}

static void
spi_bits( int dev, u8 bits )
{
  if( ioctl( dev, SPI_IOC_WR_BITS_PER_WORD, &bits ) == -1 )
    error( "Can't set bits per word\n" );
  if( ioctl( dev, SPI_IOC_RD_BITS_PER_WORD, &bits ) == -1 )
    error( "Can't get bits per word\n" );
}

static void
spi_lsb( int dev, u8 lsb )
{
  if( ioctl( dev, SPI_IOC_WR_LSB_FIRST, &lsb ) == -1 )
    error( "Can't set bit order\n" );
  if( ioctl( dev, SPI_IOC_RD_LSB_FIRST, &lsb ) == -1 )
    error( "Can't get bit order\n" );
}

static void
spi_max_speed( int dev, u32 speed )
{
  if( ioctl( dev, SPI_IOC_WR_MAX_SPEED_HZ, &speed ) == -1 )
    error( "Can't set max speed %dkHz\n", speed / 1000 );
  if( ioctl( dev, SPI_IOC_RD_MAX_SPEED_HZ, &speed ) == -1 )
    error( "Can't get max speed\n" );
}

#if 0
int
spi_pgm( int dev, char *a2 )
{
  FILE         *v4;
  int           v5;
  unsigned int  v6;
  int           v7;
  unsigned int  v8;

  v4 = fopen( a2, "r" );
  if( !v4 )
    return -1;
  if( v5 )
  {
    v6 = fread( v5, 1LL, 123, v4 );
    printf( "Sending :0x%x\n", v6 );
    v7 = v5;
    v8 = v6 / SFLASH_SECTOR;
    puts( "\nStart Prog Flash" );
    while( v8 )
    {
      write( dev, v7, SFLASH_SECTOR );
      v7 += SFLASH_SECTOR;
      --v8;
      usleep( 1000 );
    }
    write( dev, v7, ( int ) ( v5 + v6 - v7 ) );
    usleep( 10000 );
  }
  fclose( v4 );
  return 0LL;
}
#endif

int
compare( int addr, int len )
{
  static int    lines = 0;
  int           i, diffs = 0;

  for( i = 0; i < len; i++ )
  {
    if( buf.dev[i] != buf.bin[i] )
    {
      if( !sw.fastcmp || lines < 8 )
        printf( "%06x: %02x %02x\n", addr + i, buf.dev[i], buf.bin[i] );
      lines++;
      diffs++;
      if( !sw.fastcmp && !sw.quiet && ( lines % 24 == 0 ) )
        if( pause_wait_for_key(  ) )
          return -diffs;
    }
  }
  return diffs;
}

void
hexdump( int bin, unsigned offset )
{
  int           i, len, l, skip, lines = 0;
  u8           *b;

  skip = offset & 0xf;
  offset &= ~0xf;
  while( ( len = read( bin, buf.bin, BUF_LEN ) ) != 0 )
  {
    b = buf.bin;
    while( len )
    {
      printf( "%06x:  ", offset );
      while( skip )
      {
        printf( "   " );
        skip--;
      }
      l = len > 0x10 ? 0x10 : len;
      for( i = 0; i < l; i++ )
        printf( " %02x", *b++ );
      printf( "\n" );
      offset += 0x10;
      len -= l;
      lines++;
      if( !sw.quiet && ( lines % 24 == 0 ) )
        if( pause_wait_for_key(  ) )
          return;
    }
  }
}

void
usage( char *progname )
{
  fprintf( stderr, "\n%s [options] [binary_file]\n", progname );
  fprintf( stderr,
      "\t-r\tread memory\n"
      "\t-c\tquick compare memory\n"
      "\t-C\tthorough compare memory\n"
      "\t-w\twrite memory\n"
      "\t-s #\tstart address (default 0)\n"
      "\t-o #\toffset in file (default 0)\n"
      "\t-l #\tlength to read/write (default memory size)\n"
      "\t-q\tquiet operation (no warnings or prompts)\n"
      "\t-d\thexdump the binary_file\n"
      "\t-F\tselect SerialFlash (default FRAM) - DANGEROUS!\n"
      "\t-b\treboot FPGA from start address\n" );
  exit( 0 );
}

int
main( int argc, char *argv[] )
{
  int           option, dev, bin, l, real_len, d, diffs;
  char         *image_bin, *dev_name;
  u32           msb;
  unsigned      start_address, file_offset, offset, mem_length;

  start_address = file_offset = mem_length = 0;
  fprintf( stderr,
      "NV-MEM - Read/Write/Compare Non-Volatile Memories in Rigol Scopes\n\n" );
  do
  {
    option = getopt( argc, argv, "hFbrcCws:o:l:qd" );
    switch ( option )
    {
      case 'r':
        sw.operation = OP_READ;
        break;
      case 'c':
        sw.operation = OP_COMPARE;
        sw.fastcmp = 1;
        break;
      case 'C':
        sw.operation = OP_COMPARE;
        break;
      case 'w':
        sw.operation = OP_WRITE;
        break;
      case 's':
        start_address = strtoll( optarg, NULL, 16 );
        break;
      case 'o':
        file_offset = strtoll( optarg, NULL, 16 );
        break;
      case 'l':
        mem_length = strtoll( optarg, NULL, 16 );
        break;
      case 'q':
        sw.quiet = 1;
        break;
      case 'd':
        sw.operation = OP_HEXDUMP;
        break;
      case 'F':
        sw.sflash = 1;
        break;
      case 'b':
        sw.operation = OP_BOOT;
        break;
      case 'h':
        usage( argv[0] );
        break;
      case EOF:                // no more options
        break;
      default:
        fprintf( stderr,
            "getopt returned impossible value: %d ('%c')", option, option );
        usage( argv[0] );
    }
  }
  while( option != EOF );

  if( optind == argc )
    image_bin = sw.sflash ? "SFLASH.bin" : "FRAM.bin";
  else
    image_bin = argv[optind++];
  if( strstr( argv[0], "fram" ) )
    sw.sflash = 0;
  else if( strstr( argv[0], "sflash" ) )
    sw.sflash = 1;
  else if( strstr( argv[0], "cmp" ) )
    sw.operation = OP_COMPARE;
  else if( strstr( argv[0], "dump" ) )
    sw.operation = OP_HEXDUMP;
  if( sw.operation == OP_NONE )
    usage( argv[0] );
  if( start_address >= ( sw.sflash ? SFLASH_LEN : FRAM_LEN ) )
    error( "Start address 0x%x is beyond the memory length\n",
        start_address );
  if( sw.sflash && start_address & 0xff )
    error( "Start address 0x%x must be sector (0x100) aligned\n",
        start_address );
  if( mem_length == 0 )
    mem_length = ( sw.sflash ? SFLASH_LEN : FRAM_LEN ) - start_address;
  if( sw.sflash == 0 && sw.operation == OP_READ )
    bin = creat( image_bin, 0666 );
  else
    bin = open( image_bin, O_RDONLY );
  if( bin < 0 )
    error( "Cannot %s binary file %s\n",
        ( sw.sflash == 0 && sw.operation == OP_READ ) ? "create" : "open",
        image_bin );
  if( file_offset )
  {
    offset = lseek( bin, file_offset, SEEK_SET );
    if( offset != file_offset )
      error( "Invalid file offset 0x%x\n", file_offset );
  }
  if( sw.operation == OP_HEXDUMP )
  {
    hexdump( bin, file_offset );
    exit( 0 );
  }
  dev_name = sw.sflash ? "/dev/spidev1.0" : "/dev/i2c-4";
  if( ( dev = open( dev_name, O_RDWR ) ) < 0 )
    error( "Cannot open device %s\n", dev_name );
  if( sw.sflash )
  {
    switch ( sw.operation )
    {
      case OP_WRITE:
        if( start_address < 0x400000 )
          confirm( "Start address is lower than 0x400000 (4MB)\n"
              "Only proceed if you have a backup copy of the serial flash\n" );
        // flow through
      case OP_BOOT:
        confirm( "Before continuing with a serial flash operation\n"
            "please make sure that the scope application is stopped:\n"
            "\tpm disable com.rigol.scope\n"
            "and the following two kernel modules are unloaded:\n"
            "\trmmod xdma; rmmod pcie_rockchip\n" );
        break;
      default:
        error( "The Zynq FPGA doesn't support reading the serial flash chip\n"
            "You will need an external programmer to dump its content\n" );
        break;
    }
    spi_bits( dev, 8 );
    spi_mode( dev, 0 );
    // spi_lsb( dev, 0 ); // default is MSB
    spi_max_speed( dev, 10000000 );     // 10MHz
    puts( "SPI FLASH device is ready" );
    switch ( sw.operation )
    {
      case OP_WRITE:
        write( dev, "\rPROG\r", 6 );
        msb = __builtin_bswap32( start_address );
        write( dev, &msb, sizeof( u32 ) );
        msb = __builtin_bswap32( mem_length );
        write( dev, &msb, sizeof( u32 ) );
        puts( "Waiting 20s For Flash Erase..." );
        sleep( 20 );
        puts( "Start Flash Programming..." );
        real_len = 0;
        while( mem_length )
        {
          l = mem_length > SFLASH_SECTOR ? SFLASH_SECTOR : mem_length;
          if( ( l = read( bin, buf.dev, l ) ) <= 0 )
            break;
          if( ( l = write( dev, buf.dev, l ) ) <= 0 )
            break;
          usleep( 1000 );
          mem_length -= l;
          real_len += l;
        }
        usleep( 10000 );
        printf( "0x%x bytes written to the serial flash\n", real_len );
        break;
      case OP_BOOT:
        puts( "Boot MultiBoot Image" );
        write( dev, "\rBOOT\r", 6 );
        msb = __builtin_bswap32( start_address );
        write( dev, &msb, sizeof( u32 ) );
        puts( "Waiting 5s For MultiBoot Image Boot..." );
        sleep( 5 );
        puts( "Done" );
        break;
    }
  }
  else
  {
    if( ioctl( dev, I2C_SLAVE, 0x50 ) < 0 )     // The I2C FRAM address
      error( "No FRAM at address 0x50 on bus i2c-4\n" );
    puts( "I2C FRAM device is ready" );
    real_len = diffs = 0;
    while( mem_length )
    {
      l = mem_length > BUF_LEN ? BUF_LEN : mem_length;
      switch ( sw.operation )
      {
        case OP_READ:
          buf.fram_addr = __builtin_bswap16( start_address );
          write( dev, &buf.fram_addr, sizeof( u16 ) );
          if( ( l = read( dev, buf.dev, l ) ) <= 0 )
            goto after_while;
          if( ( l = write( bin, buf.dev, l ) ) <= 0 )
            goto after_while;
          break;
        case OP_WRITE:
          if( ( l = read( bin, buf.dev, l ) ) <= 0 )
            goto after_while;
          buf.fram_addr = __builtin_bswap16( start_address );
          if( ( l = write( dev, &buf, l + sizeof( u16 ) ) ) <= 0 )
            goto after_while;
          l -= sizeof( u16 );
          break;
        case OP_COMPARE:
          buf.fram_addr = __builtin_bswap16( start_address );
          write( dev, &buf.fram_addr, sizeof( u16 ) );
          if( ( l = read( dev, buf.dev, l ) ) <= 0 )
            goto after_while;
          if( ( l = read( bin, buf.bin, l ) ) <= 0 )
            goto after_while;
          if( ( d = compare( start_address, l ) ) < 0 )
          {
            diffs -= d;
            goto after_while;
          }
          diffs += d;
          break;
      }
      mem_length -= l;
      real_len += l;
      start_address += l;
    }
  after_while:
    switch ( sw.operation )
    {
      case OP_READ:
        printf( "%d bytes of FRAM dumped\n", real_len );
        break;
      case OP_WRITE:
        printf( "%d bytes of FRAM written\n", real_len );
        break;
      case OP_COMPARE:
        if( diffs )
          printf( "FRAM and %s differ by %d bytes\n", image_bin, diffs );
        else
          printf( "FRAM matches %s\n", image_bin );
        break;
    }
  }
  close( bin );
  close( dev );
  return 0;
}
