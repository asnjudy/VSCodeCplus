#!/bin/bash

LIB_SOURCES=(libcrfpp.cpp lbfgs.cpp param.cpp encoder.cpp \
feature.cpp feature_cache.cpp feature_index.cpp \
node.cpp path.cpp tagger.cpp)

APP_SOURCES=(crf_learn.cpp crf_test.cpp example.cpp)

clean_files()
{
    echo "-- clear dir: dist and tmp"
    rm -rf dist/*
    rm -rf tmp/*
}

compile_app_source()
{
    local lib_source_all
    local app_source=$1
    local app_name=${app_source%.*}

    echo "-- compile $app_source"
    
    for lib_source in ${LIB_SOURCES[@]}; do
        lib_source_all="$lib_source_all src/crfpp/$lib_source"
    done

    shell_cmd="g++ -DHAVE_CONFIG_H -Wall -std=c++11 -ggdb -Iinclude \
                    -o dist/$app_name \
                    src/test/$app_source $lib_source_all \
                    -lpthread"
    echo $shell_cmd
    $shell_cmd
}


build_executable()
{
    clean_files
    for app_source in ${APP_SOURCES[@]}; do
        compile_app_source $app_source
    done
}

build_executable