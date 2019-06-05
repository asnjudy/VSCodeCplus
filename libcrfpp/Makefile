CXX		  := g++
CXX_FLAGS := -Wall -std=c++11 -ggdb

DIST	:= dist
SRC		:= src
INCLUDE	:= include
LIB		:= lib
TMP		:= tmp
LIB_SO_NAME := libcrfpp.so

# src/crfpp/param.cpp src/crfpp/feature_cache.cpp
LIB_SOURCES := $(wildcard src/crfpp/*.cpp)
# tmp/param.o  tmp/feature_cache.o
LIB_OBJECTS := $(patsubst src/crfpp/%.cpp, $(TMP)/%.o, $(LIB_SOURCES))

APP_SOURCES := $(wildcard src/test/*.cpp)
APP_NAMES := $(patsubst src/test/%.cpp, %, $(APP_SOURCES))
APP_EXES  := $(patsubst src/test/%.cpp, $(DIST)/%, $(APP_SOURCES))


all: $(LIB_OBJECTS) $(DIST)/$(LIB_SO_NAME) $(APP_EXES)

run: all
	clear
	# Makefile 中一行是一个完整的 shell 语句，启动一个独立的 sub shell执行该语句命令
	# 为了方便阅读，所以格式化成了多行（实质上还是一行）。shell语句中各命令间用分号分隔
	for name in `echo $(APP_NAMES)`; \
	do \
		cd dist; ./$$name; cd ..; \
	done

# 编译库源代码文件为目标文件
# LIB_OBJECTS -> tmp/param.o  tmp/feature_cache.o 配对该规则
$(TMP)/%.o: $(SRC)/crfpp/%.cpp
	$(CXX) -DHAVE_CONFIG_H -fPIC -DPIC $(CXX_FLAGS) -I$(INCLUDE) -L$(LIB) $^ -c -o $@

$(DIST)/$(LIB_SO_NAME): $(LIB_OBJECTS)
	$(CXX) -shared $^ -o $@ -lpthread

$(DIST)/%: $(SRC)/test/%.cpp
	$(CXX) $(CXX_FLAGS) -Wl,-rpath=. -I$(INCLUDE) -L$(LIB) -L$(DIST) $^ -o $@ -lcrfpp

clean:
	# 涉及到 "rm tmp/a" 文件删除命令，路径严禁带环境变量（路径有环境变量，就说明删的东西不确定）
	# 例如： rm ${TMP}/*; 若环境变量 TMP 不存在（写错成 TEMP，或废除了）
	# 则该删除命令就变成了： rm /*; 这还好，没带 -rf 选项; 否则变成了 rm -rf /* 后果不堪设想
	# 谨记：文件删除命令 rm 严禁带环境变量，确保删除的文件路径是精确的，不依赖任何上文定义的环境变量
	-rm dist/*
	-rm tmp/*
