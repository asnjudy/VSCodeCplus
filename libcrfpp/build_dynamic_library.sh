#!/bin/bash

compile() {
    echo "-- begin compiling"
    if [ -d tmp ]; then
        rm -f tmp/*
    else
        mkdir tmp
    fi
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/libcrfpp.cpp -o tmp/libcrfpp.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/lbfgs.cpp -o tmp/lbfgs.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/param.cpp -o tmp/param.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/encoder.cpp -o tmp/encoder.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/feature.cpp -o tmp/feature.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/feature_cache.cpp -o tmp/feature_cache.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/feature_index.cpp -o tmp/feature_index.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/node.cpp -o tmp/node.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/path.cpp -o tmp/path.o
    g++ -DHAVE_CONFIG_H -Wall -fPIC -DPIC -ggdb -Iinclude -c src/crfpp/tagger.cpp -o tmp/tagger.o
}

link() {
    echo "-- begin to link the object files"

    g++ -shared \
        tmp/libcrfpp.o tmp/lbfgs.o tmp/param.o tmp/encoder.o \
        tmp/feature.o tmp/feature_cache.o tmp/feature_index.o \
        tmp/node.o tmp/path.o tmp/tagger.o \
        -lpthread \
        -Wl,-soname -Wl,libcrfpp.so.0 \
        -o dist/libcrfpp.so.0.0.0

    # create soft link
    cd dist
    rm -f libcrfpp.so.0 && ln -s libcrfpp.so.0.0.0 libcrfpp.so.0
    rm -f libcrfpp.so && ln -s libcrfpp.so.0.0.0 libcrfpp.so
    cd ..
}

build() {
    clean # 编译前，先清空 bin 目录
    compile
    link
}

clean() {
    echo "-- clear the dest/* and tmp/* dir"
    rm -rf dest/*
    rm -rf tmp/*
}

case "$1" in
    clean)
        clean
        ;;
    link)
        link
        ;;
    build)
        build
        ;;
    test)
        # 编译 crf_learn.cpp 生成目标文件，指定头文件
        g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -c -o tmp/crf_learn.o src/test/crf_learn.cpp
        # 组装目标文件生成可执行文件
        g++ -Wall -Ldist -o dist/crf_learn tmp/crf_learn.o -lcrfpp

        # 编译 crf_test.cpp
        g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -Ldist -o dest/crf_test src/test/crf_learn.cpp -lcrfpp
        # 编译 example.cpp
        g++ -DHAVE_CONFIG_H -Wall -ggdb -Iinclude -Ldist -o dest/example src/test/example.cpp -lcrfpp
        ;;
    *)
        echo "Usage: ./make {build|test|clean}"
        exit 1
        ;;
esac

exit 0
