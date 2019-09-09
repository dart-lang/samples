structs: structs.o
	gcc -o a.out structs.o

structs.o: structs.c
	gcc -c structs.c

dylib: structs.o
	gcc -dynamiclib -undefined suppress -flat_namespace structs.o -o ../structs.dylib

clean:
	rm a.out structs.o ../structs.dylib