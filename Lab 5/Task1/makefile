profile.txt : gmon.out
	gprof main_gprof gmon.out > profile.txt

gmon.out : main_gprof
	./main_gprof < 1000.txt
	
main_gprof : matchain.c
	gcc -pg matchain.c -o main_gprof
	
main_perf : matchain.c
	gcc matchain.c -o main_perf
	
record :
	perf record ./main_perf < 1000.txt

clean :
	rm -f main_perf main_gprof perf.data gmon.out profile.txt

.PHONY: clean
