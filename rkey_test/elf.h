
#ifndef _MY_Uxx
#define _MY_Uxx
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#endif

typedef struct
{
  u32           magic;
  u8            class;          // File class
  u8            data;           // Data encoding
  u8            version;        // File version
  u8            osabi;          // Operating system/ABI identification
  u8            abiversion;     // ABI version
  u8            pad[7];         // Start of padding bytes
  u16           e_type;
  u16           e_machine;
  u32           e_version;
  u64           e_entry;
  u64           e_phoff;
  u64           e_shoff;
  u32           e_flags;
  u16           e_ehsize;
  u16           e_phentsize;
  u16           e_phnum;
  u16           e_shentsize;
  u16           e_shnum;
  u16           e_shstrndx;
} Elf64_Ehdr;

typedef struct
{
  u32           sh_name;
  u32           sh_type;
  u64           sh_flags;
  u64           sh_addr;
  u64           sh_offset;
  u64           sh_size;
  u32           sh_link;
  u32           sh_info;
  u64           sh_addralign;
  u64           sh_entsize;
} Elf64_Shdr;

typedef struct __attribute__( ( packed ) )
{
  u16           vn_version;
  u16           vn_cnt;
  u32           vn_file;
  u32           vn_aux;
  u32           vn_next;
} Elf64_Verneed;

typedef struct __attribute__( ( packed ) )
{
  u32           vna_hash;
  u16           vna_flags;
  u16           vna_other;
  u32           vna_name;
  u32           vna_next;
} Elf64_Vernaux;
