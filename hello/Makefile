CXX		  := g++
CXX_FLAGS := -Wall -std=c++11 -ggdb -Wl,-rpath=lib

BIN		:= bin
SRC		:= src
INCLUDE	:= include
LIB		:= lib

LIBRARIES	:= 
EXECUTABLE	:= main abc


all: $(BIN)/$(EXECUTABLE) $(BIN)/testlib

run: clean all
	clear
	./$(BIN)/$(EXECUTABLE)

$(BIN)/$(EXECUTABLE): $(SRC)/*.cpp
	$(CXX) $(CXX_FLAGS) -I$(INCLUDE) -L$(LIB) $^ -o $@ $(LIBRARIES)

$(BIN)/testlib: test/test_libcplus.cpp
	$(CXX) $(CXX_FLAGS) \
		-I$(INCLUDE) \
		-I/mnt/d/VSCodeCplus/add \
		-I/mnt/d/VSCodeCplus/libcrfpp/include \
		-L$(LIB) \
		-L/mnt/d/VSCodeCplus/add \
		-L/mnt/d/VSCodeCplus/libcrfpp/dist \
		$^ -o $@ -lpthread -ladd -lggg -lcrfpp -lcurl

clean:
	-rm bin/*
