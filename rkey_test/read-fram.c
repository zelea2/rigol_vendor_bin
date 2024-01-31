#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <linux/i2c-dev.h>

unsigned char buf[0x2000];

int
main(  )
{
  int           fd, len;

  if( ( fd = open( "/dev/i2c-4", O_RDWR ) ) < 0 )
  {
    exit( -1 );
  }
  if( ioctl( fd, I2C_SLAVE, 0x50 ) < 0 )        // The I2C FRAM address
  {
    exit( -2 );
  }
  puts( "I2C FRAM device is ready" );
  write( fd, buf, 2 ); // FRAM start address (0x0000)
  // using I2C Read, equivalent of i2c_smbus_read_byte(fd)
  if( ( len = read( fd, buf, 0x2000 ) ) <= 0 )
  {
    exit( -3 );
  }
  close( fd );
  if( ( fd = creat( "FRAM.bin", 0644 ) ) < 0 )
  {
    exit( -4 );
  }
  write( fd, buf, len );
  close( fd );
  puts( "FRAM dumped" );
  exit( 0 );
}
