#include <stdint.h>

#define TITLE   "Rigol 'vendor.bin' encoder/decoder"
#define AUTHOR  "Zelea"
#define VERSION "1.1"

#ifndef _MY_Uxx
#define _MY_Uxx
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#endif

/* strings.c */
extern char  *scope_models[];
extern char  *scope_options[];
extern char  *series800_options[];
extern char  *series900_options[];
extern char  *series1000_options[];
extern char  *series4000_options[];
/* xxtea.c */
u8           *xxtea_encrypt( const u8 * data, u32 len, u8 * key,
    u32 * ret_len );
u8           *xxtea_decrypt( const u8 * data, u32 len, u8 * key,
    u32 * ret_len );
/* crc32.c */
u32           crc32( u8 * buf, int len );
