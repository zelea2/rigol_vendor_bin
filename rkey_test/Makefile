
test:	test.o libscope.o chk.o
	aarch64-linux-gnu-gcc -o $@ $^ -static

%.o: %.asm
	aarch64-linux-gnu-as -o $@ -c $^

%.o: %.c
	aarch64-linux-gnu-gcc -O2 -c $^

clean:
	rm -f *.o test

run:
	qemu-aarch64 ./test
