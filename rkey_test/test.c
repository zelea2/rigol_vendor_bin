#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <dlfcn.h>

#define LIC_PATH _ZN11CApiLicense12LICENSE_PATHE_ptr
#define API_SetStr2Hex _Z14API_SetStr2Hex7RStringPcRi
#define RString_toUpper _ZN7RString7toUpperEv
#define CApiLicense_verifyOption _ZN11CApiLicense12verifyOptionEP8COptInfoR7RStringS3_
#define CApiLicense_getLicenseKey _ZN11CApiLicense13getLicenseKeyER7RStringS1_
#define CApiLicense_verifyLicense _ZN11CApiLicense13verifyLicenseEv
#define CApiLicense_init _ZN11CApiLicense4initEv
#define CApiLicense_CApiLicense _ZN11CApiLicenseC2E7RStringi
#define CApiLicense_generate_something _ZN11CApiLicense18generate_somethingEm

char         *LIC_PATH;

typedef union
{
  char          short_string[128];	// allow up to 127 chars for short
  // strings
  struct __attribute__( ( packed ) )
  {
    unsigned char sh_len;
    char          sh_str[7];
    size_t        len;
    char         *str;
  };
} RString;

typedef struct
{
  unsigned char lic[0x1B8];
} CApiLicense;

#define COptInfo void

int           API_SetStr2Hex( RString, unsigned char *, int * );
int           RString_toUpper( RString * );
int           CApiLicense_init( CApiLicense * this );
int           CApiLicense_verifyLicense( CApiLicense * this );
int           CApiLicense_getLicenseKey( CApiLicense * this, RString *,
    RString * );
int           CApiLicense_verifyOption( CApiLicense * this, COptInfo *,
    RString *, RString * );
void          CApiLicense_CApiLicense( CApiLicense * this, RString, int );
int           CApiLicense_generate_something( CApiLicense * this, long long len, void **vect );

void
set_RString( RString *r, char *str )
{
  int           l = strlen( str );

  if( l < 128 )
  {
    r->sh_len = l << 1;
    strcpy( r->sh_str, str );
  }
  else
  {
    r->sh_len = 1;
    r->len = l;
    r->str = strdup( str );
  }
}

char         *
get_RString( RString *r, int *len )
{
  if( r->sh_len & 1 )
  {
    if( len )
      *len = r->len;
    return r->str;
  }
  else
  {
    if( len )
      *len = r->sh_len >> 1;
    return r->sh_str;
  }
}

int
main( int argc, char *argv[] )
{
  RString       z, a, b;
  CApiLicense   AL;
  unsigned char hex[32];
  void         *v;
  int           i, fd, hlen;

  printf( "Start main\n" );
  dlopen( "libscope-auklet.so", RTLD_NOW );
#if 0
  set_RString( &z, "hello rstring" );
  RString_toUpper( &z );
  printf( "%s\n", get_RString( &z, NULL ) );
  set_RString( &z, "aa33556622" );
  API_SetStr2Hex( z, hex, &hlen );
  for( i = 0; i < hlen; i++ )
    printf( "hex 0x%02x\n", hex[i] );
#else
  printf( "lic init\n" );
  set_RString( &z, "License" );
  CApiLicense_CApiLicense( &AL, z, 0x24 );
  CApiLicense_init( &AL );
  set_RString( &a, "key" );
  set_RString( &b, "seed" );
  CApiLicense_getLicenseKey( &AL, &a, &b );
  printf( "key: %s\n", get_RString( &a, NULL ) );
  printf( "seed: %s\n", get_RString( &b, NULL ) );
  fd = creat( "AL.bin", 0644 );
  write( fd, &AL, sizeof( CApiLicense ) );
  close( fd );
#endif
  return 0;
}
