
all: libadd.so

libadd.so: add.cpp
	g++ -fPIC -shared -Wall -I. -o libadd.so add.cpp

clean:
	-rm libadd.so