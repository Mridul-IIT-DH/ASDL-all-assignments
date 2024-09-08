canny: main.o canny.o HashMap.o
	g++ -Wall -pg -o canny.out main.o canny.o HashMap.o
main.o: main.cpp
	g++ -Wall -pg -c main.cpp
canny.o: canny.cpp
	g++ =Wall -pg -c canny.cpp
HashMap.o: HashMap.cpp
	g++ -Wall -pg -c HashMap.cpp
clean:
	rm -f *.o *.out output_images/*.pgm
sobel: sobel.o
	g++ -Wall -pg -o sobel.out sobel.o
sobel.o: sobel.cpp
	g++ -Wall -pg -c sobel.cpp
