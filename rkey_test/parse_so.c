#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include "elf.h"

#define BUF_SIZE 0x8000
u8            sbuf[BUF_SIZE];

char         *section_types[] = {
  "NULL", "PROGBITS", "SYMTAB", "STRTAB", "RELA", "HASH", "DYNAMIC", "NOTE",
  "NOBITS", "REL", "SHLIB", "DYNSYM", "NULL", "NULL", "INIT_ARRAY",
  "FINI_ARRAY", "PREINIT_ARRAY", "GROUP", "SYMTAB_SHNDX", "RELR",
  "NUM"
};

#define MAX_SH_TYPE ( sizeof(section_types) / sizeof(char *) )

typedef struct
{
  unsigned long addr;
  unsigned long off;
  unsigned long size;
} Segment;

Segment       text, dynstr, gnu_version, gnu_version_r;

char         *
dyn_str( unsigned offset, FILE *f )
{
#define STR_SIZE 0x2000
  static char   str[STR_SIZE];
  static unsigned start = -1;
  if( offset >= start && offset < STR_SIZE - 10 )
    return str + offset - start;
  start = offset;
  fseek( f, dynstr.off + start, SEEK_SET );
  fread( str, 1, STR_SIZE, f );
  return str;
}

int
patch_so_linux64( FILE *f )
{
  int           i;
  u32           e_shoff;
  u16           e_shnum, e_shstrndx;
  char         *type, *n, names[0x400];
  Elf64_Ehdr   *h64;
  Elf64_Shdr   *e64;

  fread( sbuf, 1, BUF_SIZE, f );
  h64 = ( Elf64_Ehdr * ) sbuf;
  e_shoff = h64->e_shoff;
  e_shnum = h64->e_shnum;
  e_shstrndx = h64->e_shstrndx;
#if 1
  printf( "Header 0x%x 0x%x 0x%x\n", e_shoff, e_shnum, e_shstrndx );
#endif
  fseek( f, e_shoff, SEEK_SET );
  fread( sbuf, 1, BUF_SIZE, f );
  e64 = ( Elf64_Shdr * ) sbuf;
  fseek( f, e64[e_shstrndx].sh_offset, SEEK_SET );
  fread( names, 1, e64[e_shstrndx].sh_size, f );
  for( i = 0; i < e_shnum; i++ )
  {
#if 1
    n = names + e64->sh_name;
    if( e64->sh_type < MAX_SH_TYPE )
      type = section_types[e64->sh_type];
    else
      type = "UNK";
    printf( "%2d %08lx %06lx %08lx %s "
            "%s flg-%lx lnk-%x inf-%x [%lx]\n",
        i, e64->sh_addr, e64->sh_offset, e64->sh_size, n,
        type, e64->sh_flags, e64->sh_link, e64->sh_info,
        e64->sh_entsize );
#endif
    if( !strcmp( ".text", n ) )
    {
      text.addr = e64->sh_addr;
      text.off = e64->sh_offset;
      text.size = e64->sh_size;
    }
    else if( !strcmp( ".dynstr", n ) )
    {
      dynstr.addr = e64->sh_addr;
      dynstr.off = e64->sh_offset;
      dynstr.size = e64->sh_size;
    }
    else if( !strcmp( ".gnu.version", n ) )
    {
      gnu_version.addr = e64->sh_addr;
      gnu_version.off = e64->sh_offset;
      gnu_version.size = e64->sh_size;
    }
    else if( !strcmp( ".gnu.version_r", n ) )
    {
      e64->sh_size = 2 * sizeof( Elf64_Verneed );
      e64->sh_info = 1;
      gnu_version_r.addr = e64->sh_addr;
      gnu_version_r.off = e64->sh_offset;
      gnu_version_r.size = e64->sh_size;
    }
    e64++;
  }
  // fseek( f, e_shoff, SEEK_SET );
  // fwrite( sbuf, 1, (u8 *)e64 - sbuf, f );
  // fseek( f, gnu_version.off, SEEK_SET );
  // fread( sbuf, 1, gnu_version.size, f );
  fseek( f, gnu_version_r.off, SEEK_SET );
  fread( sbuf, 1, gnu_version_r.size, f );
  Elf64_Verneed *v = ( Elf64_Verneed * ) sbuf;
  for( int cnt = i = 0; i < gnu_version_r.size / sizeof( Elf64_Verneed );
      i++, v++ )
  {
    if( !cnt )
    {
      printf( "v%d %x %s %x %x\n", v->vn_version, v->vn_cnt,
          dyn_str( v->vn_file, f ), v->vn_aux, v->vn_next );
      cnt = v->vn_cnt;
    }
    else
    {
      Elf64_Vernaux *a;
      a = ( Elf64_Vernaux * ) v;
      printf( "%x %x v%x %s %x\n", a->vna_hash, a->vna_flags, a->vna_other,
          dyn_str( a->vna_name, f ), a->vna_next );
      cnt--;
    }
  }
  return 0;
}

int
main(  )
{
  FILE         *f = fopen( "libscope-auklet.so", "rb+" );
  if( f == NULL )
    return -1;
  patch_so_linux64( f );
  fclose( f );
  return 0;
}
