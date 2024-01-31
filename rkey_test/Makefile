
test:	test.o 
	bin/clang -o $@ $< -L. -lscope-auklet

read-fram: read-fram.o
	bin/clang -o $@ $<

%.o: %.c
	bin/clang -O2 -c $^


clean:
	rm -f *.o test

run:
	qemu-aarch64 ./test
