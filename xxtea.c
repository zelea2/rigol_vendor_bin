#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <sys/stat.h>
#include "rigol_vendor_bin.h"

#define XXTEA_MX ((z>>5 ^ y<<2) + (y>>3 ^ z<<4)) \
                 ^ ((sum ^ y) + (k[(p&3)^e] ^ z))
#define XXTEA_DELTA 0x9e3779b9

static void
xxtea_long_encrypt( u32 *v, u32 len, u32 *k )
{
  u32       n = len - 1;
  u32       z = v[n], y = v[0], p, q = 6 + 52 / ( n + 1 ), sum = 0, e;
  if( n < 1 )
  {
    return;
  }
  while( 0 < q-- )
  {
    sum += XXTEA_DELTA;
    e = sum >> 2 & 3;
    for( p = 0; p < n; p++ )
    {
      y = v[p + 1];
      z = v[p] += XXTEA_MX;
    }
    y = v[0];
    z = v[n] += XXTEA_MX;
  }
}

static void
xxtea_long_decrypt( u32 *v, u32 len, u32 *k )
{
  u32       n = len - 1;
  u32       z = v[n], y = v[0], e, p, q = 6 + 52 / ( n + 1 );
  u32       sum = q * XXTEA_DELTA;
  if( n < 1 )
  {
    return;
  }
  while( sum != 0 )
  {
    e = sum >> 2 & 3;
    for( p = n; p > 0; p-- )
    {
      z = v[p - 1];
      y = v[p] -= XXTEA_MX;
    }
    z = v[n];
    y = v[0] -= XXTEA_MX;
    sum -= XXTEA_DELTA;
  }
}

static u32 *
xxtea_to_long_array( const u8 *data, u32 len, u32 *ret_len )
{
  u32       i, n, *result;
  n = len >> 2;
  n = ( ( ( len & 3 ) == 0 ) ? n : n + 1 );
  result = ( u32 * ) malloc( n << 2 );
  *ret_len = n;
  memset( result, 0, n << 2 );
  for( i = 0; i < len; i++ )
    result[i >> 2] |= ( u32 ) data[i] << ( ( i & 3 ) << 3 );
  return result;
}

static u8 *
xxtea_to_byte_array( u32 *data, u32 len, u32 *ret_len )
{
  u32       i, n;
  u8      *result;
  n = len << 2;
  result = ( u8 * ) malloc( n + 1 );
  for( i = 0; i < n; i++ )
    result[i] = ( u8 ) ( ( data[i >> 2] >> ( ( i & 3 ) << 3 ) ) & 0xff );
  result[n] = '\0';
  *ret_len = n;
  return result;
}

u8      *
xxtea_encrypt( const u8 *data, u32 len, u8 *key, u32 *ret_len )
{
  u8      *result;
  u32      *v, *k, v_len, k_len;
  v = xxtea_to_long_array( data, len, &v_len );
  k = xxtea_to_long_array( key, 16, &k_len );
  xxtea_long_encrypt( v, v_len, k );
  result = xxtea_to_byte_array( v, v_len, ret_len );
  free( v );
  free( k );
  return result;
}

u8      *
xxtea_decrypt( const u8 *data, u32 len, u8 *key, u32 *ret_len )
{
  u8      *result;
  u32      *v, *k, v_len, k_len;
  v = xxtea_to_long_array( data, len, &v_len );
  k = xxtea_to_long_array( key, 16, &k_len );
  xxtea_long_decrypt( v, v_len, k );
  result = xxtea_to_byte_array( v, v_len, ret_len );
  free( v );
  free( k );
  return result;
}
