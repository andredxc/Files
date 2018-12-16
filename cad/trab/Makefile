TARGET=main
CFLAGS=-g -Wall
CC=g++

all: main.cpp trab.cpp
	$(CC) -c trab.cpp $(CFLAGS)
	$(CC) -o $(TARGET) main.cpp trab.o $(CFLAGS)

clean:
	rm -f *~ *.o $(TARGET)
