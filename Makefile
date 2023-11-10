CC=i386-diet gcc
XCC=i686-w64-mingw32-gcc
XLD=i686-w64-mingw32-ld
XAR=i686-w64-mingw32-ar
XNM=i686-w64-mingw32-nm
XRANLIB=i686-w64-mingw32-ranlib
XDLLTOOL=i686-w64-mingw32-dlltool
XOBJDUMP=i686-w64-mingw32-objdump
XSTRIP=i686-w64-mingw32-strip
XAS=i686-w64-mingw32-as
XDLLTOOL=i686-w64-mingw32-dlltool
XDLLWRAP=i686-w64-mingw32-dllwrap
LC_ALL=C
SED=sed

FLAGS = -Wall -Wno-pointer-sign
CFLAGS = -m32 -O2 $(FLAGS)
LFLAGS = -m32 -s
XCFLAGS = -DMINGW $(FLAGS)
XLFLAGS = -s

INC = rigol_vendor_bin.h
PROGS = rigol_vendor_bin rigol_vendor_bin.exe

all: $(PROGS)

RIGOL_OBJ = rigol_vendor_bin.o xxtea.o crc32.o strings.o
RIGOL_XOBJ = rigol_vendor_bin.obj xxtea.obj crc32.obj strings.obj

%.obj: %.c $(INC)
	$(XCC) $(XCFLAGS) -c $< -o $@

%.o: %.c $(INC)
	$(CC) $(CFLAGS) -c $< -o $@

rigol_vendor_bin: $(RIGOL_OBJ)
	$(CC) $(LFLAGS) -O2 -o $@ $^

rigol_vendor_bin.exe: $(RIGOL_XOBJ)
	$(XCC) $(XLFLAGS) -o $@ $^

clean:
	rm -f *~ *.obj *.o # $(PROGS)
