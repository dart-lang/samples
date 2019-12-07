primitives: primitives.o
	gcc -o a.out primitives.o

primitives.o: primitives.c
	gcc -c primitives.c

dylib: primitives.o
	gcc -dynamiclib -undefined suppress -flat_namespace primitives.o -o ../primitives.dylib

dll: primitives.o
	gcc -shared primitives.o -o ../primitives.dll

clean:
	rm a.out primitives.o ../primitives.dll
