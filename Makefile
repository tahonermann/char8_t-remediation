# Copyright (c) 2019, Tom Honermann
#
# This file is distributed under the MIT License. See the accompanying file
# LICENSE.txt or http://www.opensource.org/licenses/mit-license.php for terms
# and conditions.

ifeq ($(COMPILER),gcc)
  CXX=/home/tom/products/gcc-9.1.0/bin/g++
  CXXFLAGS=-fsyntax-only -Wall -Wno-unused-variable -Wno-unused-but-set-variable
else ifeq ($(COMPILER),clang)
  CXX=/home/tom/products/clang-7.0.0/bin/clang++
  CXXFLAGS=-fsyntax-only -Wall -Wno-unused-variable
else
  $(error COMPILER not set or not recognized)
endif

all: test-cxx11
all: test-cxx14
all: test-cxx17
all: test-cxx20-no-char8_t
all: test-cxx20-char8_t

test-cxx11: test.cpp char8_t-remediation.h
	@echo '**** Testing C++11 ****'
	$(CXX) $(CXXFLAGS) -c -std=c++11 test.cpp

test-cxx14: test.cpp char8_t-remediation.h
	@echo '**** Testing C++14 ****'
	$(CXX) $(CXXFLAGS) -c -std=c++14 test.cpp

test-cxx17: test.cpp char8_t-remediation.h
	@echo '**** Testing C++17 ****'
	$(CXX) $(CXXFLAGS) -c -std=c++17 test.cpp

test-cxx20-no-char8_t: test.cpp char8_t-remediation.h
	@echo '**** Testing C++20 without char8_t ****'
	$(CXX) $(CXXFLAGS) -c -std=c++2a -fno-char8_t test.cpp

test-cxx20-char8_t: test.cpp char8_t-remediation.h
	@echo '**** Testing C++20 with char8_t ****'
	$(CXX) $(CXXFLAGS) -c -std=c++2a -fchar8_t test.cpp
