
all:
	g++ -c ConnectionManager.cpp
	g++ -o client client.cpp ConnectionManager.o -Wall

run:
	./client -c &
	./client -s

clean:
	rm *.o
