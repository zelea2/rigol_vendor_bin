#include <stdio.h>
#include <string.h>
#include "aes.h"

/*
 * 32-bit integer manipulation macros (little endian)
 */
#ifndef GET_UINT32_LE
#define GET_UINT32_LE(n,b,i)				\
{							\
    (n) = ( (uint32_t) (b)[(i)	  ]	  )		\
	| ( (uint32_t) (b)[(i) + 1] <<	8 )		\
	| ( (uint32_t) (b)[(i) + 2] << 16 )		\
	| ( (uint32_t) (b)[(i) + 3] << 24 );		\
}
#endif

#ifndef PUT_UINT32_LE
#define PUT_UINT32_LE(n,b,i)					\
{								\
    (b)[(i)    ] = (unsigned char) ( ( (n)	 ) & 0xFF );	\
    (b)[(i) + 1] = (unsigned char) ( ( (n) >>  8 ) & 0xFF );	\
    (b)[(i) + 2] = (unsigned char) ( ( (n) >> 16 ) & 0xFF );	\
    (b)[(i) + 3] = (unsigned char) ( ( (n) >> 24 ) & 0xFF );	\
}
#endif

/*
 * Forward S-box & tables
 */
static unsigned char FSb[256];
static uint32_t FT0[256];

/*
 * Reverse S-box & tables
 */
static unsigned char RSb[256];
static uint32_t RT0[256];

/*
 * Round constants
 */
static uint32_t RCON[10];

/*
 * Tables generation code
 */
#define ROTL8(x) ( ( (x) << 8 ) & 0xFFFFFFFF ) | ( (x) >> 24 )
#define XTIME(x) ( ( (x) << 1 ) ^ ( ( (x) & 0x80 ) ? 0x1B : 0x00 ) )
#define MUL(x,y) ( ( (x) && (y) ) ? pow[(log[(x)]+log[(y)]) % 255] : 0 )

static int    aes_init_done = 0;

static void
aes_gen_tables( void )
{
  int           i, x, y, z;
  int           pow[256];
  int           log[256];

  /* 
   * compute pow and log tables over GF(2^8)
   */
  for( i = 0, x = 1; i < 256; i++ )
  {
    pow[i] = x;
    log[x] = i;
    x = ( x ^ XTIME( x ) ) & 0xFF;
  }

  /* 
   * calculate the round constants
   */
  for( i = 0, x = 1; i < 10; i++ )
  {
    RCON[i] = ( uint32_t ) x;
    x = XTIME( x ) & 0xFF;
  }

  /* 
   * generate the forward and reverse S-boxes
   */
  FSb[0x00] = 0x63;
  RSb[0x63] = 0x00;

  for( i = 1; i < 256; i++ )
  {
    x = pow[255 - log[i]];

    y = x;
    y = ( ( y << 1 ) | ( y >> 7 ) ) & 0xFF;
    x ^= y;
    y = ( ( y << 1 ) | ( y >> 7 ) ) & 0xFF;
    x ^= y;
    y = ( ( y << 1 ) | ( y >> 7 ) ) & 0xFF;
    x ^= y;
    y = ( ( y << 1 ) | ( y >> 7 ) ) & 0xFF;
    x ^= y ^ 0x63;

    FSb[i] = ( unsigned char ) x;
    RSb[x] = ( unsigned char ) i;
  }

  /* 
   * generate the forward and reverse tables
   */
  for( i = 0; i < 256; i++ )
  {
    x = FSb[i];
    y = XTIME( x ) & 0xFF;
    z = ( y ^ x ) & 0xFF;

    FT0[i] = ( ( uint32_t ) y ) ^
        ( ( uint32_t ) x << 8 ) ^
        ( ( uint32_t ) x << 16 ) ^ ( ( uint32_t ) z << 24 );

    x = RSb[i];

    RT0[i] = ( ( uint32_t ) MUL( 0x0E, x ) ) ^
        ( ( uint32_t ) MUL( 0x09, x ) << 8 ) ^
        ( ( uint32_t ) MUL( 0x0D, x ) << 16 ) ^
        ( ( uint32_t ) MUL( 0x0B, x ) << 24 );

  }
}

#undef ROTL8

#define ROTL8(x)  ( (uint32_t)( ( x ) <<  8 ) + (uint32_t)( ( x ) >> 24 ) )
#define ROTL16(x) ( (uint32_t)( ( x ) << 16 ) + (uint32_t)( ( x ) >> 16 ) )
#define ROTL24(x) ( (uint32_t)( ( x ) << 24 ) + (uint32_t)( ( x ) >>  8 ) )

#define AES_RT0(idx) RT0[idx]
#define AES_RT1(idx) ROTL8(  RT0[idx] )
#define AES_RT2(idx) ROTL16( RT0[idx] )
#define AES_RT3(idx) ROTL24( RT0[idx] )

#define AES_FT0(idx) FT0[idx]
#define AES_FT1(idx) ROTL8(  FT0[idx] )
#define AES_FT2(idx) ROTL16( FT0[idx] )
#define AES_FT3(idx) ROTL24( FT0[idx] )

/*
 * AES key schedule (encryption)
 */
int
aes_setkey_enc( aes_context *ctx, const unsigned char *key,
    unsigned int keybits )
{
  unsigned int  i;
  uint32_t     *RK;

  switch ( keybits )
  {
    case 128:
      ctx->nr = 10;
      break;
    case 192:
      ctx->nr = 12;
      break;
    case 256:
      ctx->nr = 14;
      break;
    default:
      return -1;
  }

  if( aes_init_done == 0 )
  {
    aes_gen_tables(  );
    aes_init_done = 1;
  }

  ctx->rk = RK = ctx->buf;

  for( i = 0; i < ( keybits >> 5 ); i++ )
  {
    GET_UINT32_LE( RK[i], key, i << 2 );
  }

  switch ( ctx->nr )
  {
    case 10:

      for( i = 0; i < 10; i++, RK += 4 )
      {
        RK[4] = RK[0] ^ RCON[i] ^
            ( ( uint32_t ) FSb[( RK[3] >> 8 ) & 0xFF] ) ^
            ( ( uint32_t ) FSb[( RK[3] >> 16 ) & 0xFF] << 8 ) ^
            ( ( uint32_t ) FSb[( RK[3] >> 24 ) & 0xFF] << 16 ) ^
            ( ( uint32_t ) FSb[( RK[3] ) & 0xFF] << 24 );

        RK[5] = RK[1] ^ RK[4];
        RK[6] = RK[2] ^ RK[5];
        RK[7] = RK[3] ^ RK[6];
      }
      break;

    case 12:

      for( i = 0; i < 8; i++, RK += 6 )
      {
        RK[6] = RK[0] ^ RCON[i] ^
            ( ( uint32_t ) FSb[( RK[5] >> 8 ) & 0xFF] ) ^
            ( ( uint32_t ) FSb[( RK[5] >> 16 ) & 0xFF] << 8 ) ^
            ( ( uint32_t ) FSb[( RK[5] >> 24 ) & 0xFF] << 16 ) ^
            ( ( uint32_t ) FSb[( RK[5] ) & 0xFF] << 24 );

        RK[7] = RK[1] ^ RK[6];
        RK[8] = RK[2] ^ RK[7];
        RK[9] = RK[3] ^ RK[8];
        RK[10] = RK[4] ^ RK[9];
        RK[11] = RK[5] ^ RK[10];
      }
      break;

    case 14:

      for( i = 0; i < 7; i++, RK += 8 )
      {
        RK[8] = RK[0] ^ RCON[i] ^
            ( ( uint32_t ) FSb[( RK[7] >> 8 ) & 0xFF] ) ^
            ( ( uint32_t ) FSb[( RK[7] >> 16 ) & 0xFF] << 8 ) ^
            ( ( uint32_t ) FSb[( RK[7] >> 24 ) & 0xFF] << 16 ) ^
            ( ( uint32_t ) FSb[( RK[7] ) & 0xFF] << 24 );

        RK[9] = RK[1] ^ RK[8];
        RK[10] = RK[2] ^ RK[9];
        RK[11] = RK[3] ^ RK[10];

        RK[12] = RK[4] ^
            ( ( uint32_t ) FSb[( RK[11] ) & 0xFF] ) ^
            ( ( uint32_t ) FSb[( RK[11] >> 8 ) & 0xFF] << 8 ) ^
            ( ( uint32_t ) FSb[( RK[11] >> 16 ) & 0xFF] << 16 ) ^
            ( ( uint32_t ) FSb[( RK[11] >> 24 ) & 0xFF] << 24 );

        RK[13] = RK[5] ^ RK[12];
        RK[14] = RK[6] ^ RK[13];
        RK[15] = RK[7] ^ RK[14];
      }
      break;
  }

  return ( 0 );
}

/*
 * AES key schedule (decryption)
 */
int
aes_setkey_dec( aes_context *ctx, const unsigned char *key,
    unsigned int keybits )
{
  int           i, j, ret;
  aes_context   cty;
  uint32_t     *RK;
  uint32_t     *SK;

  ctx->rk = RK = ctx->buf;

  /* Also checks keybits */
  if( ( ret = aes_setkey_enc( &cty, key, keybits ) ) != 0 )
    goto exit;

  ctx->nr = cty.nr;

  SK = cty.rk + cty.nr * 4;

  *RK++ = *SK++;
  *RK++ = *SK++;
  *RK++ = *SK++;
  *RK++ = *SK++;

  for( i = ctx->nr - 1, SK -= 8; i > 0; i--, SK -= 8 )
  {
    for( j = 0; j < 4; j++, SK++ )
    {
      *RK++ = AES_RT0( FSb[( *SK ) & 0xFF] ) ^
          AES_RT1( FSb[( *SK >> 8 ) & 0xFF] ) ^
          AES_RT2( FSb[( *SK >> 16 ) & 0xFF] ) ^
          AES_RT3( FSb[( *SK >> 24 ) & 0xFF] );
    }
  }

  *RK++ = *SK++;
  *RK++ = *SK++;
  *RK++ = *SK++;
  *RK++ = *SK++;

exit:
  return ( ret );
}

#define AES_FROUND(X0,X1,X2,X3,Y0,Y1,Y2,Y3)			\
    do								\
    {								\
	(X0) = *RK++ ^ AES_FT0( ( (Y0)	     ) & 0xFF ) ^	\
		       AES_FT1( ( (Y1) >>  8 ) & 0xFF ) ^	\
		       AES_FT2( ( (Y2) >> 16 ) & 0xFF ) ^	\
		       AES_FT3( ( (Y3) >> 24 ) & 0xFF );	\
								\
	(X1) = *RK++ ^ AES_FT0( ( (Y1)	     ) & 0xFF ) ^	\
		       AES_FT1( ( (Y2) >>  8 ) & 0xFF ) ^	\
		       AES_FT2( ( (Y3) >> 16 ) & 0xFF ) ^	\
		       AES_FT3( ( (Y0) >> 24 ) & 0xFF );	\
								\
	(X2) = *RK++ ^ AES_FT0( ( (Y2)	     ) & 0xFF ) ^	\
		       AES_FT1( ( (Y3) >>  8 ) & 0xFF ) ^	\
		       AES_FT2( ( (Y0) >> 16 ) & 0xFF ) ^	\
		       AES_FT3( ( (Y1) >> 24 ) & 0xFF );	\
								\
	(X3) = *RK++ ^ AES_FT0( ( (Y3)	     ) & 0xFF ) ^	\
		       AES_FT1( ( (Y0) >>  8 ) & 0xFF ) ^	\
		       AES_FT2( ( (Y1) >> 16 ) & 0xFF ) ^	\
		       AES_FT3( ( (Y2) >> 24 ) & 0xFF );	\
    } while( 0 )

#define AES_RROUND(X0,X1,X2,X3,Y0,Y1,Y2,Y3)		    \
    do							    \
    {							    \
	(X0) = *RK++ ^ AES_RT0( ( (Y0)	     ) & 0xFF ) ^   \
		       AES_RT1( ( (Y3) >>  8 ) & 0xFF ) ^   \
		       AES_RT2( ( (Y2) >> 16 ) & 0xFF ) ^   \
		       AES_RT3( ( (Y1) >> 24 ) & 0xFF );    \
							    \
	(X1) = *RK++ ^ AES_RT0( ( (Y1)	     ) & 0xFF ) ^   \
		       AES_RT1( ( (Y0) >>  8 ) & 0xFF ) ^   \
		       AES_RT2( ( (Y3) >> 16 ) & 0xFF ) ^   \
		       AES_RT3( ( (Y2) >> 24 ) & 0xFF );    \
							    \
	(X2) = *RK++ ^ AES_RT0( ( (Y2)	     ) & 0xFF ) ^   \
		       AES_RT1( ( (Y1) >>  8 ) & 0xFF ) ^   \
		       AES_RT2( ( (Y0) >> 16 ) & 0xFF ) ^   \
		       AES_RT3( ( (Y3) >> 24 ) & 0xFF );    \
							    \
	(X3) = *RK++ ^ AES_RT0( ( (Y3)	     ) & 0xFF ) ^   \
		       AES_RT1( ( (Y2) >>  8 ) & 0xFF ) ^   \
		       AES_RT2( ( (Y1) >> 16 ) & 0xFF ) ^   \
		       AES_RT3( ( (Y0) >> 24 ) & 0xFF );    \
    } while( 0 )

/* AES-ECB block encryption */
int
aes_encrypt( aes_context *ctx,
    const unsigned char input[16], unsigned char output[16] )
{
  int           i;
  uint32_t     *RK, X0, X1, X2, X3, Y0, Y1, Y2, Y3;

  RK = ctx->rk;

  GET_UINT32_LE( X0, input, 0 );
  X0 ^= *RK++;
  GET_UINT32_LE( X1, input, 4 );
  X1 ^= *RK++;
  GET_UINT32_LE( X2, input, 8 );
  X2 ^= *RK++;
  GET_UINT32_LE( X3, input, 12 );
  X3 ^= *RK++;

  for( i = ( ctx->nr >> 1 ) - 1; i > 0; i-- )
  {
    AES_FROUND( Y0, Y1, Y2, Y3, X0, X1, X2, X3 );
    AES_FROUND( X0, X1, X2, X3, Y0, Y1, Y2, Y3 );
  }

  AES_FROUND( Y0, Y1, Y2, Y3, X0, X1, X2, X3 );

  X0 = *RK++ ^
      ( ( uint32_t ) FSb[( Y0 ) & 0xFF] ) ^
      ( ( uint32_t ) FSb[( Y1 >> 8 ) & 0xFF] << 8 ) ^
      ( ( uint32_t ) FSb[( Y2 >> 16 ) & 0xFF] << 16 ) ^
      ( ( uint32_t ) FSb[( Y3 >> 24 ) & 0xFF] << 24 );

  X1 = *RK++ ^
      ( ( uint32_t ) FSb[( Y1 ) & 0xFF] ) ^
      ( ( uint32_t ) FSb[( Y2 >> 8 ) & 0xFF] << 8 ) ^
      ( ( uint32_t ) FSb[( Y3 >> 16 ) & 0xFF] << 16 ) ^
      ( ( uint32_t ) FSb[( Y0 >> 24 ) & 0xFF] << 24 );

  X2 = *RK++ ^
      ( ( uint32_t ) FSb[( Y2 ) & 0xFF] ) ^
      ( ( uint32_t ) FSb[( Y3 >> 8 ) & 0xFF] << 8 ) ^
      ( ( uint32_t ) FSb[( Y0 >> 16 ) & 0xFF] << 16 ) ^
      ( ( uint32_t ) FSb[( Y1 >> 24 ) & 0xFF] << 24 );

  X3 = *RK++ ^
      ( ( uint32_t ) FSb[( Y3 ) & 0xFF] ) ^
      ( ( uint32_t ) FSb[( Y0 >> 8 ) & 0xFF] << 8 ) ^
      ( ( uint32_t ) FSb[( Y1 >> 16 ) & 0xFF] << 16 ) ^
      ( ( uint32_t ) FSb[( Y2 >> 24 ) & 0xFF] << 24 );

  PUT_UINT32_LE( X0, output, 0 );
  PUT_UINT32_LE( X1, output, 4 );
  PUT_UINT32_LE( X2, output, 8 );
  PUT_UINT32_LE( X3, output, 12 );

  memset( &X0, 0, sizeof( X0 ) );
  memset( &X1, 0, sizeof( X1 ) );
  memset( &X2, 0, sizeof( X2 ) );
  memset( &X3, 0, sizeof( X3 ) );

  memset( &Y0, 0, sizeof( Y0 ) );
  memset( &Y1, 0, sizeof( Y1 ) );
  memset( &Y2, 0, sizeof( Y2 ) );
  memset( &Y3, 0, sizeof( Y3 ) );

  memset( &RK, 0, sizeof( RK ) );
  return 0;
}

/* AES-ECB block decryption */
int
aes_decrypt( aes_context *ctx,
    const unsigned char input[16], unsigned char output[16] )
{
  int           i;
  uint32_t     *RK, X0, X1, X2, X3, Y0, Y1, Y2, Y3;

  RK = ctx->rk;

  GET_UINT32_LE( X0, input, 0 );
  X0 ^= *RK++;
  GET_UINT32_LE( X1, input, 4 );
  X1 ^= *RK++;
  GET_UINT32_LE( X2, input, 8 );
  X2 ^= *RK++;
  GET_UINT32_LE( X3, input, 12 );
  X3 ^= *RK++;

  for( i = ( ctx->nr >> 1 ) - 1; i > 0; i-- )
  {
    AES_RROUND( Y0, Y1, Y2, Y3, X0, X1, X2, X3 );
    AES_RROUND( X0, X1, X2, X3, Y0, Y1, Y2, Y3 );
  }

  AES_RROUND( Y0, Y1, Y2, Y3, X0, X1, X2, X3 );

  X0 = *RK++ ^
      ( ( uint32_t ) RSb[( Y0 ) & 0xFF] ) ^
      ( ( uint32_t ) RSb[( Y3 >> 8 ) & 0xFF] << 8 ) ^
      ( ( uint32_t ) RSb[( Y2 >> 16 ) & 0xFF] << 16 ) ^
      ( ( uint32_t ) RSb[( Y1 >> 24 ) & 0xFF] << 24 );

  X1 = *RK++ ^
      ( ( uint32_t ) RSb[( Y1 ) & 0xFF] ) ^
      ( ( uint32_t ) RSb[( Y0 >> 8 ) & 0xFF] << 8 ) ^
      ( ( uint32_t ) RSb[( Y3 >> 16 ) & 0xFF] << 16 ) ^
      ( ( uint32_t ) RSb[( Y2 >> 24 ) & 0xFF] << 24 );

  X2 = *RK++ ^
      ( ( uint32_t ) RSb[( Y2 ) & 0xFF] ) ^
      ( ( uint32_t ) RSb[( Y1 >> 8 ) & 0xFF] << 8 ) ^
      ( ( uint32_t ) RSb[( Y0 >> 16 ) & 0xFF] << 16 ) ^
      ( ( uint32_t ) RSb[( Y3 >> 24 ) & 0xFF] << 24 );

  X3 = *RK++ ^
      ( ( uint32_t ) RSb[( Y3 ) & 0xFF] ) ^
      ( ( uint32_t ) RSb[( Y2 >> 8 ) & 0xFF] << 8 ) ^
      ( ( uint32_t ) RSb[( Y1 >> 16 ) & 0xFF] << 16 ) ^
      ( ( uint32_t ) RSb[( Y0 >> 24 ) & 0xFF] << 24 );

  PUT_UINT32_LE( X0, output, 0 );
  PUT_UINT32_LE( X1, output, 4 );
  PUT_UINT32_LE( X2, output, 8 );
  PUT_UINT32_LE( X3, output, 12 );

  memset( &X0, 0, sizeof( X0 ) );
  memset( &X1, 0, sizeof( X1 ) );
  memset( &X2, 0, sizeof( X2 ) );
  memset( &X3, 0, sizeof( X3 ) );

  memset( &Y0, 0, sizeof( Y0 ) );
  memset( &Y1, 0, sizeof( Y1 ) );
  memset( &Y2, 0, sizeof( Y2 ) );
  memset( &Y3, 0, sizeof( Y3 ) );

  memset( &RK, 0, sizeof( RK ) );

  return 0;
}
