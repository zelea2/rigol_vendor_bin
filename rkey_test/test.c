#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <dlfcn.h>

// I could have written this test in C++ to avoid all the demangling mess bellow
// but I wasn't 100% sure about all the functions prototype

#define API_SetStr2Hex _Z14API_SetStr2Hex7RStringPcRi
#define RString_toUpper _ZN7RString7toUpperEv
#define RString_remove _ZN7RString6removeEii
#define CApiLicense_constructor _ZN11CApiLicenseC2E7RStringi
#define CApiLicense_verifyOption _ZN11CApiLicense12verifyOptionEP8COptInfoR7RStringS3_
#define CApiLicense_getLicenseKey _ZN11CApiLicense13getLicenseKeyER7RStringS1_
#define CApiLicense_verifyLicense _ZN11CApiLicense13verifyLicenseEv
#define CApiLicense_init _ZN11CApiLicense4initEv
#define CApiLicense_generate_something _ZN11CApiLicense18generate_somethingEm
#define COptInfo_constructor _ZN8COptInfoC2E7OptTypei
#define COptInfo_setName _ZN8COptInfo7setNameERK7RString
#define COptInfo_setLicense _ZN8COptInfo10setLicenseERK7RString

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

typedef struct
{
  unsigned char opt[0x68];
} COptInfo;

int           API_SetStr2Hex( RString, unsigned char *, int * );
int           RString_toUpper( RString * );
int           RString_remove( RString *, int from, int len, RString * );
void          CApiLicense_constructor( CApiLicense * this, RString, int );
int           CApiLicense_init( CApiLicense * this );
int           CApiLicense_verifyLicense( CApiLicense * this );
int           CApiLicense_getLicenseKey( CApiLicense * this, RString *,
    RString * );
int           CApiLicense_verifyOption( CApiLicense * this, COptInfo *,
    RString *, RString * );
int           CApiLicense_generate_something( CApiLicense * this,
    long long len, void **vect );
void          COptInfo_constructor( COptInfo *, int, int );
const RString *COptInfo_setName( COptInfo *, RString * );
const RString *COptInfo_setLicense( COptInfo *, RString * );

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
  COptInfo      Opt;
  unsigned char hex[32];
  void         *v;
  int           i, pass, fd, hlen;

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
  CApiLicense_constructor( &AL, z, 0x24 );
  CApiLicense_init( &AL );
  set_RString( &a, "key" );
  set_RString( &b, "seed" );
  CApiLicense_getLicenseKey( &AL, &a, &b );
  printf( "key: %s\n", get_RString( &a, NULL ) );
  printf( "seed: %s\n", get_RString( &b, NULL ) );
  COptInfo_constructor( &Opt, 19, 0 << 6 ); // RLU = 19
  set_RString( &z, "RLU" );
  COptInfo_setName( &Opt, &z );
  set_RString( &z, "d272eae068c46792d961e7589d3ee0bb5bc962346bb4b8f4d929b17e6049cda4b7d2a20db5e0e9b4473b6999f080b6c80123456701234567");
  COptInfo_setLicense( &Opt, &z );
  set_RString( &b, "null" );
  pass = CApiLicense_verifyOption( &AL, &Opt, &a, &b );
  printf( "b: %s\n", get_RString( &b, NULL ) );
  printf( "vfy %d\n", pass );
  fd = creat( "AL.bin", 0644 );
  write( fd, &AL, sizeof( CApiLicense ) );
  close( fd );
  fd = creat( "Opt.bin", 0644 );
  write( fd, &Opt, sizeof( COptInfo ) );
  close( fd );
#endif
  return 0;
}
