#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

mode_t
__umask_chk( mode_t mode )
{
  return umask( mode );
}

char         *
__strchr_chk( const char *p, int ch, size_t s_len )
{
  return strchr( p, ch );
}

char         *
__strrchr_chk( const char *p, int ch, size_t s_len )
{
  return strrchr( p, ch );
}

int
__open_2( const char *pathname, int flags )
{
  return open( pathname, flags );
}

ssize_t
__read_chk( int fd, void *buf, size_t count, size_t buf_size )
{
  return read( fd, buf, count );
}

ssize_t
__write_chk( int fd, void *buf, size_t count, size_t buf_size )
{
  return write( fd, buf, count );
}
