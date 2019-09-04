all: libleb128.dylib leb128.o

libleb128.dylib: leb128.h
	g++ -m64 -dynamiclib -o libleb128.dylib tmp.leb128.h

leb128.so: leb128.o
	gcc -shared -fPIC  -o leb128.so leb128.o -lc

leb128.o: tmp.leb128.h
	gcc -c -fPIC  -o leb128.o tmp.leb128.h

.PHONY: all