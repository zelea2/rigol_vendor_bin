#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define LIC_PATH _ZN11CApiLicense12LICENSE_PATHE_ptr
#define API_SetStr2Hex _Z14API_SetStr2Hex7RStringPcRi
#define RString_toUpper _ZN7RString7toUpperEv
#define CApiLicense_verifyOption _ZN11CApiLicense12verifyOptionEP8COptInfoR7RStringS3_
#define CApiLicense_getLicenseKey _ZN11CApiLicense13getLicenseKeyER7RStringS1_
#define CApiLicense_verifyLicense _ZN11CApiLicense13verifyLicenseEv

char         *LIC_PATH;

typedef union
{
  char          short_string[128]; // allow up to 127 chars for short strings
  struct __attribute__( ( packed ) )
  {
    unsigned char sh_len;
    char          sh_str[7];
    size_t        len;
    char         *str;
  };
} RString;

#define COptInfo void
#define CApiLicense void

int           API_SetStr2Hex( RString, char *, int * );
int           RString_toUpper( RString );
int           CApiLicense_verifyLicense(CApiLicense * this);
int           CApiLicense_getLicenseKey( CApiLicense *this, RString *, RString * );
int           CApiLicense_verifyOption( CApiLicense *this, COptInfo *, 
    RString *, RString * );

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
  RString       z;
  CApiLicense  *unk;	// unknown structure
  unsigned char hex[32];
  int           i, hlen;

#if 0
  set_RString( &z, "hello rstring" );
  RString_toUpper( z );

  set_RString( &z, "aa33556622" );
  API_SetStr2Hex( z, hex, &hlen );
  for( i = 0; i < hlen; i++ )
    printf( "hex 0x%02x\n", hex[i] );
#else  
  unk = malloc(1000); // license key is an RString at offset 416
  CApiLicense_verifyLicense( unk );
#endif
  return 1;
}
