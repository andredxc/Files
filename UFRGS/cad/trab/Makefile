CFLAGS=-g -Wall
CC=g++

all: dijkstra.cpp prim.cpp trab.cpp
	$(CC) -c trab.cpp $(CFLAGS)
	$(CC) -o dijkstra dijkstra.cpp trab.o $(CFLAGS)
	$(CC) -o prim prim.cpp trab.o $(CFLAGS)

clean:
	rm -f *~ *.o prim dijkstra
