#!/bin/sh

cp `dirname $0`/vim_test/test.cpp `dirname $0`/vim_test/test.temp.cpp
vim `dirname $0`/vim_test/test.temp.cpp
rm `dirname $0`/vim_test/test.temp.cpp
