INC = rigol_vendor_bin.h

all: nv-mem

RIGOL_OBJ = rigol_vendor_bin.o aes.o xxtea.o crc32.o strings.o

%.o: %.c $(INC)
	bin/clang -O2 -c $< -o $@

nv-mem: nv-mem.c
	gcc -O2 -o $@ $^

generate_all_options: $(RIGOL_OBJ)
	bin/clang -o $@ $^

test:	test.o 
	bin/clang -o $@ $< -L. -lscope-auklet

%.o: %.c
	bin/clang -O2 -c $^

clean:
	rm -f *.o test

run:
	qemu-aarch64 ./test

