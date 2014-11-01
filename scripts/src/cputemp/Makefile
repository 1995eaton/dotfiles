CFLAGS=-Ofast -march=native -std=gnu11
LIBS=-lsensors

all: main.o
	gcc main.o $(CFLAGS) $(LIBS) -o cputemp
	mv cputemp ../../
	rm *.o

main.o: main.c
	gcc -c main.c $(CFLAGS) $(LIBS)
