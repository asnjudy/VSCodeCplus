#!/bin/bash

echo "-- clear dir: dist and tmp"
rm -rf dist/*
rm -rf tmp/*

echo "-- compile the required sources and generate the object files"
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/libcrfpp.cpp -o tmp/libcrfpp.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/lbfgs.cpp -o tmp/lbfgs.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/param.cpp -o tmp/param.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/encoder.cpp -o tmp/encoder.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/feature.cpp -o tmp/feature.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/feature_cache.cpp -o tmp/feature_cache.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/feature_index.cpp -o tmp/feature_index.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/node.cpp -o tmp/node.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/path.cpp -o tmp/path.o
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c src/crfpp/tagger.cpp -o tmp/tagger.o


echo "-- create the static library libcrfpp"
ar -cr dist/libcrfpp.a tmp/libcrfpp.o tmp/lbfgs.o tmp/param.o tmp/encoder.o \
    tmp/feature.o tmp/feature_cache.o tmp/feature_index.o \
    tmp/node.o tmp/path.o tmp/tagger.o

echo "-- compile crf_learn.cpp"
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude \
    -o dist/crf_learn \
    src/test/crf_learn.cpp dist/libcrfpp.a -lpthread

echo "-- compile crf_test.cpp"
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude \
    -o dist/crf_test \
    src/test/crf_test.cpp dist/libcrfpp.a -lpthread

echo "-- compile example.cpp"
g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude \
    -o dist/example \
    src/test/example.cpp dist/libcrfpp.a -lpthread
