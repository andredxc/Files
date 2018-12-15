TARGET=main
CFLAGS=-g -Wall
CC=g++

all: trab.o main.cpp
	$(CC) -o $(TARGET) main.cpp trab.o $(CFLAGS)

trab.o: trab.cpp
	$(CC) -c trab.cpp $(CFLAGS)

clean:
	rm -f *~ *.o $(TARGET)
