hello: hello.o
	gcc -o a.out hello.o

hello.o: hello.c
	gcc -c hello.c

dylib: hello.o
	gcc -dynamiclib -undefined suppress -flat_namespace hello.o -o ../hello_world.dylib

dll: hello.o
	gcc -shared hello.o -o ../hello_world.dll

clean:
	rm -f a.out hello.o ../hello_world.dylib ../hello_world.dll
