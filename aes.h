#ifndef AES_H
#define AES_H

#include <stddef.h>
#include <stdint.h>

/**
 * \brief The AES context-type definition.
 */
typedef struct aes_context
{
  int           nr;             // The number of rounds.
  uint32_t     *rk;             // AES round keys.
  uint32_t      buf[68];        // Unaligned data buffer.
/* This buffer can hold 32 extra Bytes, which can
   simplify key expansion in the 256-bit case by generating an extra round key.  */
}
aes_context;

/**
 * \brief	   This function sets the encryption key.
 *
 * \param ctx	   The AES context to which the key should be bound.
 *		   It must be initialized.
 * \param key	   The encryption key.
 *		   This must be a readable buffer of size \p keybits bits.
 * \param keybits  The size of data passed in bits. Valid options are:
 * 	           128, 192, 256
 * \return	   0 on success.
 */
int           aes_setkey_enc( aes_context * ctx,
    const unsigned char *key, unsigned int keybits );

/**
 * \brief	   This function sets the decryption key.
 *
 * \param ctx	   The AES context to which the key should be bound.
 *		   It must be initialized.
 * \param key	   The decryption key.
 *		   This must be a readable buffer of size \p keybits bits.
 * \param keybits  The size of data passed. Valid options are:
 * 	           128, 192, 256
 * \return	   0 on success.
 */
int           aes_setkey_dec( aes_context * ctx,
    const unsigned char *key, unsigned int keybits );

/**
 * \brief	    Internal AES block encryption function. 
 * \param ctx	    The AES context to use for encryption.
 * \param input	    The plaintext block.
 * \param output    The output (ciphertext) block.
 *
 * \return	    0 on success.
 */
int           aes_encrypt( aes_context * ctx,
    const unsigned char input[16], unsigned char output[16] );

/**
 * \brief	    Internal AES block decryption function. 
 * \param ctx	    The AES context to use for decryption.
 * \param input	    The ciphertext block.
 * \param output    The output (plaintext) block.
 *
 * \return	    0 on success.
 */
int           aes_decrypt( aes_context * ctx,
    const unsigned char input[16], unsigned char output[16] );

#endif                          /* aes.h */
