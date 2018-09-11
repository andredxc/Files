EXEC=main

all: aagReader.o aig.o
	g++ -o $(EXEC) main.cpp aagReader.o aig.o -g

aagReader.o:
	g++ -c aagReader.cpp -g

aig.o:
	g++ -c aig.cpp -g

clean:
	rm *.~ *.o $(EXEC)
