	.text

// API_SetStr2Hex(RString, char *, int &)
                .globl _Z14API_SetStr2Hex7RStringPcRi
_Z14API_SetStr2Hex7RStringPcRi:         // CODE XREF: API_SetStr2Hex(RString,char *,int &)+C
                                        // DATA XREF: LOAD:0000000000040A68

var_s0          =  0

// __unwind {
                STP             X29, X30, [SP,#-0x10+var_s0]!
                ADD             X29, SP, #0
                ORR             W8, WZR, WZR
                ORR             X10, XZR, XZR
                ADD             X9, X0, #1
                STR             WZR, [X2]
                LDRB            W11, [X0]
                TBZ             W11, #0, loc_19568C
                B               loc_1956AC
// ---------------------------------------------------------------------------

loc_19566C:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+E4
                ADD             W12, W12, W10,LSL#4

loc_195670:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+F0
                                        // API_SetStr2Hex(RString,char *,int &)+FC
                STRB            W12, [X1,W8,SXTW]
                LDR             W8, [X2]
                ADD             X10, X13, #1
                ADD             W8, W8, #1
                STR             W8, [X2]
                LDRB            W11, [X0]
                TBNZ            W11, #0, loc_1956AC

loc_19568C:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+1C
                UBFM            X12, X11, #1, #0x3F // '?'
                SUBS            XZR, X10, W12,SXTW
                B.ge            loc_195748

loc_195698:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+6C
                TBNZ            W11, #0, loc_1956BC
                UBFM            X12, X11, #1, #0x1F
                SUBS            XZR, X12, X10
                B.hi            loc_1956C8
                B               loc_195750
// ---------------------------------------------------------------------------

loc_1956AC:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+20
                                        // API_SetStr2Hex(RString,char *,int &)+40
                LDR             X12, [X0,#8]
                SUBS            XZR, X10, W12,SXTW
                B.lt            loc_195698
                B               loc_195748
// ---------------------------------------------------------------------------

loc_1956BC:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &):loc_195698
                LDR             X12, [X0,#8]
                SUBS            XZR, X12, X10
                B.ls            loc_195750

loc_1956C8:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+5C
                ORR             X12, XZR, X9
                TBZ             W11, #0, loc_1956D4
                LDR             X12, [X0,#0x10]

loc_1956D4:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+84
                LDRB            W13, [X12,X10]
                SUB             W12, W13, #0x30 // '0'
                SUBS            WZR, W12, #0xA
                B.cc            loc_1956F4
                SUB             W12, W13, #0x61 // 'a'
                SUB             W13, W13, #0x57 // 'W'
                SUBS            WZR, W12, #6
                CSEL            W12, W13, WZR, cc

loc_1956F4:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+98
                TBNZ            W11, #0, loc_195700
                UBFM            X14, X11, #1, #0x3F // '?'
                B               loc_195704
// ---------------------------------------------------------------------------

loc_195700:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &):loc_1956F4
                LDR             X14, [X0,#8]

loc_195704:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+B4
                ADD             X13, X10, #1
                SUBS            XZR, X14, X13
                B.ls            loc_195750
                ORR             X14, XZR, X9
                TBZ             W11, #0, loc_19571C
                LDR             X14, [X0,#0x10]

loc_19571C:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+CC
                ADD             X10, X14, X10
                LDRB            W10, [X10,#1]
                SUB             W11, W10, #0x30 // '0'
                SUBS            WZR, W11, #9
                B.ls            loc_19566C
                SUB             W11, W10, #0x61 // 'a'
                SUBS            WZR, W11, #5
                B.hi            loc_195670
                ADD             W10, W12, W10,LSL#4
                SUB             W12, W10, #0x70 // 'p'
                B               loc_195670
// ---------------------------------------------------------------------------

loc_195748:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+4C
                                        // API_SetStr2Hex(RString,char *,int &)+70
                LDP             X29, X30, [SP],#0x10
                RET
// ---------------------------------------------------------------------------

loc_195750:                             // CODE XREF: API_SetStr2Hex(RString,char *,int &)+60
                                        // API_SetStr2Hex(RString,char *,int &)+7C
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_out_of_rangeEv // std::__basic_string_common<true>::__throw_out_of_range(void)
// } // starts at 195648
// End of function API_SetStr2Hex(RString,char *,int &)


// RFile *__fastcall RFile::RFile(RFile *__hidden this, const RString *)
                .globl _ZN5RFileC2ERK7RString // weak
_ZN5RFileC2ERK7RString:                 // CODE XREF: RFile::RFile(RString const&)+C
                                        // DATA XREF: LOAD:0000000000071B30

var_10          = -0x10
var_s0          =  0

// __unwind { // __gxx_personality_v0
                STP             X20, X19, [SP,#-0x10+var_10]!
                STP             X29, X30, [SP,#0x10+var_s0]
                ADD             X29, SP, #0x10
                ORR             X19, XZR, X0
                SUBS            XZR, X0, X1
                STP             XZR, XZR, [X0]
                STR             XZR, [X0,#0x10]
                B.eq            loc_19CC38
                LDRB            W8, [X1]
                LDP             X10, X9, [X1,#8]
                ANDS            WZR, W8, #1
                UBFM            X11, X8, #1, #0x3F // '?'
                CSINC           X1, X9, X1, ne // src
                CSEL            X2, X11, X10, eq // n
//   try {
                ORR             X0, XZR, X19 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm // std::string::assign(char const*,ulong)
                LDRB            W9, [X19]
                TBZ             W9, #0, loc_19CC3C
                LDP             X8, X20, [X19]
                AND             X8, X8, #0xFFFFFFFFFFFFFFFE
                SUB             X1, X8, #1
                MOVZ            W8, #1
                SUBS            XZR, X20, X1
                B.eq            loc_19CC50

loc_19CC24:                             // CODE XREF: RFile::RFile(RString const&)+88
                TBZ             W8, #0, loc_19CC74

loc_19CC28:                             // CODE XREF: RFile::RFile(RString const&)+AC
                LDR             X8, [X19,#0x10]
                ADD             X9, X20, #1
                STR             X9, [X19,#8]
                B               loc_19CC84
// ---------------------------------------------------------------------------

loc_19CC38:                             // CODE XREF: RFile::RFile(RString const&)+1C
                ORR             W9, WZR, WZR

loc_19CC3C:                             // CODE XREF: RFile::RFile(RString const&)+44
                ORR             W8, WZR, WZR
                UBFM            W20, W9, #1, #0x1F
                MOVZ            W1, #0x16
                SUBS            XZR, X20, X1
                B.ne            loc_19CC24

loc_19CC50:                             // CODE XREF: RFile::RFile(RString const&)+5C
                MOVZ            W2, #1
                ORR             X0, XZR, X19
                ORR             X3, XZR, X1
                ORR             X4, XZR, X1
                ORR             X5, XZR, XZR
                ORR             X6, XZR, XZR
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__grow_byEmmmmmm // std::string::__grow_by(ulong,ulong,ulong,ulong,ulong,ulong)
//   } // starts at 19CBFC
                LDRB            W8, [X19]
                TBNZ            W8, #0, loc_19CC28

loc_19CC74:                             // CODE XREF: RFile::RFile(RString const&):loc_19CC24
                UBFM            W8, W20, #0x1F, #0x1E
                ADD             W9, W8, #2
                ORR             X8, XZR, X19
                STRB            W9, [X8],#1

loc_19CC84:                             // CODE XREF: RFile::RFile(RString const&)+70
                STRH            WZR, [X8,X20]
                STR             WZR, [X19,#0x18]
                LDP             X29, X30, [SP,#0x10+var_s0]
                LDP             X20, X19, [SP],#0x20
                RET
// ---------------------------------------------------------------------------
//   cleanup() // owned by 19CBFC
                LDRB            W8, [X19]
                ORR             X20, XZR, X0
                TBZ             W8, #0, loc_19CCAC
                LDR             X0, [X19,#0x10] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_19CCAC:                             // CODE XREF: RFile::RFile(RString const&)+DC
                ORR             X0, XZR, X20
                BL              sub_A1036C
// } // starts at 19CBC4
// End of function RFile::RFile(RString const&)


// __int64 __fastcall RString::split(RString *__hidden this, const RString *)
                .globl _ZN7RString5splitERKS_ // weak
_ZN7RString5splitERKS_:                 // CODE XREF: RString::split(RString const&)+C
                                        // DATA XREF: LOAD:000000000005E408

var_A0          = -0xA0
dest            = -0x98
var_90          = -0x90
var_88          = -0x88
ptr             = -0x80
n               = -0x78
src             = -0x68
var_60          = -0x60
var_58          = -0x58
var_50          = -0x50
var_40          = -0x40
var_30          = -0x30
var_20          = -0x20
var_10          = -0x10
var_s0          =  0

// __unwind { // __gxx_personality_v0
                SUB             SP, SP, #0xB0
                STP             X28, X27, [SP,#0xA0+var_50]
                STP             X26, X25, [SP,#0xA0+var_40]
                STP             X24, X23, [SP,#0xA0+var_30]
                STP             X22, X21, [SP,#0xA0+var_20]
                STP             X20, X19, [SP,#0xA0+var_10]
                STP             X29, X30, [SP,#0xA0+var_s0]
                ADD             X29, SP, #0xA0
                MRS             X10, TPIDR_EL0
                LDR             X9, [X10,#0x28]
                ORR             X20, XZR, X1
                ORR             X22, XZR, X0
                ORR             X19, XZR, X8
                STR             X9, [SP,#0xA0+var_58]
                LDRB            W9, [X0]
                STR             X10, [SP,#0xA0+var_A0]
                TBNZ            W9, #0, loc_21E850
                ADD             X0, X22, #1
                B               loc_21E854
// ---------------------------------------------------------------------------

loc_21E850:                             // CODE XREF: RString::split(RString const&)+40
                LDR             X0, [X22,#0x10] // s

loc_21E854:                             // CODE XREF: RString::split(RString const&)+48
                BL	strlen
                ADD             X0, X0, #1 // unsigned __int64
                BL	_Znam  // operator new[](ulong)
                LDRB            W8, [X22]
                STR             X0, [SP,#0xA0+dest]
                TBNZ            W8, #0, loc_21E874
                ADD             X1, X22, #1
                B               loc_21E878
// ---------------------------------------------------------------------------

loc_21E874:                             // CODE XREF: RString::split(RString const&)+64
                LDR             X1, [X22,#0x10] // src

loc_21E878:                             // CODE XREF: RString::split(RString const&)+6C
                LDR             X0, [SP,#0xA0+dest] // dest
                BL	strcpy
                STP             XZR, XZR, [X19]
                STR             XZR, [X19,#0x10]
                LDRB            W8, [X20]
                LDR             X9, [X20,#0x10]
                ANDS            WZR, W8, #1
                CSINC           X1, X9, X20, ne // delim
                BL	strtok
                CBZ             X0, loc_21EAD0
                ADD             X8, SP, #0xA0+var_90
                ADD             X9, SP, #0xA0+n
                ORR             X22, XZR, X0
                ADD             X28, X20, #1
                ORR             X27, X8, #1
                ORR             X21, X9, #1
                B               loc_21E8C0
// ---------------------------------------------------------------------------

loc_21E8BC:                             // CODE XREF: RString::split(RString const&)+2BC
                                        // RString::split(RString const&)+2C8
                CBZ             X22, loc_21EAD0

loc_21E8C0:                             // CODE XREF: RString::split(RString const&)+B4
//   try {                               // int
                ADD             X0, SP, #0xA0+var_90
                ORR             X1, XZR, X22 // s
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc // std::string::basic_string<decltype(nullptr)>(char const*)
//   } // starts at 21E8C0
                LDRB            W8, [SP,#0xA0+var_90]
                TBZ             W8, #0, loc_21E8FC
                LDP             X9, X22, [SP,#0xA0+var_90]
                AND             X9, X9, #0xFFFFFFFFFFFFFFFE
                SUB             X1, X9, #1
                SUBS            XZR, X22, X1
                B.eq            loc_21E90C

loc_21E8E8:                             // CODE XREF: RString::split(RString const&)+104
                TBZ             W8, #0, loc_21E930

loc_21E8EC:                             // CODE XREF: RString::split(RString const&)+128
                LDR             X8, [SP,#0xA0+ptr]
                ADD             X9, X22, #1
                STR             X9, [SP,#0xA0+var_88]
                B               loc_21E940
// ---------------------------------------------------------------------------

loc_21E8FC:                             // CODE XREF: RString::split(RString const&)+CC
                UBFM            X22, X8, #1, #0x3F // '?'
                MOVZ            W1, #0x16
                SUBS            XZR, X22, X1
                B.ne            loc_21E8E8

loc_21E90C:                             // CODE XREF: RString::split(RString const&)+E0
//   try {
                ADD             X0, SP, #0xA0+var_90
                MOVZ            W2, #1
                ORR             X3, XZR, X1
                ORR             X4, XZR, X1
                ORR             X5, XZR, XZR
                ORR             X6, XZR, XZR
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__grow_byEmmmmmm // std::string::__grow_by(ulong,ulong,ulong,ulong,ulong,ulong)
//   } // starts at 21E90C
                LDRB            W8, [SP,#0xA0+var_90]
                TBNZ            W8, #0, loc_21E8EC

loc_21E930:                             // CODE XREF: RString::split(RString const&):loc_21E8E8
                UBFM            W8, W22, #0x1F, #0x1E
                ADD             W8, W8, #2
                STRB            W8, [SP,#0xA0+var_90]
                ORR             X8, XZR, X27

loc_21E940:                             // CODE XREF: RString::split(RString const&)+F4
                STRH            WZR, [X8,X22]
                LDRB            W8, [SP,#0xA0+var_90]
                LDUR            W9, [X27,#3]
                LDR             W10, [X27]
                LDP             X23, X22, [SP,#0xA0+var_88]
                STP             XZR, XZR, [SP,#0xA0+var_90]
                STP             XZR, XZR, [SP,#0xA0+ptr]
                STR             W10, [SP,#0xA0+var_60]
                STUR            W9, [SP,#0xA0+var_60+3]
                STP             XZR, XZR, [SP,#0xA0+n+8]
                TBNZ            W8, #0, loc_21E988
                LDUR            W9, [SP,#0xA0+var_60+3]
                LDR             W10, [SP,#0xA0+var_60]
                STRB            W8, [SP,#0xA0+n]
                STUR            W9, [X21,#3]
                STR             W10, [X21]
                STP             X23, X22, [SP,#0xA0+n+8]
                B               loc_21E9F8
// ---------------------------------------------------------------------------

loc_21E988:                             // CODE XREF: RString::split(RString const&)+164
                ADDS            XZR, X23, #0x10
                B.cs            loc_21EB0C
                SUBS            XZR, X23, #0x17
                B.cs            loc_21E9AC
                UBFM            W8, W23, #0x1F, #0x1E
                ORR             X24, XZR, X21
                STRB            W8, [SP,#0xA0+n]
                CBNZ            X23, loc_21E9CC
                B               loc_21E9DC
// ---------------------------------------------------------------------------

loc_21E9AC:                             // CODE XREF: RString::split(RString const&)+190
                ADD             X8, X23, #0x10
                AND             X25, X8, #0xFFFFFFFFFFFFFFF0
//   try {
                ORR             X0, XZR, X25 // unsigned __int64
                BL	_Znwm  // operator new(ulong)
//   } // starts at 21E9B4
                ORR             X8, X25, #1
                ORR             X24, XZR, X0
                STP             X8, X23, [SP,#0xA0+n]
                STR             X0, [SP,#0xA0+src]

loc_21E9CC:                             // CODE XREF: RString::split(RString const&)+1A0
                ORR             X0, XZR, X24 // dest
                ORR             X1, XZR, X22 // src
                ORR             X2, XZR, X23 // n
                BL	memcpy

loc_21E9DC:                             // CODE XREF: RString::split(RString const&)+1A4
                ORR             X0, XZR, X22 // ptr
                STRB            WZR, [X24,X23]
                BL	_ZdlPv // operator delete(void *)
                LDRB            W8, [SP,#0xA0+var_90]
                TBZ             W8, #0, loc_21E9F8
                LDR             X0, [SP,#0xA0+ptr] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_21E9F8:                             // CODE XREF: RString::split(RString const&)+180
                                        // RString::split(RString const&)+1E8
                LDP             X22, X8, [X19,#8]
                SUBS            XZR, X22, X8
                B.eq            loc_21EA28
                STP             XZR, XZR, [X22]
                STR             XZR, [X22,#0x10]
                LDRB            W8, [SP,#0xA0+n]
                TBNZ            W8, #0, loc_21EA38
                LDR             X8, [SP,#0xA0+src]
                LDUR            Q0, [SP,#0xA0+n]
                STR             X8, [X22,#0x10]
                STR             Q0, [X22]
                B               loc_21EA98
// ---------------------------------------------------------------------------

loc_21EA28:                             // CODE XREF: RString::split(RString const&)+1FC
//   try {
                ADD             X1, SP, #0xA0+n
                ORR             X0, XZR, X19
                BL	_ZNSt6__ndk16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE21__push_back_slow_pathIRKS6_EEvOT_ // std::vector<std::string>::__push_back_slow_path<std::string const&>(std::string const&)
//   } // starts at 21EA28
                B               loc_21EAA0
// ---------------------------------------------------------------------------

loc_21EA38:                             // CODE XREF: RString::split(RString const&)+20C
                LDR             X23, [SP,#0xA0+n+8]
                ADDS            XZR, X23, #0x10
                B.cs            loc_21EB14
                LDR             X24, [SP,#0xA0+src]
                SUBS            XZR, X23, #0x17
                B.cs            loc_21EA64
                UBFM            W8, W23, #0x1F, #0x1E
                ORR             X25, XZR, X22
                STRB            W8, [X25],#1
                CBNZ            X23, loc_21EA84
                B               loc_21EA94
// ---------------------------------------------------------------------------

loc_21EA64:                             // CODE XREF: RString::split(RString const&)+248
                ADD             X8, X23, #0x10
                AND             X26, X8, #0xFFFFFFFFFFFFFFF0
//   try {
                ORR             X0, XZR, X26 // unsigned __int64
                BL	_Znwm  // operator new(ulong)
//   } // starts at 21EA6C
                ORR             X8, X26, #1
                ORR             X25, XZR, X0
                STP             X23, X0, [X22,#8]
                STR             X8, [X22]

loc_21EA84:                             // CODE XREF: RString::split(RString const&)+258
                ORR             X0, XZR, X25 // dest
                ORR             X1, XZR, X24 // src
                ORR             X2, XZR, X23 // n
                BL	memcpy

loc_21EA94:                             // CODE XREF: RString::split(RString const&)+25C
                STRB            WZR, [X25,X23]

loc_21EA98:                             // CODE XREF: RString::split(RString const&)+220
                ADD             X8, X22, #0x18
                STR             X8, [X19,#8]

loc_21EAA0:                             // CODE XREF: RString::split(RString const&)+230
                LDRB            W8, [X20]
                LDR             X9, [X20,#0x10]
                ORR             X0, XZR, XZR // s
                ANDS            WZR, W8, #1
                CSEL            X1, X28, X9, eq // delim
                BL	strtok
                LDRB            W8, [SP,#0xA0+n]
                ORR             X22, XZR, X0
                TBZ             W8, #0, loc_21E8BC
                LDR             X0, [SP,#0xA0+src] // ptr
                BL	_ZdlPv // operator delete(void *)
                B               loc_21E8BC
// ---------------------------------------------------------------------------

loc_21EAD0:                             // CODE XREF: RString::split(RString const&)+98
                                        // RString::split(RString const&):loc_21E8BC
                LDR             X0, [SP,#0xA0+dest] // void *
                BL	_ZdaPv // operator delete[](void *)
                LDR             X8, [SP,#0xA0+var_A0]
                LDR             X8, [X8,#0x28]
                LDR             X9, [SP,#0xA0+var_58]
                SUBS            XZR, X8, X9
                B.ne            loc_21EB1C
                LDP             X29, X30, [SP,#0xA0+var_s0]
                LDP             X20, X19, [SP,#0xA0+var_10]
                LDP             X22, X21, [SP,#0xA0+var_20]
                LDP             X24, X23, [SP,#0xA0+var_30]
                LDP             X26, X25, [SP,#0xA0+var_40]
                LDP             X28, X27, [SP,#0xA0+var_50]
                ADD             SP, SP, #0xB0
                RET
// ---------------------------------------------------------------------------

loc_21EB0C:                             // CODE XREF: RString::split(RString const&)+188
//   try {
                ADD             X0, SP, #0xA0+n
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv // std::__basic_string_common<true>::__throw_length_error(void)
//   } // starts at 21EB0C
// ---------------------------------------------------------------------------

loc_21EB14:                             // CODE XREF: RString::split(RString const&)+23C
//   try {
                ORR             X0, XZR, X22
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv // std::__basic_string_common<true>::__throw_length_error(void)
//   } // starts at 21EB14
// ---------------------------------------------------------------------------

loc_21EB1C:                             // CODE XREF: RString::split(RString const&)+2E4
                BL	__stack_chk_fail
// ---------------------------------------------------------------------------
//   cleanup() // owned by 21EB14
                B               loc_21EB28
// ---------------------------------------------------------------------------
//   cleanup() // owned by 21EB0C
                B               loc_21EB3C
// ---------------------------------------------------------------------------

loc_21EB28:                             // CODE XREF: RString::split(RString const&)+31C
//   cleanup() // owned by 21EA6C
                ORR             X20, XZR, X0
                STR             X22, [X19,#8]
                LDRB            W8, [SP,#0xA0+n]
                TBNZ            W8, #0, loc_21EB60
                B               loc_21EB8C
// ---------------------------------------------------------------------------

loc_21EB3C:                             // CODE XREF: RString::split(RString const&)+320
//   cleanup() // owned by 21E9B4
                ORR             X20, XZR, X0
                ORR             X0, XZR, X22 // ptr
                BL	_ZdlPv // operator delete(void *)
                LDRB            W8, [SP,#0xA0+var_90]
                TBNZ            W8, #0, loc_21EB74
                B               loc_21EB8C
// ---------------------------------------------------------------------------
//   cleanup() // owned by 21EA28
                ORR             X20, XZR, X0
                LDRB            W8, [SP,#0xA0+n]
                TBZ             W8, #0, loc_21EB8C

loc_21EB60:                             // CODE XREF: RString::split(RString const&)+330
                LDR             X0, [SP,#0xA0+src]
                B               loc_21EB78
// ---------------------------------------------------------------------------
//   cleanup() // owned by 21E90C
                ORR             X20, XZR, X0
                LDRB            W8, [SP,#0xA0+var_90]
                TBZ             W8, #0, loc_21EB8C

loc_21EB74:                             // CODE XREF: RString::split(RString const&)+348
                LDR             X0, [SP,#0xA0+ptr] // ptr

loc_21EB78:                             // CODE XREF: RString::split(RString const&)+360
                BL	_ZdlPv // operator delete(void *)
                LDR             X21, [X19]
                CBNZ            X21, loc_21EB94
                B               loc_21EBD8
// ---------------------------------------------------------------------------
//   cleanup() // owned by 21E8C0
                ORR             X20, XZR, X0

loc_21EB8C:                             // CODE XREF: RString::split(RString const&)+334
                                        // RString::split(RString const&)+34C
                LDR             X21, [X19]
                CBZ             X21, loc_21EBD8

loc_21EB94:                             // CODE XREF: RString::split(RString const&)+37C
                LDR             X8, [X19,#8]
                SUBS            XZR, X8, X21
                B.eq            loc_21EBE0
                ORR             X22, XZR, X8
                LDRB            W9, [X22,#-0x18]!
                TBNZ            W9, #0, loc_21EBC0

loc_21EBAC:                             // CODE XREF: RString::split(RString const&)+3B8
                                        // RString::split(RString const&)+3C4
                SUBS            XZR, X21, X22
                ORR             X8, XZR, X22
                B.eq            loc_21EBCC
                LDRB            W9, [X22,#-0x18]!
                TBZ             W9, #0, loc_21EBAC

loc_21EBC0:                             // CODE XREF: RString::split(RString const&)+3A4
                LDUR            X0, [X8,#-8] // ptr
                BL	_ZdlPv // operator delete(void *)
                B               loc_21EBAC
// ---------------------------------------------------------------------------

loc_21EBCC:                             // CODE XREF: RString::split(RString const&)+3B0
                LDR             X0, [X19] // ptr

loc_21EBD0:                             // CODE XREF: RString::split(RString const&)+3E0
                STR             X21, [X19,#8]
                BL	_ZdlPv // operator delete(void *)

loc_21EBD8:                             // CODE XREF: RString::split(RString const&)+380
                                        // RString::split(RString const&)+38C
                ORR             X0, XZR, X20
                BL              sub_A1036C

loc_21EBE0:                             // CODE XREF: RString::split(RString const&)+398
                ORR             X0, XZR, X21
                B               loc_21EBD0
// } // starts at 21E804
// End of function RString::split(RString const&)


// __int64 __fastcall RString::toUpper(RString *__hidden this)
                .globl _ZN7RString7toUpperEv // weak
_ZN7RString7toUpperEv:                  // CODE XREF: RString::toUpper(void)+C
                                        // DATA XREF: LOAD:00000000000629F8

var_30          = -0x30
var_20          = -0x20
var_10          = -0x10
var_s0          =  0

// __unwind {
                STR             X23, [SP,#-0x10+var_30]!
                STP             X22, X21, [SP,#0x30+var_20]
                STP             X20, X19, [SP,#0x30+var_10]
                STP             X29, X30, [SP,#0x30+var_s0]
                ADD             X29, SP, #0x30
                ORR             X19, XZR, X0
                ORR             W8, WZR, WZR
                ADD             X21, X0, #1
                B               loc_25FAA0
// ---------------------------------------------------------------------------

loc_25FA98:                             // CODE XREF: RString::toUpper(void)+BC
                                        // RString::toUpper(void)+C4
                STRB            W0, [X8,X22]

loc_25FA9C:                             // CODE XREF: RString::toUpper(void)+8C
                ADD             W8, W22, #1

loc_25FAA0:                             // CODE XREF: RString::toUpper(void)+20
                LDRB            W23, [X19]
                ORR             W22, WZR, W8
                TBNZ            W23, #0, loc_25FACC
                UBFM            X8, X23, #1, #0x3F // '?'
                SUBS            XZR, X8, X22
                B.ls            loc_25FB3C

loc_25FAB8:                             // CODE XREF: RString::toUpper(void)+60
                TBNZ            W23, #0, loc_25FADC
                UBFM            X8, X23, #1, #0x3F // '?'
                SUBS            XZR, X8, X22
                B.hi            loc_25FAE8
                B               loc_25FB54
// ---------------------------------------------------------------------------

loc_25FACC:                             // CODE XREF: RString::toUpper(void)+34
                LDR             X8, [X19,#8]
                SUBS            XZR, X8, X22
                B.hi            loc_25FAB8
                B               loc_25FB3C
// ---------------------------------------------------------------------------

loc_25FADC:                             // CODE XREF: RString::toUpper(void):loc_25FAB8
                LDR             X8, [X19,#8]
                SUBS            XZR, X8, X22
                B.ls            loc_25FB54

loc_25FAE8:                             // CODE XREF: RString::toUpper(void)+50
                ORR             X8, XZR, X21
                TBZ             W23, #0, loc_25FAF4
                LDR             X8, [X19,#0x10]

loc_25FAF4:                             // CODE XREF: RString::toUpper(void)+78
                LDRB            W20, [X8,X22]
                ORR             W0, WZR, W20 // int
                BL	islower
                CBZ             W0, loc_25FA9C
                ORR             W0, WZR, W20 // c
                BL	toupper
                TBNZ            W23, #0, loc_25FB20
                UBFM            X8, X23, #1, #0x1F
                SUBS            XZR, X8, X22
                B.hi            loc_25FB2C
                B               loc_25FB54
// ---------------------------------------------------------------------------

loc_25FB20:                             // CODE XREF: RString::toUpper(void)+98
                LDR             X8, [X19,#8]
                SUBS            XZR, X8, X22
                B.ls            loc_25FB54

loc_25FB2C:                             // CODE XREF: RString::toUpper(void)+A4
                ORR             X8, XZR, X21
                TBZ             W23, #0, loc_25FA98
                LDR             X8, [X19,#0x10]
                B               loc_25FA98
// ---------------------------------------------------------------------------

loc_25FB3C:                             // CODE XREF: RString::toUpper(void)+40
                                        // RString::toUpper(void)+64
                ORR             X0, XZR, X19
                LDP             X29, X30, [SP,#0x30+var_s0]
                LDP             X20, X19, [SP,#0x30+var_10]
                LDP             X22, X21, [SP,#0x30+var_20]
                LDR             X23, [SP],#0x40
                RET
// ---------------------------------------------------------------------------

loc_25FB54:                             // CODE XREF: RString::toUpper(void)+54
                                        // RString::toUpper(void)+70
                ORR             X0, XZR, X19
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_out_of_rangeEv // std::__basic_string_common<true>::__throw_out_of_range(void)
// } // starts at 25FA74
// End of function RString::toUpper(void)


// __int64 __fastcall RString::trimmed(RString *__hidden this)
                .globl _ZN7RString7trimmedEv // weak
_ZN7RString7trimmedEv:                  // CODE XREF: RString::trimmed(void)+C
                                        // DATA XREF: LOAD:0000000000047230

var_50          = -0x50
ptr             = -0x40
var_38          = -0x38
var_30          = -0x30
var_20          = -0x20
var_10          = -0x10
var_s0          =  0

// __unwind {
                SUB             SP, SP, #0x60
                STR             X23, [SP,#0x50+var_30]
                STP             X22, X21, [SP,#0x50+var_20]
                STP             X20, X19, [SP,#0x50+var_10]
                STP             X29, X30, [SP,#0x50+var_s0]
                ADD             X29, SP, #0x50
                MRS             X21, TPIDR_EL0
                LDR             X8, [X21,#0x28]
                ORR             X19, XZR, X0
                STR             X8, [SP,#0x50+var_38]
                LDRB            W8, [X0]
                TBNZ            W8, #0, loc_277408
                UBFM            X9, X8, #1, #0x3F // '?'
                SUBS            W20, W9, #1
                B.ge            loc_277414
                B               loc_277498
// ---------------------------------------------------------------------------

loc_277408:                             // CODE XREF: RString::trimmed(void)+2C
                LDR             X9, [X19,#8]
                SUBS            W20, W9, #1
                B.lt            loc_277498

loc_277414:                             // CODE XREF: RString::trimmed(void)+38
                SBFM            X9, X9, #0, #0x1F
                ADD             X22, X19, #1
                SUB             X23, X9, #1
                TBNZ            W8, #0, loc_277434

loc_277424:                             // CODE XREF: RString::trimmed(void)+CC
                UBFM            W9, W8, #1, #7
                SUBS            XZR, X9, X23
                B.hi            loc_277440
                B               loc_2774C4
// ---------------------------------------------------------------------------

loc_277434:                             // CODE XREF: RString::trimmed(void)+58
                                        // RString::trimmed(void)+C8
                LDR             X9, [X19,#8]
                SUBS            XZR, X9, X23
                B.ls            loc_2774C4

loc_277440:                             // CODE XREF: RString::trimmed(void)+64
                ORR             X9, XZR, X22
                TBZ             W8, #0, loc_27744C
                LDR             X9, [X19,#0x10]

loc_27744C:                             // CODE XREF: RString::trimmed(void)+7C
                LDRB            W8, [X9,X23]
                ORR             W8, W8, #0x20 // ' '
                SUBS            WZR, W8, #0x20 // ' '
                B.ne            loc_277498
                ADD             X8, SP, #0
                MOVZ            W2, #1  // int
                ORR             X0, XZR, X19 // this
                ORR             W1, WZR, W20 // int
                BL	_ZN7RString6removeEii // RString::remove(int,int)
                LDRB            W8, [SP,#0x50+var_50]
                TBZ             W8, #0, loc_277480
                LDR             X0, [SP,#0x50+ptr] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_277480:                             // CODE XREF: RString::trimmed(void)+AC
                SUBS            X23, X23, #1
                B.lt            loc_277498
                LDRB            W8, [X19]
                SUB             W20, W20, #1
                TBNZ            W8, #0, loc_277434
                B               loc_277424
// ---------------------------------------------------------------------------

loc_277498:                             // CODE XREF: RString::trimmed(void)+3C
                                        // RString::trimmed(void)+48
                LDR             X8, [X21,#0x28]
                LDR             X9, [SP,#0x50+var_38]
                SUBS            XZR, X8, X9
                B.ne            loc_2774CC
                ORR             X0, XZR, X19
                LDP             X29, X30, [SP,#0x50+var_s0]
                LDP             X20, X19, [SP,#0x50+var_10]
                LDP             X22, X21, [SP,#0x50+var_20]
                LDR             X23, [SP,#0x50+var_30]
                ADD             SP, SP, #0x60 // '`'
                RET
// ---------------------------------------------------------------------------

loc_2774C4:                             // CODE XREF: RString::trimmed(void)+68
                                        // RString::trimmed(void)+74
                ORR             X0, XZR, X19
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_out_of_rangeEv // std::__basic_string_common<true>::__throw_out_of_range(void)
// ---------------------------------------------------------------------------

loc_2774CC:                             // CODE XREF: RString::trimmed(void)+DC
                BL	__stack_chk_fail
// } // starts at 2773C8
// End of function RString::trimmed(void)


// __int64 __fastcall CApiLicense::verifyLicense(CApiLicense *__hidden this)
                .globl _ZN11CApiLicense13verifyLicenseEv
_ZN11CApiLicense13verifyLicenseEv:      // CODE XREF: CApiLicense::verifyLicense(void)+C
                                        // DATA XREF: LOAD:0000000000045C40

var_50          = -0x50
var_48          = -0x48
ptr             = -0x40
var_38          = -0x38
var_30          = -0x30
var_20          = -0x20
var_10          = -0x10
var_s0          =  0

// __unwind { // __gxx_personality_v0
                SUB             SP, SP, #0x60
                STP             X24, X23, [SP,#0x50+var_30]
                STP             X22, X21, [SP,#0x50+var_20]
                STP             X20, X19, [SP,#0x50+var_10]
                STP             X29, X30, [SP,#0x50+var_s0]
                ADD             X29, SP, #0x50
                MRS             X22, TPIDR_EL0
                LDR             X8, [X22,#0x28]
                ADRP            X1, :pg_hi21:bytezr
                ORR             X19, XZR, X0
                ADD             X1, X1, #:lo12:bytezr // s
                ADD             X0, SP, #0 // int
                STR             X8, [SP,#0x50+var_38]
                ADD             X21, SP, #0
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc // std::string::basic_string<decltype(nullptr)>(char const*)
                ADD             X20, X19, #0x1A0
                SUBS            XZR, X20, X21
                B.eq            loc_277638
                LDRB            W8, [SP,#0x50+var_50]
                LDP             X10, X9, [SP,#0x50+var_48]
                ORR             X11, X21, #1
                ANDS            WZR, W8, #1
                UBFM            X12, X8, #1, #0x3F // '?'
                CSEL            X1, X11, X9, eq // src
                CSEL            X2, X12, X10, eq // n
//   try {
                ORR             X0, XZR, X20 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm // std::string::assign(char const*,ulong)
//   } // starts at 277630

loc_277638:                             // CODE XREF: CApiLicense::verifyLicense(void)+44
                LDRB            W8, [SP,#0x50+var_50]
                TBZ             W8, #0, loc_277648
                LDR             X0, [SP,#0x50+ptr] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_277648:                             // CODE XREF: CApiLicense::verifyLicense(void)+70
		ADRP	X1, :pg_hi21:bytezr // s
		ADD	X1, X1, #:lo12:bytezr // s
                ADD             X0, SP, #0 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc // std::string::basic_string<decltype(nullptr)>(char const*)
//   try {
                ADD             X2, SP, #0 // RString *
                ORR             X0, XZR, X19 // this
                ORR             X1, XZR, X20 // RString *
                BL	_ZN11CApiLicense13getLicenseKeyER7RStringS1_ // CApiLicense::getLicenseKey(RString &,RString &)
                ORR             X0, XZR, X19
                ORR             W1, WZR, WZR
                ORR             W2, WZR, WZR
                BL	_ZN11CApiLicense15setBundleEnableE7OptTypeb // CApiLicense::setBundleEnable(OptType,bool)
//   } // starts at 277658
                LDRB            W8, [X19,#0x1A0]
                LDR             X9, [X19,#0x1A8]
                UBFM            X10, X8, #1, #0x3F // '?'
                ANDS            WZR, W8, #1
                CSEL            X8, X10, X9, eq
                CBZ             X8, loc_2777B8
                LDRB            W8, [SP,#0x50+var_50]
                LDR             X9, [SP,#0x50+var_48]
                UBFM            X10, X8, #1, #0x3F // '?'
                ANDS            WZR, W8, #1
                CSEL            X8, X10, X9, eq
                CBZ             X8, loc_2777B8
                LDR             X24, [X19,#0x78]
                ADD             X23, X19, #0x80
                SUBS            XZR, X23, X24
                B.ne            loc_2776C8
                B               loc_2777B8
// ---------------------------------------------------------------------------

loc_2776BC:                             // CODE XREF: CApiLicense::verifyLicense(void)+1CC
                ORR             X24, XZR, X9

loc_2776C0:                             // CODE XREF: CApiLicense::verifyLicense(void)+1B8
                                        // CApiLicense::verifyLicense(void)+1E8
                SUBS            XZR, X23, X24
                B.eq            loc_2777B8

loc_2776C8:                             // CODE XREF: CApiLicense::verifyLicense(void)+E8
                LDR             X21, [X24,#0x28]
//   try {
                ORR             X0, XZR, X19 // this
                ORR             X1, XZR, X21 // COptInfo *
                ORR             X2, XZR, X20 // RString *
                BL	_ZN11CApiLicense12verifyOptionEP8COptInfoR7RStringS3_ // CApiLicense::verifyOption(COptInfo *,RString &,RString &)
//   } // starts at 2776CC
                TBZ             W0, #0, loc_277770
//   try {
                ORR             X0, XZR, X21 // this
                BL	_ZN8COptInfo14getLicenseTimeEv // COptInfo::getLicenseTime(void)
                SUB             W8, W0, #2
                SUBS            WZR, W8, #5
                B.cs            loc_277718
                ORR             X0, XZR, X21 // this
                BL	_ZN8COptInfo11getLeftDaysEv // COptInfo::getLeftDays(void)
                CBNZ            W0, loc_277748
                ORR             X0, XZR, X21 // this
                BL	_ZN8COptInfo7getTypeEv // COptInfo::getType(void)
                ORR             W1, WZR, W0
                ORR             X0, XZR, X19
                BL	_ZN11CApiLicense9deleteOptE7OptType // CApiLicense::deleteOpt(OptType)
                B               loc_277748
// ---------------------------------------------------------------------------

loc_277718:                             // CODE XREF: CApiLicense::verifyLicense(void)+124
                SUBS            WZR, W0, #1
                B.ne            loc_277748
                ORR             X0, XZR, X21 // this
                BL	_ZN8COptInfo10getRunTimeEv // COptInfo::getRunTime(void)
                ORR             X0, XZR, X21 // this
                BL	_ZN8COptInfo13getRemainTimeEv // COptInfo::getRemainTime(void)
                CBNZ            W0, loc_277748
                ORR             X0, XZR, X21 // this
                BL	_ZN8COptInfo7getTypeEv // COptInfo::getType(void)
                ORR             W1, WZR, W0
                ORR             X0, XZR, X19
                BL	_ZN11CApiLicense9deleteOptE7OptType // CApiLicense::deleteOpt(OptType)

loc_277748:                             // CODE XREF: CApiLicense::verifyLicense(void)+130
                                        // CApiLicense::verifyLicense(void)+148
                ORR             X0, XZR, X21 // this
                BL	_ZN8COptInfo7getTypeEv // COptInfo::getType(void)
                CBNZ            W0, loc_277770
                ORR             X0, XZR, X21 // this
                BL	_ZN8COptInfo15getLicenseValidEv // COptInfo::getLicenseValid(void)
                TBZ             W0, #0, loc_277770
                MOVZ            W2, #1
                ORR             X0, XZR, X19
                ORR             W1, WZR, WZR
                BL	_ZN11CApiLicense15setBundleEnableE7OptTypeb // CApiLicense::setBundleEnable(OptType,bool)
//   } // starts at 2776E0

loc_277770:                             // CODE XREF: CApiLicense::verifyLicense(void)+110
                                        // CApiLicense::verifyLicense(void)+184
                LDR             X8, [X24,#8]
                CBZ             X8, loc_277788

loc_277778:                             // CODE XREF: CApiLicense::verifyLicense(void)+1B4
                ORR             X24, XZR, X8
                LDR             X8, [X8]
                CBNZ            X8, loc_277778
                B               loc_2776C0
// ---------------------------------------------------------------------------

loc_277788:                             // CODE XREF: CApiLicense::verifyLicense(void)+1A8
                ORR             X8, XZR, X24
                LDR             X9, [X8,#0x10]!
                LDR             X10, [X9]
                SUBS            XZR, X10, X24
                B.eq            loc_2776BC

loc_27779C:                             // CODE XREF: CApiLicense::verifyLicense(void)+1E4
                LDR             X9, [X8]
                ORR             X8, XZR, X9
                LDR             X24, [X8,#0x10]!
                LDR             X10, [X24]
                SUBS            XZR, X10, X9
                B.ne            loc_27779C
                B               loc_2776C0
// ---------------------------------------------------------------------------

loc_2777B8:                             // CODE XREF: CApiLicense::verifyLicense(void)+C0
                                        // CApiLicense::verifyLicense(void)+D8
                LDRB            W8, [SP,#0x50+var_50]
                TBZ             W8, #0, loc_2777C8
                LDR             X0, [SP,#0x50+ptr] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_2777C8:                             // CODE XREF: CApiLicense::verifyLicense(void)+1F0
                LDR             X8, [X22,#0x28]
                LDR             X9, [SP,#0x50+var_38]
                SUBS            XZR, X8, X9
                B.ne            loc_2777F0
                LDP             X29, X30, [SP,#0x50+var_s0]
                LDP             X20, X19, [SP,#0x50+var_10]
                LDP             X22, X21, [SP,#0x50+var_20]
                LDP             X24, X23, [SP,#0x50+var_30]
                ADD             SP, SP, #0x60 // '`'
                RET
// ---------------------------------------------------------------------------

loc_2777F0:                             // CODE XREF: CApiLicense::verifyLicense(void)+208
                BL	__stack_chk_fail
// ---------------------------------------------------------------------------
//   cleanup() // owned by 277630
                B               loc_277800
// ---------------------------------------------------------------------------
//   cleanup() // owned by 277658
                B               loc_277800
// ---------------------------------------------------------------------------
//   cleanup() // owned by 2776CC
                B               loc_277800
// ---------------------------------------------------------------------------

loc_277800:                             // CODE XREF: CApiLicense::verifyLicense(void)+228
                                        // CApiLicense::verifyLicense(void)+22C
//   cleanup() // owned by 2776E0
                LDRB            W8, [SP,#0x50+var_50]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_277814
                LDR             X0, [SP,#0x50+ptr] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_277814:                             // CODE XREF: CApiLicense::verifyLicense(void)+23C
                ORR             X0, XZR, X19
                BL              sub_A1036C
// } // starts at 2775CC
// End of function CApiLicense::verifyLicense(void)


// __int64 __fastcall CApiLicense::getLicenseKey(CApiLicense *__hidden this, RString *, RString *)
                .globl _ZN11CApiLicense13getLicenseKeyER7RStringS1_
_ZN11CApiLicense13getLicenseKeyER7RStringS1_:
                                        // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+C
                                        // DATA XREF: LOAD:00000000000594A0

var_1E0         = -0x1E0
var_1D0         = -0x1D0
var_1C8         = -0x1C8
var_1B8         = -0x1B8
var_1B0         = -0x1B0
var_1A0         = -0x1A0
var_190         = -0x190
var_180         = -0x180
var_170         = -0x170
ptr             = -0x168
var_160         = -0x160
var_150         = -0x150
var_140         = -0x140
var_138         = -0x138
var_130         = -0x130
var_128         = -0x128
var_120         = -0x120
var_118         = -0x118
n               = -0x108
src             = -0xF8
var_F0          = -0xF0
var_EC          = -0xEC
fd              = -0xE8
var_E0          = -0xE0
var_D0          = -0xD0
var_C4          = -0xC4
var_C0          = -0xC0
var_B0          = -0xB0
var_60          = -0x60
var_50          = -0x50
var_40          = -0x40
var_30          = -0x30
var_20          = -0x20
var_10          = -0x10
var_s0          =  0

// __unwind { // __gxx_personality_v0
                SUB             SP, SP, #0x1F0
                STP             X28, X27, [SP,#0x1E0+var_50]
                STP             X26, X25, [SP,#0x1E0+var_40]
                STP             X24, X23, [SP,#0x1E0+var_30]
                STP             X22, X21, [SP,#0x1E0+var_20]
                STP             X20, X19, [SP,#0x1E0+var_10]
                STP             X29, X30, [SP,#0x1E0+var_s0]
                ADD             X29, SP, #0x1E0
                MRS             X26, TPIDR_EL0
                LDR             X8, [X26,#0x28]
                ORR             X21, XZR, X2
                ORR             X19, XZR, X1
                ADD             X0, X0, #8 // this
                STUR            X8, [X29,#var_60]
                STP             XZR, XZR, [SP,#0x1E0+var_118]
                STP             XZR, XZR, [SP,#0x1E0+var_128]
                STP             XZR, XZR, [SP,#0x1E0+var_138]
//   try {
                BL	_ZNK8CApiBase5getIdEv // CApiBase::getId(void)
                BL	_ZN9CApiSetup14getPrivateBaseEi // CApiSetup::getPrivateBase(int)
//   } // starts at 2787EC
                ADD             W20, W0, #0x1F
//   try {
                ORR             W0, WZR, W20 // this
                BL	_ZN9CApiSetup13getPrivateLenEi // CApiSetup::getPrivateLen(int)
//   } // starts at 2787F8
//   try {
		ADRP	X1, :pg_hi21:bytezr // s
		ADD	X1, X1, #:lo12:bytezr // s
                SUB             X0, X29, #-var_E0 // int
                SUB             X22, X29, #-var_E0
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc // std::string::basic_string<decltype(nullptr)>(char const*)
//   } // starts at 278800
                SUBS            XZR, X22, X19
                B.eq            loc_278844
                LDURB           W8, [X29,#var_E0]
                LDP             X10, X9, [X29,#var_E0+8]
                SUB             X11, X29, #-var_E0
                ORR             X11, X11, #1
                ANDS            WZR, W8, #1
                UBFM            X12, X8, #1, #0x3F // '?'
                CSEL            X1, X11, X9, eq // src
                CSEL            X2, X12, X10, eq // n
//   try {
                ORR             X0, XZR, X19 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm // std::string::assign(char const*,ulong)
//   } // starts at 27883C

loc_278844:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+70
                LDURB           W8, [X29,#var_E0]
                TBZ             W8, #0, loc_278854
                LDUR            X0, [X29,#var_D0] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_278854:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+A0
//   try {                               // s
		ADRP	X1, :pg_hi21:bytezr
		ADD	X1, X1, #:lo12:bytezr
                SUB             X0, X29, #-var_E0 // int
                SUB             X22, X29, #-var_E0
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc // std::string::basic_string<decltype(nullptr)>(char const*)
//   } // starts at 278854
                SUBS            XZR, X22, X21
                B.eq            loc_278898
                LDURB           W8, [X29,#var_E0]
                LDP             X10, X9, [X29,#var_E0+8]
                SUB             X11, X29, #-var_E0
                ORR             X11, X11, #1
                ANDS            WZR, W8, #1
                UBFM            X12, X8, #1, #0x3F // '?'
                CSEL            X1, X11, X9, eq // src
                CSEL            X2, X12, X10, eq // n
//   try {
                ORR             X0, XZR, X21 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm // std::string::assign(char const*,ulong)
//   } // starts at 278890

loc_278898:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+C4
                LDURB           W8, [X29,#var_E0]
                TBZ             W8, #0, loc_2788A8
                LDUR            X0, [X29,#var_D0] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_2788A8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+F4
//   try {
                ADRP            X0, :pg_hi21:_ZN11CApiLicense12LICENSE_PATHE_ptr
                LDR             X0, [X0,#:lo12:_ZN11CApiLicense12LICENSE_PATHE_ptr] // int
		ADRP	X1, :pg_hi21:aRkeyData // "RKey.data"
		ADD	X1, X1, #:lo12:aRkeyData // "RKey.data"
                SUB             X8, X29, #-var_E0
                BL              sub_25874C
//   } // starts at 2788A8
                LDURB           W8, [X29,#var_E0]
                STP             XZR, XZR, [SP,#0x1E0+var_150+8]
                STR             XZR, [SP,#0x1E0+var_150]
                TBNZ            W8, #0, loc_2788E4
                LDUR            Q0, [X29,#var_E0]
                LDUR            X8, [X29,#var_D0]
                STR             Q0, [SP,#0x1E0+var_150]
                STR             X8, [SP,#0x1E0+var_140]
                B               loc_278950
// ---------------------------------------------------------------------------

loc_2788E4:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+124
                LDUR            X22, [X29,#var_E0+8]
                ADDS            XZR, X22, #0x10
                B.cs            loc_279238
                LDUR            X23, [X29,#var_D0]
                SUBS            XZR, X22, #0x17
                B.cs            loc_278914
                ADD             X9, SP, #0x1E0+var_150
                UBFM            W8, W22, #0x1F, #0x1E
                ORR             X24, X9, #1
                STRB            W8, [SP,#0x1E0+var_150]
                CBNZ            X22, loc_278934
                B               loc_278944
// ---------------------------------------------------------------------------

loc_278914:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+150
                ADD             X8, X22, #0x10
                AND             X25, X8, #0xFFFFFFFFFFFFFFF0
//   try {
                ORR             X0, XZR, X25 // unsigned __int64
                BL	_Znwm  // operator new(ulong)
//   } // starts at 27891C
                ORR             X8, X25, #1
                ORR             X24, XZR, X0
                STP             X8, X22, [SP,#0x1E0+var_150]
                STR             X0, [SP,#0x1E0+var_140]

loc_278934:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+164
                ORR             X0, XZR, X24 // dest
                ORR             X1, XZR, X23 // src
                ORR             X2, XZR, X22 // n
                BL	memcpy

loc_278944:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+168
                LDUR            X0, [X29,#var_D0] // ptr
                STRB            WZR, [X24,X22]
                BL	_ZdlPv // operator delete(void *)

loc_278950:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+138
                LDRB            W8, [SP,#0x1E0+var_150]
                LDR             X9, [SP,#0x1E0+var_140]
                ADD             X10, SP, #0x1E0+var_150
                ORR             X10, X10, #1
                ANDS            WZR, W8, #1
                CSEL            X0, X10, X9, eq // name
                ORR             W1, WZR, WZR // type
                BL	access
                CBZ             W0, loc_2789B0
//   try {
                ADRP            X0, :pg_hi21:_ZN11CApiLicense12LICENSE_PATHE_ptr
                LDR             X0, [X0,#:lo12:_ZN11CApiLicense12LICENSE_PATHE_ptr] // int
		ADRP	X1, :pg_hi21:(aRkeyData+1) // s
		ADD	X1, X1, #:lo12:(aRkeyData+1) // s
                ADD             X8, SP, #0x1E0+n
                BL              sub_25874C
//   } // starts at 278974
                LDRB            W8, [SP,#0x1E0+n]
                STP             XZR, XZR, [X29,#var_E0+8]
                STUR            XZR, [X29,#var_E0]
                TBNZ            W8, #0, loc_2789B8
                LDUR            Q0, [SP,#0x1E0+n]
                LDR             X8, [SP,#0x1E0+src]
                STUR            Q0, [X29,#var_E0]
                STUR            X8, [X29,#var_D0]
                B               loc_278A1C
// ---------------------------------------------------------------------------

loc_2789B0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+1C8
                MOVZ            W28, #1
                B               loc_278A68
// ---------------------------------------------------------------------------

loc_2789B8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+1F0
                LDR             X22, [SP,#0x1E0+n+8]
                ADDS            XZR, X22, #0x10
                B.cs            loc_279240
                LDR             X23, [SP,#0x1E0+src]
                SUBS            XZR, X22, #0x17
                B.cs            loc_2789E8
                SUB             X9, X29, #-var_E0
                UBFM            W8, W22, #0x1F, #0x1E
                ORR             X24, X9, #1
                STURB           W8, [X29,#var_E0]
                CBNZ            X22, loc_278A08
                B               loc_278A18
// ---------------------------------------------------------------------------

loc_2789E8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+224
                ADD             X8, X22, #0x10
                AND             X25, X8, #0xFFFFFFFFFFFFFFF0
//   try {
                ORR             X0, XZR, X25 // unsigned __int64
                BL	_Znwm  // operator new(ulong)
//   } // starts at 2789F0
                ORR             X8, X25, #1
                ORR             X24, XZR, X0
                STP             X8, X22, [X29,#var_E0]
                STUR            X0, [X29,#var_D0]

loc_278A08:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+238
                ORR             X0, XZR, X24 // dest
                ORR             X1, XZR, X23 // src
                ORR             X2, XZR, X22 // n
                BL	memcpy

loc_278A18:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+23C
                STRB            WZR, [X24,X22]

loc_278A1C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+204
                LDURB           W8, [X29,#var_E0]
                LDP             X10, X9, [X29,#var_E0+8]
                SUB             X11, X29, #-var_E0
                ORR             X11, X11, #1
                ANDS            WZR, W8, #1
                UBFM            X12, X8, #1, #0x3F // '?'
                CSEL            X1, X11, X9, eq // src
                CSEL            X2, X12, X10, eq // n
//   try {
                ADD             X0, SP, #0x1E0+var_150 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm // std::string::assign(char const*,ulong)
//   } // starts at 278A3C
                LDURB           W8, [X29,#var_E0]
                TBZ             W8, #0, loc_278A54
                LDUR            X0, [X29,#var_D0] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_278A54:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+2A0
                LDRB            W8, [SP,#0x1E0+n]
                TBZ             W8, #0, loc_278A64
                LDR             X0, [SP,#0x1E0+src] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_278A64:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+2B0
                ORR             W28, WZR, WZR

loc_278A68:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+20C
//   try {                               // this
                ADD             X0, SP, #0x1E0+n
                ADD             X1, SP, #0x1E0+var_150 // RString *
                BL	_ZN5RFileC2ERK7RString // RFile::RFile(RString const&)
//   } // starts at 278A68
                LDRB            W8, [SP,#0x1E0+n]
                LDR             X9, [SP,#0x1E0+n+8]
                UBFM            X10, X8, #1, #0x3F // '?'
                ANDS            WZR, W8, #1
                CSEL            X9, X10, X9, eq
                CBZ             X9, loc_2791B0
                LDR             X9, [SP,#0x1E0+src]
                ADD             X10, SP, #0x1E0+n
                ORR             X10, X10, #1
                ANDS            WZR, W8, #1
                CSEL            X0, X10, X9, eq
//   try {
                ORR             W1, WZR, WZR
                BL	__open_2
//   } // starts at 278AA0
                ADDS            WZR, W0, #1
                STR             W0, [SP,#0x1E0+fd]
                B.eq            loc_2791B0
                SUB             X1, X29, #-var_E0 // buf
                BL	fstat
                CBNZ            W0, loc_278AD8
                LDUR            W8, [X29,#var_D0]
                AND             W8, W8, #0xF000
                SUBS            WZR, W8, #8,LSL#12
                B.ne            loc_278AD8
                LDUR            X8, [X29,#var_B0]
                STR             W8, [SP,#0x1E0+var_F0]

loc_278AD8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+314
                                        // CApiLicense::getLicenseKey(RString &,RString &)+324
                LDR             W8, [SP,#0x1E0+fd]
                MOVZ            W9, #1
                STRB            W9, [SP,#0x1E0+var_EC]
                ADDS            WZR, W8, #1
                B.eq            loc_2791B0
                LDR             W23, [SP,#0x1E0+var_F0]
                SUBS            WZR, W23, #1
                B.lt            loc_278E58
                ADD             W8, W23, #4
                ADD             W9, W23, #7
                SUBS            WZR, W8, #0
                CSEL            W8, W9, W8, lt
                AND             W8, W8, #0xFFFFFFFC
                ORR             W8, W8, #1
                SBFM            X24, X8, #0, #0x1F
                ORR             X0, XZR, X24 // size
                BL	malloc
                ORR             W1, WZR, WZR // c
                ORR             X2, XZR, X24 // n
                ORR             X22, XZR, X0
                BL	memset
                LDR             W0, [SP,#0x1E0+fd]
//   try {
                MOVN            X3, #0
                ORR             X1, XZR, X22
                ORR             X2, XZR, X23
                BL	__read_chk
                LDR             W0, [SP,#0x1E0+fd] // fd
                ADDS            WZR, W0, #1
                B.eq            loc_278B58
                BL	close
//   } // starts at 278B30
                MOVN            W8, #0
                STR             W8, [SP,#0x1E0+fd]

loc_278B58:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+3A0
                SBFM            X24, X23, #0, #0x1F
                STRB            WZR, [SP,#0x1E0+var_EC]
                CBZ             W28, loc_278BCC
//   try {
                SUB             X8, X29, #-var_E0
                ORR             X1, XZR, X24 // unsigned __int64
                BL	_ZN11CApiLicense18generate_somethingEm // CApiLicense::generate_something(ulong)
//   } // starts at 278B64
//   try {
                ADD             X0, SP, #0x1E0+ptr
                SUB             X1, X29, #-var_E0
                BL	_ZNSt6__ndk16vectorIcNS_9allocatorIcEEEC2ERKS3_ // std::vector<char>::vector(std::vector<char> const&)
//   } // starts at 278B70
                LDUR            W9, [X29,#var_E0+8]
                LDUR            W10, [X29,#var_E0]
                LDR             X0, [SP,#0x1E0+ptr] // ptr
                ORR             X8, XZR, XZR
                SUB             W9, W9, W10

loc_278B90:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+408
                UDIV            W10, W8, W9
                MSUB            W10, W10, W9, W8
                LDRB            W11, [X22,X8]
                LDRB            W10, [X0,W10,UXTW]
                EOR             W10, W11, W10
                STRB            W10, [X22,X8]
                ADD             X8, X8, #1
                SUBS            XZR, X23, X8
                B.ne            loc_278B90
                STR             X0, [SP,#0x1E0+var_160]
                BL	_ZdlPv // operator delete(void *)
                LDUR            X0, [X29,#var_E0] // ptr
                CBZ             X0, loc_278BCC
                STUR            X0, [X29,#var_E0+8]
                BL	_ZdlPv // operator delete(void *)

loc_278BCC:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+3B8
                                        // CApiLicense::getLicenseKey(RString &,RString &)+418
//   try {                               // this
                SUB             X0, X29, #-var_E0
                ORR             X1, XZR, X22 // s
                ORR             W2, WZR, W24 // int
                BL	_ZN10RByteArrayC2EPKci // RByteArray::RByteArray(char const*,int)
//   } // starts at 278BCC
                LDP             X1, X2, [X29,#var_E0] // src
//   try {
                ADD             X0, SP, #0x1E0+var_120 // int
                BL	_ZNSt6__ndk16vectorIcNS_9allocatorIcEEE6assignIPcEENS_9enable_ifIXaasr21__is_forward_iteratorIT_EE5valuesr16is_constructibleIcNS_15iterator_traitsIS7_E9referenceEEE5valueEvE4typeES7_S7_
//   } // starts at 278BE0
                LDUR            X0, [X29,#var_E0] // ptr
                CBZ             X0, loc_278BF8
                STUR            X0, [X29,#var_E0+8]
                BL	_ZdlPv // operator delete(void *)

loc_278BF8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+444
//   try {                               // this
                SUB             X0, X29, #-var_E0
                ORR             X1, XZR, X22 // s
                ORR             W2, WZR, W23 // int
                BL	_ZN10RByteArrayC2EPKci // RByteArray::RByteArray(char const*,int)
//   } // starts at 278BF8
                LDP             X1, X2, [X29,#var_E0] // src
//   try {
                ADD             X0, SP, #0x1E0+var_138 // int
                BL	_ZNSt6__ndk16vectorIcNS_9allocatorIcEEE6assignIPcEENS_9enable_ifIXaasr21__is_forward_iteratorIT_EE5valuesr16is_constructibleIcNS_15iterator_traitsIS7_E9referenceEEE5valueEvE4typeES7_S7_
//   } // starts at 278C0C
                LDUR            X0, [X29,#var_E0] // ptr
                CBZ             X0, loc_278C24
                STUR            X0, [X29,#var_E0+8]
                BL	_ZdlPv // operator delete(void *)

loc_278C24:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+470
                LDP             X9, X8, [SP,#0x1E0+var_120]
                SUB             X25, X8, X9
                ANDS            XZR, X25, #3
                B.ne            loc_278E50
//   try {
                ORR             X0, XZR, XZR // this
                BL	_ZN6CXXTEA7setKeysEPi // CXXTEA::setKeys(int *)
                LDR             X0, [SP,#0x1E0+var_120] // this
                SBFM            X1, X25, #0, #0x1F // int *
                BL	_ZN6CXXTEA6decodeEPil // CXXTEA::decode(int *,long)
//   } // starts at 278C34
                CBNZ            W0, loc_278E50
                LDP             X1, X8, [SP,#0x1E0+var_120]
                STP             XZR, XZR, [SP,#0x1E0+var_180]
                STR             XZR, [SP,#0x1E0+var_170]
                SUB             X8, X8, X1
                AND             X25, X8, #0xFFFFFFFF
                SUBS            XZR, X25, #0x17
                B.cs            loc_278C80
                ADD             X9, SP, #0x1E0+var_180
                UBFM            W8, W8, #0x1F, #0x1E
                ORR             X27, X9, #1
                STRB            W8, [SP,#0x1E0+var_180]
                CBNZ            X25, loc_278CA4
                B               loc_278CB0
// ---------------------------------------------------------------------------

loc_278C80:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+4BC
                ADD             X8, X25, #0x10
                AND             X0, X8, #0x1FFFFFFF0 // unsigned __int64
//   try {
                STP             X0, X1, [SP,#0x1E0+var_1E0]
                BL	_Znwm  // operator new(ulong)
//   } // starts at 278C88
                LDP             X8, X1, [SP,#0x1E0+var_1E0] // src
                ORR             X27, XZR, X0
                STR             X0, [SP,#0x1E0+var_170]
                ORR             X8, X8, #1
                STP             X8, X25, [SP,#0x1E0+var_180]

loc_278CA4:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+4D0
                ORR             X0, XZR, X27 // dest
                ORR             X2, XZR, X25 // n
                BL	memcpy

loc_278CB0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+4D4
                STRB            WZR, [X27,X25]
//   try {
		ADRP	X1, :pg_hi21:asc_A2C12F // s
		ADD	X1, X1, #:lo12:asc_A2C12F // s
                ADD             X0, SP, #0x1E0+var_1A0 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc // std::string::basic_string<decltype(nullptr)>(char const*)
//   } // starts at 278CB4
//   try {
                SUB             X8, X29, #-var_E0
                ADD             X0, SP, #0x1E0+var_180 // this
                ADD             X1, SP, #0x1E0+var_1A0 // RString *
                BL	_ZN7RString5splitERKS_ // RString::split(RString const&)
//   } // starts at 278CC4
                LDRB            W8, [SP,#0x1E0+var_1A0]
                TBZ             W8, #0, loc_278CE4
                LDR             X0, [SP,#0x1E0+var_190] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_278CE4:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+530
                LDRB            W8, [SP,#0x1E0+var_180]
                TBZ             W8, #0, loc_278CF4
                LDR             X0, [SP,#0x1E0+var_170] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_278CF4:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+540
                LDP             X1, X8, [X29,#var_E0]
                SUB             X8, X8, X1
                SUBS            XZR, X8, #0x30 // '0'
                B.ne            loc_278DFC
//   try {
                ADD             X0, SP, #0x1E0+var_180
                ADD             X25, SP, #0x1E0+var_180
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_ // std::string::basic_string(std::string const&)
//   } // starts at 278D04
                SUBS            XZR, X25, X21
                B.eq            loc_278D40
                LDRB            W8, [SP,#0x1E0+var_180]
                LDP             X10, X9, [SP,#0x1E0+var_180+8]
                ADD             X11, SP, #0x1E0+var_180
                ORR             X11, X11, #1
                ANDS            WZR, W8, #1
                UBFM            X12, X8, #1, #0x3F // '?'
                CSEL            X1, X11, X9, eq // src
                CSEL            X2, X12, X10, eq // n
//   try {
                ORR             X0, XZR, X21 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm // std::string::assign(char const*,ulong)
//   } // starts at 278D38

loc_278D40:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+56C
                LDRB            W8, [SP,#0x1E0+var_180]
                TBZ             W8, #0, loc_278D50
                LDR             X0, [SP,#0x1E0+var_170] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_278D50:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+59C
                LDP             X8, X9, [X29,#var_E0]
                ORR             X10, XZR, #0xAAAAAAAAAAAAAAAA
                MOVK            X10, #0xAAAB
                SUB             X9, X9, X8
                SBFM            X9, X9, #3, #0x3F // '?'
                MADD            X9, X9, X10, XZR
                SUBS            XZR, X9, #1
                B.ls            loc_279258
                ADD             X1, X8, #0x18
//   try {
                ADD             X0, SP, #0x1E0+var_180
                ADD             X21, SP, #0x1E0+var_180
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_ // std::string::basic_string(std::string const&)
//   } // starts at 278D74
                SUBS            XZR, X21, X19
                B.eq            loc_278DB0
                LDRB            W8, [SP,#0x1E0+var_180]
                LDP             X10, X9, [SP,#0x1E0+var_180+8]
                ADD             X11, SP, #0x1E0+var_180
                ORR             X11, X11, #1
                ANDS            WZR, W8, #1
                UBFM            X12, X8, #1, #0x3F // '?'
                CSEL            X1, X11, X9, eq // src
                CSEL            X2, X12, X10, eq // n
//   try {
                ORR             X0, XZR, X19 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm // std::string::assign(char const*,ulong)
//   } // starts at 278DA8

loc_278DB0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+5DC
                LDRB            W8, [SP,#0x1E0+var_180]
                TBZ             W8, #0, loc_278DC0
                LDR             X0, [SP,#0x1E0+var_170] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_278DC0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+60C
//   try {                               // this
                ORR             X0, XZR, X19
                BL	_ZN7RString7trimmedEv // RString::trimmed(void)
                ORR             W0, WZR, W20 // this
                BL	_ZN9CApiSetup13getPrivateLenEi // CApiSetup::getPrivateLen(int)
                SUBS            WZR, W23, W0
                B.eq            loc_278DE0
                ORR             W0, WZR, W20 // this
                BL	_ZN9CApiSetup18removePrivateSetupEi // CApiSetup::removePrivateSetup(int)

loc_278DE0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+62C
                ORR             W0, WZR, W20 // this
                ORR             X1, XZR, X22 // void *
                ORR             W2, WZR, W24 // void *
                BL	_ZN9CApiSetup16savePrivateSetupEiPvi // CApiSetup::savePrivateSetup(int,void *,int)
                SUBS            WZR, W24, W0
                B.ne            loc_278DFC
                BL	_Z13API_Save2Framv // API_Save2Fram(void)
//   } // starts at 278DC0

loc_278DFC:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+558
                                        // CApiLicense::getLicenseKey(RString &,RString &)+64C
                LDUR            X19, [X29,#var_E0]
                CBZ             X19, loc_278E50
                LDUR            X8, [X29,#var_E0+8]
                SUBS            XZR, X8, X19
                B.eq            loc_278E44
                ORR             X20, XZR, X8
                LDRB            W9, [X20,#-0x18]!
                TBNZ            W9, #0, loc_278E30

loc_278E1C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+684
                                        // CApiLicense::getLicenseKey(RString &,RString &)+690
                SUBS            XZR, X19, X20
                ORR             X8, XZR, X20
                B.eq            loc_278E3C
                LDRB            W9, [X20,#-0x18]!
                TBZ             W9, #0, loc_278E1C

loc_278E30:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+670
                LDUR            X0, [X8,#-8] // ptr
                BL	_ZdlPv // operator delete(void *)
                B               loc_278E1C
// ---------------------------------------------------------------------------

loc_278E3C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+67C
                LDUR            X0, [X29,#var_E0]
                B               loc_278E48
// ---------------------------------------------------------------------------

loc_278E44:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+664
                ORR             X0, XZR, X19 // ptr

loc_278E48:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+698
                STUR            X19, [X29,#var_E0+8]
                BL	_ZdlPv // operator delete(void *)

loc_278E50:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+488
                                        // CApiLicense::getLicenseKey(RString &,RString &)+4A0
                ORR             X0, XZR, X22 // ptr
                BL	free

loc_278E58:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+34C
                TBNZ            W28, #0, loc_2791B0
//   try {
		ADRP	X0, :pg_hi21:aSrcCppScopeApi_6 // "../../../../src/cpp/scope/api/license/l"...
		ADD	X0, X0, #:lo12:aSrcCppScopeApi_6 // "../../../../src/cpp/scope/api/license/l"...
                MOVZ            W1, #0x2F // '/' // int
                MOVZ            W2, #0x32 // '2' // size_t
                BL	__strrchr_chk
                ADD             X3, X0, #1
                ADRP            X1, :pg_hi21:aRigolScope // "[RIGOL.SCOPE]"
                ADRP            X2, :pg_hi21:aSSDGenNewKey // "[%s][%s][%d]:Gen NEW KEY"
                ADRP            X4, :pg_hi21:aGetlicensekey // "getLicenseKey"
                ADD             X1, X1, #:lo12:aRigolScope // "[RIGOL.SCOPE]"
                ADD             X2, X2, #:lo12:aSSDGenNewKey // "[%s][%s][%d]:Gen NEW KEY"
                ADD             X4, X4, #:lo12:aGetlicensekey // "getLicenseKey"
                MOVZ            W0, #6  // prio
                MOVZ            W5, #0x6EA
                BL	__android_log_print
                MOVZ            W0, #0x4B40 // useconds
                MOVK            W0, #0x4C,LSL#16 // 'L'
                BL	usleep
//   } // starts at 278E5C
//   try {
                ADRP            X0, :pg_hi21:_ZN11CApiLicense12LICENSE_PATHE_ptr
                LDR             X0, [X0,#:lo12:_ZN11CApiLicense12LICENSE_PATHE_ptr] // int
		ADRP	X1, :pg_hi21:aRkeyData // "RKey.data"
		ADD	X1, X1, #:lo12:aRkeyData // "RKey.data"
                SUB             X8, X29, #-var_E0
                BL              sub_25874C
//   } // starts at 278EA4
                LDURB           W8, [X29,#var_E0]
                STP             XZR, XZR, [SP,#0x1E0+var_180+8]
                STR             XZR, [SP,#0x1E0+var_180]
                TBNZ            W8, #0, loc_278EE0
                LDUR            Q0, [X29,#var_E0]
                LDUR            X8, [X29,#var_D0]
                STR             Q0, [SP,#0x1E0+var_180]
                STR             X8, [SP,#0x1E0+var_170]
                B               loc_278F4C
// ---------------------------------------------------------------------------

loc_278EE0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+720
                LDUR            X19, [X29,#var_E0+8]
                ADDS            XZR, X19, #0x10
                B.cs            loc_279248
                LDUR            X20, [X29,#var_D0]
                SUBS            XZR, X19, #0x17
                B.cs            loc_278F10
                ADD             X9, SP, #0x1E0+var_180
                UBFM            W8, W19, #0x1F, #0x1E
                ORR             X21, X9, #1
                STRB            W8, [SP,#0x1E0+var_180]
                CBNZ            X19, loc_278F30
                B               loc_278F40
// ---------------------------------------------------------------------------

loc_278F10:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+74C
                ADD             X8, X19, #0x10
                AND             X22, X8, #0xFFFFFFFFFFFFFFF0
//   try {
                ORR             X0, XZR, X22 // unsigned __int64
                BL	_Znwm  // operator new(ulong)
//   } // starts at 278F18
                ORR             X8, X22, #1
                ORR             X21, XZR, X0
                STP             X8, X19, [SP,#0x1E0+var_180]
                STR             X0, [SP,#0x1E0+var_170]

loc_278F30:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+760
                ORR             X0, XZR, X21 // dest
                ORR             X1, XZR, X20 // src
                ORR             X2, XZR, X19 // n
                BL	memcpy

loc_278F40:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+764
                LDUR            X0, [X29,#var_D0] // ptr
                STRB            WZR, [X21,X19]
                BL	_ZdlPv // operator delete(void *)

loc_278F4C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+734
//   try {
                ADRP            X0, :pg_hi21:_ZN11CApiLicense12LICENSE_PATHE_ptr
                LDR             X0, [X0,#:lo12:_ZN11CApiLicense12LICENSE_PATHE_ptr] // int
		ADRP	X1, :pg_hi21:(aRkeyData+1) // s
		ADD	X1, X1, #:lo12:(aRkeyData+1) // s
                SUB             X8, X29, #-var_E0
                BL              sub_25874C
//   } // starts at 278F4C
                LDURB           W8, [X29,#var_E0]
                STP             XZR, XZR, [SP,#0x1E0+var_1A0+8]
                STR             XZR, [SP,#0x1E0+var_1A0]
                TBNZ            W8, #0, loc_278F88
                LDUR            Q0, [X29,#var_E0]
                LDUR            X8, [X29,#var_D0]
                STR             Q0, [SP,#0x1E0+var_1A0]
                STR             X8, [SP,#0x1E0+var_190]
                B               loc_278FF4
// ---------------------------------------------------------------------------

loc_278F88:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+7C8
                LDUR            X19, [X29,#var_E0+8]
                ADDS            XZR, X19, #0x10
                B.cs            loc_279250
                LDUR            X20, [X29,#var_D0]
                SUBS            XZR, X19, #0x17
                B.cs            loc_278FB8
                ADD             X9, SP, #0x1E0+var_1A0
                UBFM            W8, W19, #0x1F, #0x1E
                ORR             X21, X9, #1
                STRB            W8, [SP,#0x1E0+var_1A0]
                CBNZ            X19, loc_278FD8
                B               loc_278FE8
// ---------------------------------------------------------------------------

loc_278FB8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+7F4
                ADD             X8, X19, #0x10
                AND             X22, X8, #0xFFFFFFFFFFFFFFF0
//   try {
                ORR             X0, XZR, X22 // unsigned __int64
                BL	_Znwm  // operator new(ulong)
//   } // starts at 278FC0
                ORR             X8, X22, #1
                ORR             X21, XZR, X0
                STP             X8, X19, [SP,#0x1E0+var_1A0]
                STR             X0, [SP,#0x1E0+var_190]

loc_278FD8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+808
                ORR             X0, XZR, X21 // dest
                ORR             X1, XZR, X20 // src
                ORR             X2, XZR, X19 // n
                BL	memcpy

loc_278FE8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+80C
                LDUR            X0, [X29,#var_D0] // ptr
                STRB            WZR, [X21,X19]
                BL	_ZdlPv // operator delete(void *)

loc_278FF4:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+7DC
                LDR             W8, [SP,#0x1E0+var_130]
                LDR             W9, [SP,#0x1E0+var_138]
                SUB             W1, W8, W9 // unsigned __int64
//   try {
                ADD             X8, SP, #0x1E0+var_1B8
                BL	_ZN11CApiLicense18generate_somethingEm // CApiLicense::generate_something(ulong)
//   } // starts at 279000
                LDP             X20, X8, [SP,#0x1E0+var_138]
                SUB             X22, X8, X20
                AND             X21, X22, #0xFFFFFFFF
                ORR             X0, XZR, X21 // size
                BL	malloc
                ORR             W1, WZR, WZR // c
                ORR             X2, XZR, X21 // n
                ORR             X19, XZR, X0
                BL	memset
                ORR             X0, XZR, X19 // dest
                ORR             X1, XZR, X20 // src
                ORR             X2, XZR, X21 // n
                BL	memcpy
//   try {
                ADD             X0, SP, #0x1E0+var_1D0
                ADD             X1, SP, #0x1E0+var_1B8
                BL	_ZNSt6__ndk16vectorIcNS_9allocatorIcEEEC2ERKS3_ // std::vector<char>::vector(std::vector<char> const&)
//   } // starts at 27903C
                CBZ             W22, loc_27908C
                LDR             W9, [SP,#0x1E0+var_1B0]
                LDR             W10, [SP,#0x1E0+var_1B8]
                LDR             X0, [SP,#0x1E0+var_1D0]
                ORR             X8, XZR, XZR
                SUB             W9, W9, W10
                AND             X10, X22, #0xFFFFFFFF

loc_279064:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+8DC
                UDIV            W11, W8, W9
                MSUB            W11, W11, W9, W8
                LDRB            W12, [X19,X8]
                LDRB            W11, [X0,W11,UXTW]
                EOR             W11, W12, W11
                STRB            W11, [X19,X8]
                ADD             X8, X8, #1
                SUBS            XZR, X10, X8
                B.ne            loc_279064
                B               loc_279094
// ---------------------------------------------------------------------------

loc_27908C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+8A0
                LDR             X0, [SP,#0x1E0+var_1D0] // ptr
                CBZ             X0, loc_27909C

loc_279094:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+8E0
                STR             X0, [SP,#0x1E0+var_1C8]
                BL	_ZdlPv // operator delete(void *)

loc_27909C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+8E8
//   try {                               // this
                SUB             X0, X29, #-var_E0
                ADD             X1, SP, #0x1E0+var_180 // RString *
                BL	_ZN5RFileC2ERK7RString // RFile::RFile(RString const&)
//   } // starts at 27909C
                LDR             W8, [SP,#0x1E0+var_130]
                LDR             W9, [SP,#0x1E0+var_138]
                SUBS            WZR, W8, W9
                B.eq            loc_279168
                LDRB            W8, [SP,#0x1E0+var_1A0]
                LDR             X9, [SP,#0x1E0+var_190]
                ADD             X10, SP, #0x1E0+var_1A0
                ORR             X10, X10, #1
                ANDS            WZR, W8, #1
                CSEL            X0, X10, X9, eq // filename
                BL	remove
                LDURB           W8, [X29,#var_E0]
                LDUR            X9, [X29,#var_E0+8]
                UBFM            X10, X8, #1, #0x3F // '?'
                ANDS            WZR, W8, #1
                CSEL            X8, X10, X9, eq
                CBZ             X8, loc_279168
//   try {
                ORR             W0, WZR, WZR
                BL	__umask_chk
                LDURB           W8, [X29,#var_E0]
                LDUR            X9, [X29,#var_D0]
                SUB             X10, X29, #-var_E0
                ORR             X10, X10, #1
                ANDS            WZR, W8, #1
                CSEL            X0, X10, X9, eq // file
                MOVZ            W1, #0x42 // 'B' // oflag
                MOVZ            W2, #0x1B6
                BL	open
                ADDS            WZR, W0, #1
                STUR            W0, [X29,#var_C0]
                B.eq            loc_279168
                LDR             W8, [SP,#0x1E0+var_130]
                LDR             W9, [SP,#0x1E0+var_138]
                MOVZ            W10, #1
                STURB           W10, [X29,#var_C4]
                SUB             W2, W8, W9
                MOVN            X3, #0
                ORR             X1, XZR, X19
                BL	__write_chk
                LDUR            W0, [X29,#var_C0] // fd
                BL	fsync
                LDUR            W0, [X29,#var_C0] // fd
                ADDS            WZR, W0, #1
                B.eq            loc_279164
                BL	close
//   } // starts at 2790EC
                MOVN            W8, #0
                STUR            W8, [X29,#var_C0]

loc_279164:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+9AC
                STURB           WZR, [X29,#var_C4]

loc_279168:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+90C
                                        // CApiLicense::getLicenseKey(RString &,RString &)+940
                ORR             X0, XZR, X19 // ptr
                BL	free
                LDURB           W8, [X29,#var_E0]
                TBZ             W8, #0, loc_279180
                LDUR            X0, [X29,#var_D0] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_279180:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+9CC
                LDR             X0, [SP,#0x1E0+var_1B8] // ptr
                CBZ             X0, loc_279190
                STR             X0, [SP,#0x1E0+var_1B0]
                BL	_ZdlPv // operator delete(void *)

loc_279190:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+9DC
                LDRB            W8, [SP,#0x1E0+var_1A0]
                TBZ             W8, #0, loc_2791A0
                LDR             X0, [SP,#0x1E0+var_190] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_2791A0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+9EC
                LDRB            W8, [SP,#0x1E0+var_180]
                TBZ             W8, #0, loc_2791B0
                LDR             X0, [SP,#0x1E0+var_170] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_2791B0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+2E0
                                        // CApiLicense::getLicenseKey(RString &,RString &)+308
                LDRB            W8, [SP,#0x1E0+n]
                TBNZ            W8, #0, loc_279210
                LDRB            W8, [SP,#0x1E0+var_150]
                TBNZ            W8, #0, loc_279220

loc_2791C0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+A74
                LDR             X0, [SP,#0x1E0+var_138] // ptr
                CBZ             X0, loc_2791D0

loc_2791C8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+A84
                STR             X0, [SP,#0x1E0+var_130]
                BL	_ZdlPv // operator delete(void *)

loc_2791D0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+A1C
                                        // CApiLicense::getLicenseKey(RString &,RString &)+A88
                LDR             X0, [SP,#0x1E0+var_120] // ptr
                CBZ             X0, loc_2791E0
                STR             X0, [SP,#0x1E0+var_118]
                BL	_ZdlPv // operator delete(void *)

loc_2791E0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+A2C
                LDR             X8, [X26,#0x28]
                LDUR            X9, [X29,#var_60]
                SUBS            XZR, X8, X9
                B.ne            loc_279234
                LDP             X29, X30, [SP,#0x1E0+var_s0]
                LDP             X20, X19, [SP,#0x1E0+var_10]
                LDP             X22, X21, [SP,#0x1E0+var_20]
                LDP             X24, X23, [SP,#0x1E0+var_30]
                LDP             X26, X25, [SP,#0x1E0+var_40]
                LDP             X28, X27, [SP,#0x1E0+var_50]
                ADD             SP, SP, #0x1F0
                RET
// ---------------------------------------------------------------------------

loc_279210:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+A0C
                LDR             X0, [SP,#0x1E0+src] // ptr
                BL	_ZdlPv // operator delete(void *)
                LDRB            W8, [SP,#0x1E0+var_150]
                TBZ             W8, #0, loc_2791C0

loc_279220:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+A14
                LDR             X0, [SP,#0x1E0+var_140] // ptr
                BL	_ZdlPv // operator delete(void *)
                LDR             X0, [SP,#0x1E0+var_138]
                CBNZ            X0, loc_2791C8
                B               loc_2791D0
// ---------------------------------------------------------------------------

loc_279234:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+A44
                BL	__stack_chk_fail
// ---------------------------------------------------------------------------

loc_279238:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+144
//   try {
                ADD             X0, SP, #0x1E0+var_150
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv // std::__basic_string_common<true>::__throw_length_error(void)
//   } // starts at 279238
// ---------------------------------------------------------------------------

loc_279240:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+218
//   try {
                SUB             X0, X29, #-var_E0
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv // std::__basic_string_common<true>::__throw_length_error(void)
//   } // starts at 279240
// ---------------------------------------------------------------------------

loc_279248:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+740
//   try {
                ADD             X0, SP, #0x1E0+var_180
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv // std::__basic_string_common<true>::__throw_length_error(void)
//   } // starts at 279248
// ---------------------------------------------------------------------------

loc_279250:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+7E8
//   try {
                ADD             X0, SP, #0x1E0+var_1A0
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv // std::__basic_string_common<true>::__throw_length_error(void)
//   } // starts at 279250
// ---------------------------------------------------------------------------

loc_279258:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+5C4
//   try {
                SUB             X0, X29, #-var_E0
                BL	_ZNKSt6__ndk120__vector_base_commonILb1EE20__throw_out_of_rangeEv // std::__vector_base_common<true>::__throw_out_of_range(void)
//   } // starts at 279258
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278DA8
                B               loc_279264
// ---------------------------------------------------------------------------

loc_279264:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+AB8
//   cleanup() // owned by 278D38
                LDRB            W8, [SP,#0x1E0+var_180]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_2792C0
                LDR             X0, [SP,#0x1E0+var_170] // ptr
                BL	_ZdlPv // operator delete(void *)
                LDUR            X20, [X29,#var_E0]
                CBNZ            X20, loc_2792C8
                B               loc_279414
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278D74
//   cleanup() // owned by 279258
                B               loc_2792BC
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278D04
                B               loc_2792BC
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278C88
                B               loc_279410
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278CC4
                LDRB            W8, [SP,#0x1E0+var_1A0]
                ORR             X19, XZR, X0
                TBNZ            W8, #0, loc_2793A8
                B               loc_2793B0
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278CB4
                B               loc_279340
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278FC0
//   cleanup() // owned by 279250
                LDURB           W8, [X29,#var_E0]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_2793B0
                LDUR            X0, [X29,#var_D0]
                B               loc_2793AC
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278F18
//   cleanup() // owned by 279248
                B               loc_2793C8
// ---------------------------------------------------------------------------

loc_2792BC:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+ADC
                                        // CApiLicense::getLicenseKey(RString &,RString &)+AE0
//   cleanup() // owned by 278DC0
                ORR             X19, XZR, X0

loc_2792C0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+AC4
                LDUR            X20, [X29,#var_E0]
                CBZ             X20, loc_279414

loc_2792C8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+AD4
                LDUR            X8, [X29,#var_E0+8]
                SUBS            XZR, X8, X20
                B.eq            loc_27930C
                ORR             X21, XZR, X8
                LDRB            W9, [X21,#-0x18]!
                TBNZ            W9, #0, loc_2792F4

loc_2792E0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B48
                                        // CApiLicense::getLicenseKey(RString &,RString &)+B54
                SUBS            XZR, X20, X21
                ORR             X8, XZR, X21
                B.eq            loc_279300
                LDRB            W9, [X21,#-0x18]!
                TBZ             W9, #0, loc_2792E0

loc_2792F4:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B34
                LDUR            X0, [X8,#-8] // ptr
                BL	_ZdlPv // operator delete(void *)
                B               loc_2792E0
// ---------------------------------------------------------------------------

loc_279300:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B40
                LDUR            X0, [X29,#var_E0]

loc_279304:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B68
                STUR            X20, [X29,#var_E0+8]
                B               loc_2793D8
// ---------------------------------------------------------------------------

loc_27930C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B28
                ORR             X0, XZR, X20
                B               loc_279304
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278B70
                B               loc_27935C
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278B64
                B               loc_279410
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27909C
                B               loc_279320
// ---------------------------------------------------------------------------

loc_279320:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B74
//   cleanup() // owned by 27903C
                ORR             X19, XZR, X0
                LDR             X0, [SP,#0x1E0+var_1B8]
                CBNZ            X0, loc_279398
                B               loc_2793A0
// ---------------------------------------------------------------------------
//   cleanup() // owned by 279000
                ORR             X19, XZR, X0
                LDRB            W8, [SP,#0x1E0+var_1A0]
                TBZ             W8, #0, loc_2793B0
                B               loc_2793A8
// ---------------------------------------------------------------------------

loc_279340:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+AF8
//   cleanup() // owned by 278F4C
                ORR             X19, XZR, X0
                LDRB            W8, [SP,#0x1E0+var_180]
                TBNZ            W8, #0, loc_2793B8
                B               loc_279414
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278EA4
                B               loc_279410
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278C0C
                B               loc_27935C
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278BF8
                B               loc_279410
// ---------------------------------------------------------------------------

loc_27935C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B6C
                                        // CApiLicense::getLicenseKey(RString &,RString &)+BAC
//   cleanup() // owned by 278BE0
                LDUR            X8, [X29,#var_E0]
                ORR             X19, XZR, X0
                CBZ             X8, loc_279414
                ORR             X0, XZR, X8
                STUR            X8, [X29,#var_E0+8]
                B               loc_2793D8
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278BCC
                B               loc_279410
// ---------------------------------------------------------------------------
//   cleanup() // owned by 2789F0
//   cleanup() // owned by 279240
                B               loc_279410
// ---------------------------------------------------------------------------
//   cleanup() // owned by 2790EC
                LDURB           W8, [X29,#var_E0]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_279390
                LDUR            X0, [X29,#var_D0] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_279390:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+BDC
                LDR             X0, [SP,#0x1E0+var_1B8] // ptr
                CBZ             X0, loc_2793A0

loc_279398:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B80
                STR             X0, [SP,#0x1E0+var_1B0]
                BL	_ZdlPv // operator delete(void *)

loc_2793A0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B84
                                        // CApiLicense::getLicenseKey(RString &,RString &)+BEC
                LDRB            W8, [SP,#0x1E0+var_1A0]
                TBZ             W8, #0, loc_2793B0

loc_2793A8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+AF0
                                        // CApiLicense::getLicenseKey(RString &,RString &)+B94
                LDR             X0, [SP,#0x1E0+var_190] // ptr

loc_2793AC:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B0C
                BL	_ZdlPv // operator delete(void *)

loc_2793B0:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+AF4
                                        // CApiLicense::getLicenseKey(RString &,RString &)+B04
                LDRB            W8, [SP,#0x1E0+var_180]
                TBZ             W8, #0, loc_279414

loc_2793B8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+BA0
                LDR             X0, [SP,#0x1E0+var_170]
                B               loc_2793D8
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27891C
//   cleanup() // owned by 279238
                B               loc_2793FC
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278B30
//   cleanup() // owned by 278C34
                B               loc_279410
// ---------------------------------------------------------------------------

loc_2793C8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B10
//   cleanup() // owned by 278A3C
                LDURB           W8, [X29,#var_E0]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_279414
                LDUR            X0, [X29,#var_D0] // ptr

loc_2793D8:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+B60
                                        // CApiLicense::getLicenseKey(RString &,RString &)+BC8
                BL	_ZdlPv // operator delete(void *)
                LDRB            W8, [SP,#0x1E0+n]
                TBNZ            W8, #0, loc_27941C
                B               loc_279434
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278974
                ORR             X19, XZR, X0
                LDRB            W8, [SP,#0x1E0+var_150]
                TBNZ            W8, #0, loc_27943C
                B               loc_27948C
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278890
                B               loc_2793FC
// ---------------------------------------------------------------------------

loc_2793FC:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+C18
                                        // CApiLicense::getLicenseKey(RString &,RString &)+C50
//   cleanup() // owned by 27883C
                LDURB           W8, [X29,#var_E0]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_27948C
                LDUR            X0, [X29,#var_D0]
                B               loc_279440
// ---------------------------------------------------------------------------

loc_279410:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+AE4
                                        // CApiLicense::getLicenseKey(RString &,RString &)+B70
//   cleanup() // owned by 278AA0
//   cleanup() // owned by 278E5C
                ORR             X19, XZR, X0

loc_279414:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+AD8
                                        // CApiLicense::getLicenseKey(RString &,RString &)+B1C
                LDRB            W8, [SP,#0x1E0+n]
                TBZ             W8, #0, loc_279434

loc_27941C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+C38
                LDR             X0, [SP,#0x1E0+src] // ptr
                BL	_ZdlPv // operator delete(void *)
                LDRB            W8, [SP,#0x1E0+var_150]
                TBNZ            W8, #0, loc_27943C
                B               loc_27948C
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278A68
                ORR             X19, XZR, X0

loc_279434:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+C3C
                                        // CApiLicense::getLicenseKey(RString &,RString &)+C70
                LDRB            W8, [SP,#0x1E0+var_150]
                TBZ             W8, #0, loc_27948C

loc_27943C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+C48
                                        // CApiLicense::getLicenseKey(RString &,RString &)+C80
                LDR             X0, [SP,#0x1E0+var_140] // ptr

loc_279440:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+C64
                BL	_ZdlPv // operator delete(void *)
                LDR             X0, [SP,#0x1E0+var_138]
                CBZ             X0, loc_279494
                B               loc_279468
// ---------------------------------------------------------------------------
//   cleanup() // owned by 2788A8
                B               loc_27945C
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278854
                B               loc_27945C
// ---------------------------------------------------------------------------
//   cleanup() // owned by 278800
                B               loc_27945C
// ---------------------------------------------------------------------------

loc_27945C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+CA8
                                        // CApiLicense::getLicenseKey(RString &,RString &)+CAC
//   cleanup() // owned by 2787F8
                ORR             X19, XZR, X0
                LDR             X0, [SP,#0x1E0+var_138] // ptr
                CBZ             X0, loc_279494

loc_279468:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+CA4
                                        // CApiLicense::getLicenseKey(RString &,RString &)+CE8
                STR             X0, [SP,#0x1E0+var_130]
                BL	_ZdlPv // operator delete(void *)
                LDR             X0, [SP,#0x1E0+var_120] // ptr
                CBZ             X0, loc_27949C

loc_279478:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+CF0
                STR             X0, [SP,#0x1E0+var_118]
                BL	_ZdlPv // operator delete(void *)
                ORR             X0, XZR, X19
                BL              sub_A1036C
//   cleanup() // owned by 2787EC
                ORR             X19, XZR, X0

loc_27948C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+C4C
                                        // CApiLicense::getLicenseKey(RString &,RString &)+C5C
                LDR             X0, [SP,#0x1E0+var_138]
                CBNZ            X0, loc_279468

loc_279494:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+CA0
                                        // CApiLicense::getLicenseKey(RString &,RString &)+CBC
                LDR             X0, [SP,#0x1E0+var_120]
                CBNZ            X0, loc_279478

loc_27949C:                             // CODE XREF: CApiLicense::getLicenseKey(RString &,RString &)+CCC
                ORR             X0, XZR, X19
                BL              sub_A1036C
// } // starts at 2787A8
// End of function CApiLicense::getLicenseKey(RString &,RString &)


// __int64 __fastcall CApiLicense::verifyOption(CApiLicense *__hidden this, COptInfo *, RString *, RString *)
                .globl _ZN11CApiLicense12verifyOptionEP8COptInfoR7RStringS3_
_ZN11CApiLicense12verifyOptionEP8COptInfoR7RStringS3_:
                                        // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+C
                                        // DATA XREF: LOAD:000000000003B578

var_D8          = -0xD8
var_D0          = -0xD0
var_C8          = -0xC8
var_C0          = -0xC0
var_B8          = -0xB8
var_A8          = -0xA8
var_98          = -0x98
var_90          = -0x90
var_88          = -0x88
ptr             = -0x80
size            = -0x74
var_68          = -0x68
var_60          = -0x60
var_58          = -0x58
var_50          = -0x50
var_40          = -0x40
var_30          = -0x30
var_20          = -0x20
var_10          = -0x10
var_s0          =  0

// __unwind { // __gxx_personality_v0
                SUB             SP, SP, #0xF0
                STP             X28, X27, [SP,#0xE0+var_50]
                STP             X26, X25, [SP,#0xE0+var_40]
                STP             X24, X23, [SP,#0xE0+var_30]
                STP             X22, X21, [SP,#0xE0+var_20]
                STP             X20, X19, [SP,#0xE0+var_10]
                STP             X29, X30, [SP,#0xE0+var_s0]
                ADD             X29, SP, #0xE0
                MRS             X28, TPIDR_EL0
                LDR             X8, [X28,#0x28]
                ORR             X23, XZR, X0
                ORR             X0, XZR, X1 // this
                ORR             X22, XZR, X2
                STUR            X8, [X29,#var_58]
                ADD             X8, SP, #0xE0+size+4
                ORR             X19, XZR, X1
                BL	_ZN8COptInfo10getLicenseEv // COptInfo::getLicense(void)
                LDRB            W8, [SP,#0xE0+size+4]
                LDR             X9, [SP,#0xE0+var_68]
                UBFM            X10, X8, #1, #0x3F // '?'
                ANDS            WZR, W8, #1
                CSEL            X9, X10, X9, eq
                UBFM            X10, X9, #1, #0x3F // '?'
                SUBS            WZR, W10, #0x38 // '8'
                STR             W10, [SP,#0xE0+size]
                B.ne            loc_279F3C
                MOVZ            W8, #0x30 // '0'
                SUB             W1, W9, #0x10 // int
                STR             W8, [SP,#0xE0+size]
//   try {
                ADD             X8, SP, #0xE0+var_90
                ADD             X0, SP, #0xE0+size+4 // this
                MOVZ            W2, #0x10 // int
                ADD             X20, SP, #0xE0+var_90
                BL	_ZN7RString6removeEii // RString::remove(int,int)
//   } // starts at 279E88
                LDRB            W8, [SP,#0xE0+var_90]
                LDP             X10, X9, [SP,#0xE0+var_88]
                ORR             X11, X20, #1
                ANDS            WZR, W8, #1
                UBFM            X12, X8, #1, #0x3F // '?'
                CSEL            X1, X11, X9, eq // src
                CSEL            X2, X12, X10, eq // n
//   try {
                ADD             X0, SP, #0xE0+size+4 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm // std::string::assign(char const*,ulong)
//   } // starts at 279EB8
                LDRB            W8, [SP,#0xE0+var_90]
                TBZ             W8, #0, loc_279ED0
                LDR             X0, [SP,#0xE0+ptr] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_279ED0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+B0
                LDRSW           X21, [SP,#0xE0+size]
                ORR             X0, XZR, X21 // size
                BL	malloc
                ORR             W1, WZR, WZR // c
                ORR             X2, XZR, X21 // n
                ORR             X20, XZR, X0
                BL	memset
                LDRB            W25, [SP,#0xE0+size+4]
                LDR             X26, [SP,#0xE0+var_68]
                UBFM            X24, X25, #1, #0x3F // '?'
                ANDS            WZR, W25, #1
                CSEL            X0, X24, X26, eq // size
                BL	malloc
                ORR             X21, XZR, X0
                STP             XZR, XZR, [SP,#0xE0+var_A8]
                STR             XZR, [SP,#0xE0+var_98]
                TBNZ            W25, #0, loc_279F84
                ADD             X8, SP, #0xE0+size+4
                ORR             X25, X8, #1
                SUBS            XZR, X24, #0x17
                B.cs            loc_279F9C

loc_279F24:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+184
                ADD             X9, SP, #0xE0+var_A8
                UBFM            W8, W24, #0x1F, #0x1E
                ORR             X26, X9, #1
                STRB            W8, [SP,#0xE0+var_A8]
                CBNZ            X24, loc_279FBC
                B               loc_279FCC
// ---------------------------------------------------------------------------

loc_279F3C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+64
                ORR             W22, WZR, WZR
                AND             W8, W8, #1
                CBZ             W8, loc_279F50

loc_279F48:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+4B4
                LDR             X0, [SP,#0xE0+var_60] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_279F50:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+130
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+4B8
                LDR             X8, [X28,#0x28]
                LDUR            X9, [X29,#var_58]
                SUBS            XZR, X8, X9
                B.ne            loc_27A2F8
                ORR             W0, WZR, W22
                LDP             X29, X30, [SP,#0xE0+var_s0]
                LDP             X20, X19, [SP,#0xE0+var_10]
                LDP             X22, X21, [SP,#0xE0+var_20]
                LDP             X24, X23, [SP,#0xE0+var_30]
                LDP             X26, X25, [SP,#0xE0+var_40]
                LDP             X28, X27, [SP,#0xE0+var_50]
                ADD             SP, SP, #0xF0
                RET
// ---------------------------------------------------------------------------

loc_279F84:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+FC
                ADDS            XZR, X26, #0x10
                B.cs            loc_27A2FC
                LDR             X25, [SP,#0xE0+var_60]
                ORR             X24, XZR, X26
                SUBS            XZR, X24, #0x17
                B.cc            loc_279F24

loc_279F9C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+10C
                ADD             X8, X24, #0x10
                AND             X27, X8, #0xFFFFFFFFFFFFFFF0
//   try {
                ORR             X0, XZR, X27 // unsigned __int64
                BL	_Znwm  // operator new(ulong)
//   } // starts at 279FA4
                ORR             X8, X27, #1
                ORR             X26, XZR, X0
                STP             X8, X24, [SP,#0xE0+var_A8]
                STR             X0, [SP,#0xE0+var_98]

loc_279FBC:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+120
                ORR             X0, XZR, X26 // dest
                ORR             X1, XZR, X25 // src
                ORR             X2, XZR, X24 // n
                BL	memcpy

loc_279FCC:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+124
                STRB            WZR, [X26,X24]
//   try {
                ADD             X0, SP, #0xE0+var_A8
                ADD             X2, SP, #0xE0+size
                ORR             X1, XZR, X21
                BL	_Z14API_SetStr2Hex7RStringPcRi // API_SetStr2Hex(RString,char *,int &)
//   } // starts at 279FD0
                LDRB            W8, [SP,#0xE0+var_A8]
                TBZ             W8, #0, loc_279FF0
                LDR             X0, [SP,#0xE0+var_98] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_279FF0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+1D0
                LDRB            W8, [X22]
                LDR             X9, [X22,#0x10]
                ANDS            WZR, W8, #1
                CSINC           X0, X9, X22, ne
                ADD             X22, X23, #0xA8
//   try {
                MOVZ            W1, #0x100
                ORR             X2, XZR, X22
                BL	AES_set_decrypt_key
//   } // starts at 27A004
                LDR             W8, [SP,#0xE0+size]
                SUBS            WZR, W8, #1
                B.lt            loc_27A040
                ORR             X23, XZR, XZR

loc_27A020:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+228
                ADD             X0, X21, X23
                ADD             X1, X20, X23
//   try {
                ORR             X2, XZR, X22
                BL	AES_decrypt
//   } // starts at 27A028
                LDR             W8, [SP,#0xE0+size]
                ADD             X23, X23, #0x10
                SUBS            WZR, W8, W23
                B.gt            loc_27A020

loc_27A040:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+204
//   try {                               // this
                ORR             X0, XZR, X19
                ORR             W1, WZR, WZR // bool
                BL	_ZN8COptInfo15setLicenseValidEb // COptInfo::setLicenseValid(bool)
                ORR             X0, XZR, X19 // this
                ORR             W1, WZR, WZR // bool
                BL	_ZN8COptInfo12setBndEnableEb // COptInfo::setBndEnable(bool)
//   } // starts at 27A040
//   try {
                ADD             X0, SP, #0xE0+var_90 // int
                ORR             X1, XZR, X20 // s
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc // std::string::basic_string<decltype(nullptr)>(char const*)
//   } // starts at 27A058
//   try {
		ADRP	X1, :pg_hi21:asc_A25ADA // "#"
		ADD	X1, X1, #:lo12:asc_A25ADA // "#"
                ADD             X0, SP, #0xE0+var_D8 // int
                BL	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc // std::string::basic_string<decltype(nullptr)>(char const*)
//   } // starts at 27A064
//   try {
                ADD             X8, SP, #0xE0+var_C0
                ADD             X0, SP, #0xE0+var_90 // this
                ADD             X1, SP, #0xE0+var_D8 // RString *
                BL	_ZN7RString5splitERKS_ // RString::split(RString const&)
//   } // starts at 27A074
                LDRB            W8, [SP,#0xE0+var_D8]
                TBZ             W8, #0, loc_27A094
                LDR             X0, [SP,#0xE0+var_C8] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_27A094:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+274
                LDP             X8, X9, [SP,#0xE0+var_C0]
                SUB             X9, X9, X8
                SUBS            XZR, X9, #0x90
                B.ne            loc_27A0BC
                ORR             X0, XZR, X8
                LDRB            W9, [X0,#0x60]!
                TBNZ            W9, #0, loc_27A0DC
                UBFM            X10, X9, #1, #0x3F // '?'
                CBNZ            X10, loc_27A0E4

loc_27A0B8:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+2CC
//   try {
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_out_of_rangeEv // std::__basic_string_common<true>::__throw_out_of_range(void)
// ---------------------------------------------------------------------------

loc_27A0BC:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+28C
                ORR             X0, XZR, X19
                ORR             W1, WZR, WZR
                BL	_ZN8COptInfo14setLicenseTypeE11LicenseType // COptInfo::setLicenseType(LicenseType)
                ORR             X0, XZR, X19
                ORR             W1, WZR, WZR
                BL	_ZN8COptInfo14setLicenseTimeE11LicenseTime // COptInfo::setLicenseTime(LicenseTime)
                ORR             W22, WZR, WZR
                B               loc_27A24C
// ---------------------------------------------------------------------------

loc_27A0DC:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+298
                LDR             X10, [X8,#0x68]
                CBZ             X10, loc_27A0B8

loc_27A0E4:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+2A0
                TBNZ            W9, #0, loc_27A0F0
                ADD             X8, X0, #1
                B               loc_27A0F4
// ---------------------------------------------------------------------------

loc_27A0F0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &):loc_27A0E4
                LDR             X8, [X8,#0x70]

loc_27A0F4:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+2D8
                LDRB            W8, [X8]
                SUB             W1, W8, #0x30 // '0'
                ORR             X0, XZR, X19
                BL	_ZN8COptInfo14setLicenseTypeE11LicenseType // COptInfo::setLicenseType(LicenseType)
                LDP             X8, X9, [SP,#0xE0+var_C0]
                ORR             X10, XZR, #0xAAAAAAAAAAAAAAAA
                .byte 0x6A // j
                .byte 0x55 // U
                .byte 0x95
                .byte 0xF2
                SUB             X9, X9, X8
                SBFM            X9, X9, #3, #0x3F // '?'
                MADD            X9, X9, X10, XZR
                SUBS            XZR, X9, #5
                B.ls            loc_27A304
                ORR             X0, XZR, X8
                LDRB            W9, [X0,#0x78]!
                TBNZ            W9, #0, loc_27A13C
                UBFM            X10, X9, #1, #0x3F // '?'
                CBNZ            X10, loc_27A144

loc_27A138:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+32C
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_out_of_rangeEv // std::__basic_string_common<true>::__throw_out_of_range(void)
// ---------------------------------------------------------------------------

loc_27A13C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+318
                LDR             X10, [X8,#0x80]
                CBZ             X10, loc_27A138

loc_27A144:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+320
                TBNZ            W9, #0, loc_27A150
                ADD             X8, X0, #1
                B               loc_27A154
// ---------------------------------------------------------------------------

loc_27A150:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &):loc_27A144
                LDR             X8, [X8,#0x88]

loc_27A154:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+338
                LDRB            W8, [X8]
                SUB             W1, W8, #0x30 // '0'
                ORR             X0, XZR, X19
                BL	_ZN8COptInfo14setLicenseTimeE11LicenseTime // COptInfo::setLicenseTime(LicenseTime)
//   } // starts at 27A0B8
//   try {
                ORR             X0, XZR, X19 // this
                BL	_ZN8COptInfo7getTypeEv // COptInfo::getType(void)
                ADD             X8, SP, #0xE0+var_D8
                ORR             W1, WZR, W0
                BL	_ZN11CApiLicense17getStringFromEnumE7OptType // CApiLicense::getStringFromEnum(OptType)
//   } // starts at 27A164
                LDP             X9, X8, [SP,#0xE0+var_C0]
                ORR             X10, XZR, #0xAAAAAAAAAAAAAAAA
                .byte 0x6A // j
                .byte 0x55 // U
                .byte 0x95
                .byte 0xF2
                SUB             X8, X8, X9
                SBFM            X8, X8, #3, #0x3F // '?'
                MADD            X8, X8, X10, XZR
                SUBS            XZR, X8, #2
                B.ls            loc_27A30C
                ORR             X8, XZR, X9
                LDRB            W10, [X8,#0x30]!
                LDRB            W12, [SP,#0xE0+var_D8]
                LDP             X14, X13, [SP,#0xE0+var_D0]
                ADD             X11, SP, #0xE0+var_D8
                ORR             X11, X11, #1
                UBFM            X15, X12, #1, #0x3F // '?'
                ANDS            WZR, W12, #1
                CSEL            X22, X11, X13, eq
                CSEL            X23, X15, X14, eq
                TBNZ            W10, #0, loc_27A224
                ADD             X26, X8, #1
                UBFM            X8, X10, #1, #0x3F // '?'
                CBZ             X23, loc_27A22C

loc_27A1D0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+414
                SUBS            XZR, X8, X23
                B.lt            loc_27A2E4
                LDRB            W24, [X22]
                ADD             X27, X26, X8
                ORR             X0, XZR, X26 // s

loc_27A1E4:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+408
                SUB             X8, X8, X23
                ADDS            X2, X8, #1 // n
                B.cs            loc_27A2E4
                ORR             W1, WZR, W24 // c
                BL	memchr
                CBZ             X0, loc_27A2E4
                ORR             X1, XZR, X22 // s2
                ORR             X2, XZR, X23 // n
                ORR             X25, XZR, X0
                BL	memcmp
                CBZ             W0, loc_27A2D0
                ADD             X0, X25, #1
                SUB             X8, X27, X0
                SUBS            XZR, X8, X23
                B.ge            loc_27A1E4
                B               loc_27A2E4
// ---------------------------------------------------------------------------

loc_27A224:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+3AC
                LDP             X8, X26, [X9,#0x38]
                CBNZ            X23, loc_27A1D0

loc_27A22C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+3B8
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+4CC
                MOVZ            W22, #1
//   try {
                MOVZ            W1, #1  // bool
                ORR             X0, XZR, X19 // this
                BL	_ZN8COptInfo15setLicenseValidEb // COptInfo::setLicenseValid(bool)

loc_27A23C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+4E0
                LDRB            W8, [SP,#0xE0+var_D8]
                TBZ             W8, #0, loc_27A24C
                LDR             X0, [SP,#0xE0+var_C8] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_27A24C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+2C4
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+42C
                ORR             X0, XZR, X20 // ptr
                BL	free
                ORR             X0, XZR, X21 // ptr
                BL	free
                LDR             X19, [SP,#0xE0+var_C0]
                CBZ             X19, loc_27A2B0
                LDR             X8, [SP,#0xE0+var_B8]
                SUBS            XZR, X8, X19
                B.eq            loc_27A2A4
                ORR             X20, XZR, X8
                LDRB            W9, [X20,#-0x18]!
                TBNZ            W9, #0, loc_27A290

loc_27A27C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+478
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+484
                SUBS            XZR, X19, X20
                ORR             X8, XZR, X20
                B.eq            loc_27A29C
                LDRB            W9, [X20,#-0x18]!
                TBZ             W9, #0, loc_27A27C

loc_27A290:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+464
                LDUR            X0, [X8,#-8] // ptr
                BL	_ZdlPv // operator delete(void *)
                B               loc_27A27C
// ---------------------------------------------------------------------------

loc_27A29C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+470
                LDR             X0, [SP,#0xE0+var_C0]
                B               loc_27A2A8
// ---------------------------------------------------------------------------

loc_27A2A4:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+458
                ORR             X0, XZR, X19 // ptr

loc_27A2A8:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+48C
                STR             X19, [SP,#0xE0+var_B8]
                BL	_ZdlPv // operator delete(void *)

loc_27A2B0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+44C
                LDRB            W8, [SP,#0xE0+var_90]
                TBZ             W8, #0, loc_27A2C0
                LDR             X0, [SP,#0xE0+ptr] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_27A2C0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+4A0
                LDRB            W8, [SP,#0xE0+size+4]
                AND             W8, W8, #1
                CBNZ            W8, loc_279F48
                B               loc_279F50
// ---------------------------------------------------------------------------

loc_27A2D0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+3F8
                SUBS            XZR, X25, X27
                B.eq            loc_27A2E4
                SUB             X8, X25, X26
                ADDS            XZR, X8, #1
                B.ne            loc_27A22C

loc_27A2E4:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+3C0
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+3D8
                ORR             X0, XZR, X19 // this
                ORR             W1, WZR, WZR // bool
                BL	_ZN8COptInfo15setLicenseValidEb // COptInfo::setLicenseValid(bool)
//   } // starts at 27A230
                ORR             W22, WZR, WZR
                B               loc_27A23C
// ---------------------------------------------------------------------------

loc_27A2F8:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+148
                BL	__stack_chk_fail
// ---------------------------------------------------------------------------

loc_27A2FC:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+174
//   try {
                ADD             X0, SP, #0xE0+var_A8
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv // std::__basic_string_common<true>::__throw_length_error(void)
//   } // starts at 27A2FC
// ---------------------------------------------------------------------------

loc_27A304:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+30C
//   try {
                ADD             X0, SP, #0xE0+var_C0
                BL	_ZNKSt6__ndk120__vector_base_commonILb1EE20__throw_out_of_rangeEv // std::__vector_base_common<true>::__throw_out_of_range(void)
//   } // starts at 27A304
// ---------------------------------------------------------------------------

loc_27A30C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+380
//   try {
                ADD             X0, SP, #0xE0+var_C0
                BL	_ZNKSt6__ndk120__vector_base_commonILb1EE20__throw_out_of_rangeEv // std::__vector_base_common<true>::__throw_out_of_range(void)
//   } // starts at 27A30C
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27A230
//   cleanup() // owned by 27A30C
                LDRB            W8, [SP,#0xE0+var_D8]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_27A38C
                LDR             X0, [SP,#0xE0+var_C8] // ptr
                BL	_ZdlPv // operator delete(void *)
                LDR             X20, [SP,#0xE0+var_C0]
                CBNZ            X20, loc_27A394
                B               loc_27A3D8
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27A164
                B               loc_27A388
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27A074
                LDRB            W8, [SP,#0xE0+var_D8]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_27A3D8
                LDR             X0, [SP,#0xE0+var_C8]
                B               loc_27A3D4
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27A064
                ORR             X19, XZR, X0
                LDRB            W8, [SP,#0xE0+var_90]
                TBZ             W8, #0, loc_27A404
                B               loc_27A3E0
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27A058
                B               loc_27A400
// ---------------------------------------------------------------------------
//   cleanup() // owned by 279FD0
                LDRB            W8, [SP,#0xE0+var_A8]
                ORR             X19, XZR, X0
                TBZ             W8, #0, loc_27A404
                LDR             X0, [SP,#0xE0+var_98]
                B               loc_27A3E4
// ---------------------------------------------------------------------------
//   cleanup() // owned by 279EB8
                LDRB            W8, [SP,#0xE0+var_90]
                ORR             X19, XZR, X0
                TBNZ            W8, #0, loc_27A3E0
                B               loc_27A404
// ---------------------------------------------------------------------------
//   cleanup() // owned by 279E88
                B               loc_27A400
// ---------------------------------------------------------------------------

loc_27A388:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+520
//   cleanup() // owned by 27A0B8
//   cleanup() // owned by 27A304
                ORR             X19, XZR, X0

loc_27A38C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+508
                LDR             X20, [SP,#0xE0+var_C0]
                CBZ             X20, loc_27A3D8

loc_27A394:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+518
                LDR             X8, [SP,#0xE0+var_B8]
                SUBS            XZR, X8, X20
                B.eq            loc_27A3F4
                ORR             X21, XZR, X8
                LDRB            W9, [X21,#-0x18]!
                TBNZ            W9, #0, loc_27A3C0

loc_27A3AC:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+5A8
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+5B4
                SUBS            XZR, X20, X21
                ORR             X8, XZR, X21
                B.eq            loc_27A3CC
                LDRB            W9, [X21,#-0x18]!
                TBZ             W9, #0, loc_27A3AC

loc_27A3C0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+594
                LDUR            X0, [X8,#-8] // ptr
                BL	_ZdlPv // operator delete(void *)
                B               loc_27A3AC
// ---------------------------------------------------------------------------

loc_27A3CC:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+5A0
                LDR             X0, [SP,#0xE0+var_C0] // ptr

loc_27A3D0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+5E4
                STR             X20, [SP,#0xE0+var_B8]

loc_27A3D4:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+534
                BL	_ZdlPv // operator delete(void *)

loc_27A3D8:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+51C
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+52C
                LDRB            W8, [SP,#0xE0+var_90]
                TBZ             W8, #0, loc_27A404

loc_27A3E0:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+544
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+568
                LDR             X0, [SP,#0xE0+ptr] // ptr

loc_27A3E4:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+55C
                BL	_ZdlPv // operator delete(void *)
                LDRB            W8, [SP,#0xE0+size+4]
                TBNZ            W8, #0, loc_27A40C
                B               loc_27A414
// ---------------------------------------------------------------------------

loc_27A3F4:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+588
                ORR             X0, XZR, X20
                B               loc_27A3D0
// ---------------------------------------------------------------------------
//   cleanup() // owned by 279FA4
//   cleanup() // owned by 27A004
//   cleanup() // owned by 27A040
//   cleanup() // owned by 27A2FC
                B               loc_27A400
// ---------------------------------------------------------------------------

loc_27A400:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+548
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+570
//   cleanup() // owned by 27A028
                ORR             X19, XZR, X0

loc_27A404:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+540
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+554
                LDRB            W8, [SP,#0xE0+size+4]
                TBZ             W8, #0, loc_27A414

loc_27A40C:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+5D8
                LDR             X0, [SP,#0xE0+var_60] // ptr
                BL	_ZdlPv // operator delete(void *)

loc_27A414:                             // CODE XREF: CApiLicense::verifyOption(COptInfo *,RString &,RString &)+5DC
                                        // CApiLicense::verifyOption(COptInfo *,RString &,RString &)+5F4
                ORR             X0, XZR, X19
                BL              sub_A1036C
// } // starts at 279E14
// End of function CApiLicense::verifyOption(COptInfo *,RString &,RString &)


// __int64 __fastcall RString::remove(RString *__hidden this, int, int)
                .globl _ZN7RString6removeEii // weak
_ZN7RString6removeEii:                  // CODE XREF: RString::remove(int,int)+C
                                        // DATA XREF: LOAD:0000000000048E68

var_30          = -0x30
var_20          = -0x20
var_10          = -0x10
var_s0          =  0

// __unwind {
                STR             X23, [SP,#-0x10+var_30]!
                STP             X22, X21, [SP,#0x30+var_20]
                STP             X20, X19, [SP,#0x30+var_10]
                STP             X29, X30, [SP,#0x30+var_s0]
                ADD             X29, SP, #0x30
                LDRB            W9, [X0]
                ORR             X19, XZR, X0
                ORR             X20, XZR, X8
                SBFM            X8, X1, #0, #0x1F
                TBNZ            W9, #0, loc_27A47C
                UBFM            X21, X9, #1, #0x3F // '?'
                SUBS            X10, X21, X8
                B.cs            loc_27A488
                B               loc_27A4F8
// ---------------------------------------------------------------------------

loc_27A47C:                             // CODE XREF: RString::remove(int,int)+24
                LDR             X21, [X19,#8]
                SUBS            X10, X21, X8
                B.cc            loc_27A4F8

loc_27A488:                             // CODE XREF: RString::remove(int,int)+30
                CBZ             W2, loc_27A4DC
                SBFM            X11, X2, #0, #0x1F
                TBNZ            W9, #0, loc_27A49C
                ADD             X22, X19, #1
                B               loc_27A4A0
// ---------------------------------------------------------------------------

loc_27A49C:                             // CODE XREF: RString::remove(int,int)+4C
                LDR             X22, [X19,#0x10]

loc_27A4A0:                             // CODE XREF: RString::remove(int,int)+54
                SUBS            XZR, X10, X11
                CSEL            X23, X10, X11, cc
                SUBS            X2, X10, X23 // n
                B.eq            loc_27A4BC
                ADD             X0, X22, X8 // dest
                ADD             X1, X0, X23 // src
                BL	memmove

loc_27A4BC:                             // CODE XREF: RString::remove(int,int)+68
                LDRB            W9, [X19]
                SUB             X8, X21, X23
                TBNZ            W9, #0, loc_27A4D4
                UBFM            W9, W8, #0x1F, #0x1E
                STRB            W9, [X19]
                B               loc_27A4D8
// ---------------------------------------------------------------------------

loc_27A4D4:                             // CODE XREF: RString::remove(int,int)+80
                STR             X8, [X19,#8]

loc_27A4D8:                             // CODE XREF: RString::remove(int,int)+8C
                STRB            WZR, [X22,X8]

loc_27A4DC:                             // CODE XREF: RString::remove(int,int):loc_27A488
                ORR             X0, XZR, X20
                ORR             X1, XZR, X19
                LDP             X29, X30, [SP,#0x30+var_s0]
                LDP             X20, X19, [SP,#0x30+var_10]
                LDP             X22, X21, [SP,#0x30+var_20]
                LDR             X23, [SP],#0x40
                B	_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_ // std::string::basic_string(std::string const&)
// ---------------------------------------------------------------------------

loc_27A4F8:                             // CODE XREF: RString::remove(int,int)+34
                                        // RString::remove(int,int)+40
                ORR             X0, XZR, X19
                BL	_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_out_of_rangeEv // std::__basic_string_common<true>::__throw_out_of_range(void)
// } // starts at 27A444
// End of function RString::remove(int,int)


// __int64 __fastcall CApiLicense::generate_something(CApiLicense *__hidden this, unsigned __int64)
                .globl _ZN11CApiLicense18generate_somethingEm
_ZN11CApiLicense18generate_somethingEm: // CODE XREF: CApiLicense::generate_something(ulong)+C
                                        // DATA XREF: LOAD:0000000000042F10

var_50          = -0x50
var_40          = -0x40
var_30          = -0x30
var_20          = -0x20
var_10          = -0x10
var_s0          =  0

// __unwind { // __gxx_personality_v0
                STR             X27, [SP,#-0x10+var_50]!
                STP             X26, X25, [SP,#0x50+var_40]
                STP             X24, X23, [SP,#0x50+var_30]
                STP             X22, X21, [SP,#0x50+var_20]
                STP             X20, X19, [SP,#0x50+var_10]
                STP             X29, X30, [SP,#0x50+var_s0]
                ADD             X29, SP, #0x50
                STP             XZR, XZR, [X8]
                STR             XZR, [X8,#0x10]
                CBZ             X1, loc_27A604
                ORR             X20, XZR, X1
                ORR             X19, XZR, X8
//   try {
                ORR             X0, XZR, X1 // unsigned __int64
                BL	_Znwm  // operator new(ulong)
//   } // starts at 27A530
                ORR             X24, XZR, XZR
                ADD             X8, X0, X20
                SUB             X25, X20, #1
                ORR             X26, XZR, #0x3FFFFFFFFFFFFFFE
                STP             X0, X0, [X19]
                STR             X8, [X19,#0x10]
                SUBS            XZR, X0, X8
                B.cs            loc_27A56C

loc_27A558:                             // CODE XREF: CApiLicense::generate_something(ulong)+100
                STRB            W24, [X0],#1
                STR             X0, [X19,#8]
                SUBS            XZR, X25, X24
                B.ne            loc_27A5F0
                B               loc_27A604
// ---------------------------------------------------------------------------

loc_27A56C:                             // CODE XREF: CApiLicense::generate_something(ulong)+54
                                        // CApiLicense::generate_something(ulong)+FC
                LDR             X20, [X19]
                SUB             X21, X0, X20
                ADDS            X9, X21, #1
                B.mi            loc_27A620
                SUB             X8, X8, X20
                SUBS            XZR, X8, X26
                B.hi            loc_27A5A0
                UBFM            X8, X8, #0x3F, #0x3E // '?' '>'
                SUBS            XZR, X8, X9
                CSEL            X23, X9, X8, cc
                CBNZ            X23, loc_27A5A4
                ORR             X22, XZR, XZR
                B               loc_27A5B0
// ---------------------------------------------------------------------------

loc_27A5A0:                             // CODE XREF: CApiLicense::generate_something(ulong)+84
                MOVN            X23, #0x8000,LSL#48

loc_27A5A4:                             // CODE XREF: CApiLicense::generate_something(ulong)+94
//   try {                               // unsigned __int64
                ORR             X0, XZR, X23
                BL	_Znwm  // operator new(ulong)
//   } // starts at 27A5A4
                ORR             X22, XZR, X0

loc_27A5B0:                             // CODE XREF: CApiLicense::generate_something(ulong)+9C
                ADD             X27, X22, X21
                ADD             X23, X22, X23
                SUBS            XZR, X21, #1
                STRB            W24, [X27],#1
                B.lt            loc_27A5D4
                ORR             X0, XZR, X22 // dest
                ORR             X1, XZR, X20 // src
                ORR             X2, XZR, X21 // n
                BL	memcpy

loc_27A5D4:                             // CODE XREF: CApiLicense::generate_something(ulong)+C0
                STP             X22, X27, [X19]
                STR             X23, [X19,#0x10]
                CBZ             X20, loc_27A5E8
                ORR             X0, XZR, X20 // ptr
                BL	_ZdlPv // operator delete(void *)

loc_27A5E8:                             // CODE XREF: CApiLicense::generate_something(ulong)+DC
                SUBS            XZR, X25, X24
                B.eq            loc_27A604

loc_27A5F0:                             // CODE XREF: CApiLicense::generate_something(ulong)+64
                LDP             X0, X8, [X19,#8]
                ADD             X24, X24, #1
                SUBS            XZR, X0, X8
                B.cs            loc_27A56C
                B               loc_27A558
// ---------------------------------------------------------------------------

loc_27A604:                             // CODE XREF: CApiLicense::generate_something(ulong)+24
                                        // CApiLicense::generate_something(ulong)+68
                LDP             X29, X30, [SP,#0x50+var_s0]
                LDP             X20, X19, [SP,#0x50+var_10]
                LDP             X22, X21, [SP,#0x50+var_20]
                LDP             X24, X23, [SP,#0x50+var_30]
                LDP             X26, X25, [SP,#0x50+var_40]
                LDR             X27, [SP],#0x60
                RET
// ---------------------------------------------------------------------------

loc_27A620:                             // CODE XREF: CApiLicense::generate_something(ulong)+78
//   try {
                ORR             X0, XZR, X19
                BL	_ZNKSt6__ndk120__vector_base_commonILb1EE20__throw_length_errorEv // std::__vector_base_common<true>::__throw_length_error(void)
//   } // starts at 27A620
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27A620
                LDR             X20, [X19]
                ORR             X21, XZR, X0
                CBNZ            X20, loc_27A644
                B               loc_27A650
// ---------------------------------------------------------------------------
//   cleanup() // owned by 27A530
                BL              sub_A1036C
//   cleanup() // owned by 27A5A4
                ORR             X21, XZR, X0
                CBZ             X20, loc_27A650

loc_27A644:                             // CODE XREF: CApiLicense::generate_something(ulong)+130
                ORR             X0, XZR, X20 // ptr
                STR             X20, [X19,#8]
                BL	_ZdlPv // operator delete(void *)

loc_27A650:                             // CODE XREF: CApiLicense::generate_something(ulong)+134
                                        // CApiLicense::generate_something(ulong)+140
                ORR             X0, XZR, X21
                BL              sub_A1036C
// } // starts at 27A500
// End of function CApiLicense::generate_something(ulong)


sub_A1036C:                             // CODE XREF: sub_1831B8+5B0
                                        // sub_1831B8+5F8

var_850         = -0x850
var_848         = -0x848
var_840         = -0x840
var_830         = -0x830
var_820         = -0x820
var_810         = -0x810
var_800         = -0x800
var_7F0         = -0x7F0
var_7E0         = -0x7E0
var_7D0         = -0x7D0
var_7C0         = -0x7C0
var_7B0         = -0x7B0
var_7A0         = -0x7A0
var_788         = -0x788
var_B0          = -0xB0
var_A8          = -0xA8

// __unwind {
                SUB             SP, SP, #0x790
                STP             X29, X30, [SP,#0x790+var_850]!
                ADD             X29, SP, #0
                STP             X19, X20, [SP,#0x850+var_820]
                STP             D8, D9, [SP,#0x850+var_7D0]
                ADD             X20, X29, #0xD0
                STP             D10, D11, [SP,#0x850+var_7C0]
                STP             X0, X1, [SP,#0x850+var_840]
                STP             D12, D13, [SP,#0x850+var_7B0]
                STP             X2, X3, [SP,#0x850+var_830]
                STP             D14, D15, [SP,#0x850+var_7A0]
                ORR             X2, XZR, X30
                ADD             X1, X29, #0x850
                STP             X21, X22, [SP,#0x850+var_810]
                ORR             X21, XZR, X0
                ORR             X0, XZR, X20
                STP             X23, X24, [SP,#0x850+var_800]
                STP             X25, X26, [SP,#0x850+var_7F0]
                STP             X27, X28, [SP,#0x850+var_7E0]
                ADD             X19, X29, #0x490
                BL              sub_A0FD34
                ORR             X0, XZR, X19 // dest
                ORR             X1, XZR, X20 // src
                MOVZ            X2, #0x3C0 // n
                BL	memcpy
                LDR             X0, [X21,#0x10]
                CBNZ            X0, loc_A103E8
                ORR             X0, XZR, X21 // int
                ORR             X1, XZR, X19 // int
                BL              sub_A0FE5C
                B               loc_A103F4
// ---------------------------------------------------------------------------

loc_A103E8:                             // CODE XREF: sub_A1036C+68
                ORR             X0, XZR, X21 // int
                ORR             X1, XZR, X19 // int
                BL              sub_A0FF1C

loc_A103F4:                             // CODE XREF: sub_A1036C+78
                SUBS            WZR, W0, #7
                B.eq            loc_A10400
                BL	abort
// ---------------------------------------------------------------------------

loc_A10400:                             // CODE XREF: sub_A1036C+8C
                ORR             X1, XZR, X19
                ORR             X0, XZR, X20
                BL              sub_A0EA08
                LDR             X19, [X29,#0x850+var_A8]
                STR             X0, [X29,#0x850+var_788]
                LDR             X0, [X29,#0x850+var_B0]
                ORR             X1, XZR, X19
                BL              nullsub_6
                STR             X19, [SP,#0x850+var_848]
                LDR             X4, [X29,#0x850+var_788]
                LDP             D8, D9, [SP,#0x850+var_7D0]
                LDP             X0, X1, [SP,#0x850+var_840]
                LDP             D10, D11, [SP,#0x850+var_7C0]
                LDP             X2, X3, [SP,#0x850+var_830]
                LDP             D12, D13, [SP,#0x850+var_7B0]
                LDP             X19, X20, [SP,#0x850+var_820]
                LDP             D14, D15, [SP,#0x850+var_7A0]
                LDP             X21, X22, [SP,#0x850+var_810]
                LDP             X23, X24, [SP,#0x850+var_800]
                LDP             X25, X26, [SP,#0x850+var_7F0]
                LDP             X27, X28, [SP,#0x850+var_7E0]
                LDP             X29, X30, [SP],#0xC0
                ADD             X16, SP, #0
                ADD             SP, SP, X4
                ADD             SP, SP, #0x790
                RET
// } // starts at A1036C
// End of function sub_A1036C


AES_decrypt: 
	RET

AES_set_decrypt_key: 
	RET

_Z13API_Save2Framv:  // API_Save2Fram(void)
	RET

_ZN10RByteArrayC2EPKci:  // RByteArray::RByteArray(char const*,int)
	RET

_ZN11CApiLicense15setBundleEnableE7OptTypeb:  // CApiLicense::setBundleEnable(OptType,bool)
	RET

_ZN11CApiLicense17getStringFromEnumE7OptType:  // CApiLicense::getStringFromEnum(OptType)
	RET

_ZN11CApiLicense9deleteOptE7OptType:  // CApiLicense::deleteOpt(OptType)
	RET

_ZN6CXXTEA6decodeEPil:  // CXXTEA::decode(int *,long)
	RET

_ZN6CXXTEA7setKeysEPi:  // CXXTEA::setKeys(int *)
	RET

_ZN8COptInfo10getLicenseEv:  // COptInfo::getLicense(void)
	RET

_ZN8COptInfo10getRunTimeEv:  // COptInfo::getRunTime(void)
	RET

_ZN8COptInfo11getLeftDaysEv:  // COptInfo::getLeftDays(void)
	RET

_ZN8COptInfo12setBndEnableEb:  // COptInfo::setBndEnable(bool)
	RET

_ZN8COptInfo13getRemainTimeEv:  // COptInfo::getRemainTime(void)
	RET

_ZN8COptInfo14getLicenseTimeEv:  // COptInfo::getLicenseTime(void)
	RET

_ZN8COptInfo14setLicenseTimeE11LicenseTime:  // COptInfo::setLicenseTime(LicenseTime)
	RET

_ZN8COptInfo14setLicenseTypeE11LicenseType:  // COptInfo::setLicenseType(LicenseType)
	RET

_ZN8COptInfo15getLicenseValidEv:  // COptInfo::getLicenseValid(void)
	RET

_ZN8COptInfo15setLicenseValidEb:  // COptInfo::setLicenseValid(bool)
	RET

_ZN8COptInfo7getTypeEv:  // COptInfo::getType(void)
	RET

_ZN9CApiSetup13getPrivateLenEi:  // CApiSetup::getPrivateLen(int)
	RET

_ZN9CApiSetup14getPrivateBaseEi:  // CApiSetup::getPrivateBase(int)
	RET

_ZN9CApiSetup16savePrivateSetupEiPvi:  // CApiSetup::savePrivateSetup(int,void *,int)
	RET

_ZN9CApiSetup18removePrivateSetupEi:  // CApiSetup::removePrivateSetup(int)
	RET

_ZNK8CApiBase5getIdEv:  // CApiBase::getId(void)
	RET

_ZNKSt6__ndk120__vector_base_commonILb1EE20__throw_length_errorEv:  // std::__vector_base_common<true>::__throw_length_error(void)
	RET

_ZNKSt6__ndk120__vector_base_commonILb1EE20__throw_out_of_rangeEv:  // std::__vector_base_common<true>::__throw_out_of_range(void)
	RET

_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_length_errorEv:  // std::__basic_string_common<true>::__throw_length_error(void)
	RET

_ZNKSt6__ndk121__basic_string_commonILb1EE20__throw_out_of_rangeEv:  // std::__basic_string_common<true>::__throw_out_of_range(void)
	RET

_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm:  // std::string::assign(char const*,ulong)
	RET

_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__grow_byEmmmmmm:  // std::string::__grow_by(ulong,ulong,ulong,ulong,ulong,ulong)
	RET

_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_:  // std::string::basic_string(std::string const&)
	RET

_ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc:  // std::string::basic_string<decltype(nullptr)>(char const*)
	RET

_ZNSt6__ndk16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE21__push_back_slow_pathIRKS6_EEvOT_:  // std::vector<std::string>::__push_back_slow_path<std::string const&>(std::string const&)
	RET

_ZNSt6__ndk16vectorIcNS_9allocatorIcEEE6assignIPcEENS_9enable_ifIXaasr21__is_forward_iteratorIT_EE5valuesr16is_constructibleIcNS_15iterator_traitsIS7_E9referenceEEE5valueEvE4typeES7_S7_: 
	RET

_ZNSt6__ndk16vectorIcNS_9allocatorIcEEEC2ERKS3_:  // std::vector<char>::vector(std::vector<char> const&)
	RET

_ZdaPv:  // operator delete[](void *)
	RET

_ZdlPv:  // operator delete(void *)
	RET

_Znam:   // operator new[](ulong)
	RET

_Znwm:   // operator new(ulong)
	RET

__android_log_print: 
	RET

__stack_chk_fail: 
	RET

nullsub_6: 
	RET

sub_25874C: // join strings
	RET

sub_A0EA08: 
	RET

sub_A0FD34: 
	RET

sub_A0FE5C: 
	RET

sub_A0FF1C: 
	RET

	.data

aSSDGenNewKey: .ascii "[%s][%s][%d]:Gen NEW KEY"
	.byte 0
asc_A2C12F: .ascii ";"
	.byte 0
asc_A25ADA: .ascii "#"
	.byte 0
aGetlicensekey: .ascii "getLicenseKey"
	.byte 0
aSrcCppScopeApi_6: .ascii "src/cpp/scope/api/license"
	.byte 0
aRigolScope: .ascii "[RIGOL.SCOPE]"
	.byte 0
aRkeyData: .ascii "RKey.data"
	.byte 0
bytezr: .byte 0

