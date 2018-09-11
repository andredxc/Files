EXEC=main

all: aagReader.o aig.o
	g++ -o $(EXEC) main.cpp aagReader.o aig.o

aagReader.o:
	g++ -c aagReader.cpp

aig.o:
	g++ -c aig.cpp

clean:
	rm *.~ *.o $(EXEC)
