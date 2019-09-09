primitives: primitives.o
	gcc -o a.out primitives.o

primitives.o: primitives.c
	gcc -c primitives.c

dylib: primitives.o
	gcc -dynamiclib -undefined suppress -flat_namespace primitives.o -o ../primitives.dylib

clean:
	rm a.out primitives.o ../primitives.dylib