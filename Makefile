CC = gcc
CXX = g++
AR = ar
LIB_TARGET = libgtest_gmock.a
CXXFLAGS = -std=c++11 -Wall -O3 -I.
SRCS = gmock-gtest-all.cc
OBJS := $(SRCS:.cc=.o)

PREFIX ?= /usr/local
INCLUDE_DIR ?= $(PREFIX)/include
LIB_DIR ?= $(PREFIX)/lib

%.o: $(SRCS)
	$(CXX) $(CXXFLAGS) -o $@ -c $<

$(LIB_TARGET): $(OBJS)
	$(AR) r $@ $(OBJS)

install: $(LIB_TARGET)
	install -d $(LIB_DIR)
	install -d $(INCLUDE_DIR)/gtest
	install -d $(INCLUDE_DIR)/gmock
	install -m 644 $(LIB_TARGET) $(LIB_DIR)/
	install -m 644 gtest/gtest.h $(INCLUDE_DIR)/gtest
	install -m 644 gmock/gmock.h $(INCLUDE_DIR)/gmock

clean:
	rm -f $(LIB_TARGET) $(OBJS)
