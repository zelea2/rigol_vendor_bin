#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>
#include <string.h>
#include <stdint.h>
#include <time.h>
#include <getopt.h>
#include <sys/stat.h>
#include "rigol_vendor_bin.h"
#include "aes.h"

u32           file_key[4] =
    { 0xAB12CD34, 0xAB12CD34, 0xAB12CD34, 0xAB12CD34 };
u32           default_key[4] =
    { 0x03920001, 0x08410841, 0x18C32104, 0x318639C7 };

char         *type_str[] = { NULL, NULL, NULL, NULL, NULL,
  "MODEL", NULL, "SN", NULL, "MAC"
};

#define DELIM "-----------------------------------------------------------\n"
#define MAX_STRING_SIZE 44

struct entry
{
  u32           esize;
  u32           type;
  u32           fsize;
  u32           crc;
  u32           dsize;
  u32           strlen;
};
#define OFF(x) offsetof( struct entry, x)

struct vendor
{
  char         *model;
  int           modelnr;
  char         *sn;
  int           serialnr;
  char         *mac;
  int           mac_low_nibbles;
  char         *option;
  u8            aes_key[32];
} Vendor;

int           debug;

int
check_model( void )
{
  char        **p;
  int           i;
  if( Vendor.model == NULL )
    return 0;
  Vendor.modelnr = 0;
  for( p = scope_models; *p; p++ )
  {
    if( !strcmp( *p, Vendor.model ) )
      return 1;
    Vendor.modelnr++;
  }
  fprintf( stderr,
      "Invalid model number; it must be one of the following:\n" );
  p = scope_models;
  for( p = scope_models, i = 0; i < Vendor.modelnr; i++, p++ )
  {
    fprintf( stderr, "%-9s", *p );
    if( ( i & 7 ) == 7 )
      fprintf( stderr, "\n" );
  }
  if( ( i & 7 ) != 0 )
    fprintf( stderr, "\n" );
  Vendor.model = NULL;
  Vendor.modelnr = -1;
  return -1;
}

int
decode_vendor( u8 *d, u32 flen )
{
  struct entry  e;
  u32           crc, fcrc, len, dlen, off;
  u8           *data, *dbuf;

  crc = *( u32 * ) ( d + 0 );
  len = *( u32 * ) ( d + 4 );
  fcrc = crc32( d + 2 * sizeof( u32 ), len );
  printf( DELIM );
  printf( "%04X  CRC32: %08X", 0, crc );
  printf( " (%s)\n", crc == fcrc ? "OK" : "Fail" );
  printf( "%04X  Length: %d", 4, len );
  printf( " (%s)\n", len + 2 * sizeof( u32 ) == flen ? "OK" : "Fail" );
  if( len + 2 * sizeof( u32 ) != flen )
    return -10;
  if( crc != fcrc )
    return -11;
  off = 2 * sizeof( u32 );
  while( len )
  {
    printf( DELIM );
    memcpy( &e, d + off, sizeof( struct entry ) );
    if( e.fsize > len )
      return -12;
    printf( "%04X  EntrySize: %d\n", off + OFF( esize ), e.esize );
    printf( "%04X  Type: %d (%s)\n", off + OFF( type ), e.type,
        type_str[e.type] );
    printf( "%04X  FieldSize: %d\n", off + OFF( fsize ), e.fsize );
    printf( "%04X  CRC32: %08X", off + OFF( crc ), e.crc );
    crc = crc32( d + off + OFF( strlen ), e.fsize - 2 * sizeof( u32 ) );
    printf( " (%s)\n", crc == e.crc ? "OK" : "Fail" );
    printf( "%04X  DataSize: %d\n", off + OFF( dsize ), e.dsize );
    printf( "%04X  StringLen: %d\n", off + OFF( strlen ), e.strlen );
    data = malloc( e.dsize );
    memcpy( data, d + off + sizeof( struct entry ), e.dsize );
    dbuf = xxtea_decrypt( data, e.dsize, ( u8 * ) default_key, &dlen );
    free( data );
    dbuf[e.strlen] = 0;
    printf( "%04X  String: %s\n", off + sizeof( struct entry ), dbuf );
    switch ( e.type )
    {
      case 5:
        if( Vendor.modelnr == -1 )
        {
          Vendor.model = strdup( dbuf );
          if( check_model(  ) <= 0 )
            printf( "Invalid model %s\n", Vendor.model );
        }
        break;
      case 7:
        if( Vendor.serialnr == -1 )
          Vendor.serialnr = atoi( &dbuf[e.strlen - 7] );
        break;
      case 9:
        if( Vendor.mac_low_nibbles == -1 )
          Vendor.mac_low_nibbles = strtoll( &dbuf[e.strlen - 5], NULL, 16 );
        break;
    }
    free( dbuf );
    off += e.dsize + sizeof( struct entry );
    len -= e.dsize + sizeof( struct entry );
  }
  printf( DELIM );
  if( debug )
    printf( "%04X\n", off );
  return 0;
}

int
encode_vendor( u8 **d, u32 *flen )
{
  struct entry *e;
  u8           *str, *data, *ebuf;
  u32           elen;
  int           n;

  *flen = 2 * sizeof( u32 ) +
      3 * ( sizeof( struct entry ) + MAX_STRING_SIZE );
  if( ( *d = malloc( *flen ) ) == NULL )
    return -1;
  for( n = 0; n < 3; n++ )
  {
    data = *d + 2 * sizeof( u32 ) +
        n * ( sizeof( struct entry ) + MAX_STRING_SIZE );
    e = ( struct entry * ) data;
    data += sizeof( struct entry );
    switch ( n )
    {
      case 0:
        e->type = 5;
        str = Vendor.model;
        break;
      case 1:
        e->type = 7;
        str = Vendor.sn;
        break;
      case 2:
        e->type = 9;
        str = Vendor.mac;
        break;
    }
    e->esize = 4;
    e->strlen = strlen( str );
    ebuf = xxtea_encrypt( str, MAX_STRING_SIZE, ( u8 * ) default_key, &elen );
    memcpy( data, ebuf, elen );
    free( ebuf );
    e->dsize = elen;
    e->crc = crc32( data - sizeof( u32 ), e->dsize + sizeof( u32 ) );
    e->fsize = e->dsize + 3 * sizeof( u32 );
  }
  elen = *flen - 2 * sizeof( u32 );
  *( u32 * ) ( *d + 0 ) = crc32( *d + 2 * sizeof( u32 ), elen );
  *( u32 * ) ( *d + 4 ) = elen;
  return 0;
}

int
decrypt_vendor( char *bin, char *dec )
{
  FILE         *f;
  struct stat   st;
  u8           *buf, *obuf;
  u32           len, olen;
  int           ret;

  if( stat( bin, &st ) )
    return -1;
  len = st.st_size;
  if( ( buf = malloc( len ) ) == NULL )
    return -2;
  f = fopen( bin, "rb" );
  len = fread( buf, 1, len, f );
  fclose( f );
  olen = 0;
  obuf = xxtea_decrypt( buf, len, ( u8 * ) file_key, &olen );
  if( debug )
  {
    f = fopen( dec, "wb" );
    len = fwrite( obuf, 1, olen, f );
    fclose( f );
  }
  ret = decode_vendor( obuf, olen );
  free( obuf );
  return ret;
}

int
encrypt_vendor( char *bin, char *enc )
{
  FILE         *f;
  u32           len, olen;
  int           ret;
  u8           *buf, *obuf;

  buf = NULL;
  ret = encode_vendor( &buf, &len );
  if( ret )
    return ret;
  olen = 0;
  obuf = xxtea_encrypt( buf, len, ( u8 * ) file_key, &olen );
  free( buf );
  f = fopen( enc, "wb" );
  len = fwrite( obuf, 1, olen, f );
  fclose( f );
  free( obuf );
  printf( "New \"%s\" file has been created\nYou may rename it to \"%s\"\n"
      "and install it on your scope Rigol partition\n", enc, bin );
  return 0;
}

int
check_vendor( void )
{
  char         *p;
  int           l;
  if( Vendor.modelnr == -1 )
  {
    fprintf( stderr, "\nAt least the scope model (-M) must be supplied\n" );
    return -1;
  }
  if( Vendor.serialnr <= 0 )
  {
    Vendor.serialnr = rand(  );
    Vendor.serialnr %= 10000000;
  }
  if( Vendor.mac_low_nibbles <= 0 )
  {
    Vendor.mac_low_nibbles = rand(  );
    Vendor.mac_low_nibbles &= 0xfffff;
  }
  Vendor.model = calloc( 1, MAX_STRING_SIZE );
  Vendor.sn = calloc( 1, MAX_STRING_SIZE );
  Vendor.mac = calloc( 1, MAX_STRING_SIZE );
  if( Vendor.model == NULL || Vendor.sn == NULL || Vendor.mac == NULL )
    return -2;
  strcpy( Vendor.model, scope_models[Vendor.modelnr] );
  for( p = Vendor.model; *p && *p > '9'; p++ )
    ;
  if( *p == 0 )
    return -3;
  l = p + 1 - Vendor.model;
  l %= 9;
  strncpy( Vendor.sn, Vendor.model, l );
  strcpy( Vendor.sn + l, "A25" );
  sprintf( Vendor.sn + l + 3, "%07d", Vendor.serialnr );
  strcpy( Vendor.mac, "0019AFA" );
  sprintf( Vendor.mac + 7, "%05X", Vendor.mac_low_nibbles );
  printf( "Model: %s\n", Vendor.model );
  printf( "SN:    %s\n", Vendor.sn );
  printf( "MAC:   %s\n", Vendor.mac );
  return 0;
}

int
decrypt_keydata( char *bin, char *dec )
{
  FILE         *f;
  struct stat   st;
  char         *s;
  u8           *buf, *obuf;
  u32           len, olen;

  if( stat( bin, &st ) )
    return -1;
  len = st.st_size;
  if( ( buf = malloc( len ) ) == NULL )
    return -2;
  f = fopen( bin, "rb" );
  len = fread( buf, 1, len, f );
  fclose( f );
  olen = 0;
  obuf = xxtea_decrypt( buf, len, ( u8 * ) default_key, &olen );
  if( ( s = strchr( obuf, ';' ) ) == NULL )
    return -3;
  memcpy( Vendor.aes_key, s + 1, 32 );  // AES key as ASCII not hex!!!
  if( debug )
  {
    f = fopen( dec, "wb" );
    len = fwrite( obuf, 1, olen, f );
    fclose( f );
  }
  free( obuf );
  return 0;
}

void
generate_options( char *model )
{
  aes_context   ctx;
  char        **opt, *family;
  u8            xxx[3 * 16], nib;
  char          res[3 * 2 * 16 + 1];
  int           i;

  printf( DELIM );
  printf( "Generating options for %s\n", model );
  printf( DELIM );
  family = strdup( model );
  for( i = 0; family[i]; i++ )
    if( family[i] <= '9' )
      break;
  for( i++; family[i]; i++ )
    if( family[i] <= '9' )
      family[i] = '0';
    else
      family[i] = 0;
  aes_setkey_enc( &ctx, Vendor.aes_key, 32 * 8 );
  for( opt = scope_options; *opt; opt++ )
  {
    if( Vendor.option && strcmp( *opt, Vendor.option ) )
      continue;
    memset( xxx, 0, 3 * 16 );
    sprintf( xxx, "%s#0#%s#4#0#0", model, *opt );
    for( i = 0; i < 3; i++ )
      aes_encrypt( &ctx, xxx + i * 16, xxx + i * 16 );
    for( i = 0; i < 3 * 16; i++ )
    {
      // u8 to lsb hex 
      nib = xxx[i] & 0xf;
      nib += '0';
      if( nib > '9' )
        nib += 0x27;
      res[2 * i] = nib;
      nib = ( xxx[i] >> 4 ) & 0xf;
      nib += '0';
      if( nib > '9' )
        nib += 0x27;
      res[2 * i + 1] = nib;
    }
    res[3 * 2 * 16] = 0;
    printf( ":SYST:OPT:INST %s-%s@%s\n", family, *opt, res );
  }
}

void
usage( char *progname )
{
  fprintf( stderr, "\n%s [options] [vendor_bin_file]\n", progname );
  fprintf( stderr, "\t-M #\tset scope model\n" );
  fprintf( stderr, "\t-n\trandom serial number\n" );
  fprintf( stderr, "\t-N #\tset serial number\n" );
  fprintf( stderr, "\t-a\trandom MAC address\n" );
  fprintf( stderr, "\t-A #\tset MAC address\n" );
  fprintf( stderr, "\t-o\tgenerate all option strings (uses 'Key.data')\n" );
  fprintf( stderr, "\t-O #\tgenerate option string for feature #\n" );
  fprintf( stderr, "\t-d\tdebug switch\n" );
  exit( 0 );
}

int
main( int argc, char *argv[] )
{
  char         *p, *vendor_bin, *vendor_enc, *vendor_dec;
  int           l, ret, reencode, options, option;

  fprintf( stderr, "\n%s v%s - %s\n", TITLE, VERSION, AUTHOR );

  srand( time( 0 ) );
  reencode = 0;
  options = 0;
  Vendor.modelnr = -1;
  Vendor.serialnr = -1;
  Vendor.mac_low_nibbles = -1;

  do
  {
    option = getopt( argc, argv, "hdM:nN:aA:oO:" );
    switch ( option )
    {
      case 'd':
        debug++;
        break;
      case 'M':
        Vendor.model = strdup( optarg );
        if( check_model(  ) < 0 )
          usage( argv[0] );
        reencode = 1;
        break;
      case 'n':
        Vendor.serialnr = rand(  );
        Vendor.serialnr %= 10000000;
        reencode = 1;
        break;
      case 'N':
        Vendor.serialnr = atoi( optarg );
        if( !Vendor.serialnr )
          Vendor.serialnr = rand(  );
        Vendor.serialnr %= 10000000;
        reencode = 1;
        break;
      case 'a':
        Vendor.mac_low_nibbles = rand(  );
        Vendor.mac_low_nibbles &= 0xfffff;
        reencode = 1;
        break;
      case 'A':
        Vendor.mac_low_nibbles = strtoll( optarg, NULL, 16 );
        if( !Vendor.mac_low_nibbles )
          Vendor.mac_low_nibbles = rand(  );
        Vendor.mac_low_nibbles &= 0xfffff;
        reencode = 1;
        break;
      case 'o':
        options = 1;
        break;
      case 'O':
        Vendor.option = strdup( optarg );
        options = 1;
        break;
      case 'h':
        usage( argv[0] );
        break;
      case EOF:                // no more options
        break;
      default:
        fprintf( stderr, "getopt returned impossible value: %d ('%c')",
            option, option );
        usage( argv[0] );
    }
  }
  while( option != EOF );

  if( optind == argc )
    vendor_bin = "vendor.bin";
  else
    vendor_bin = argv[optind++];
  vendor_enc = strdup( vendor_bin );
  vendor_dec = strdup( vendor_bin );
  if( ( p = strrchr( vendor_bin, '.' ) ) != NULL )
    l = p - vendor_bin;
  else
    l = strlen( vendor_bin ) - 4;
  strcpy( vendor_enc + l, ".enc" );
  strcpy( vendor_dec + l, ".dec" );

  decrypt_vendor( vendor_bin, vendor_dec );
  if( ( ret = check_vendor(  ) ) < 0 )
    usage( argv[0] );
  if( reencode && ( ret = encrypt_vendor( vendor_bin, vendor_enc ) ) < 0 )
    return ret;
  if( options )
  {
    if( decrypt_keydata( "Key.data", "Key.dec" ) < 0 )
      return ret;
    generate_options( Vendor.model );
  }
  return 0;
}
