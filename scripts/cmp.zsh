CC='g++'
C='gcc'
# CXXFLAGS=('-std=c++14' '-Wall' '-Wextra' '-pedantic' '-Ofast')
CXXFLAGS=('-std=c++14' '-Wall' '-Wextra' '-pedantic')
CFLAGS=('-std=c11' '-Wall' '-Wextra' '-pedantic' '-lm')
VFLAGS=('--leak-check=full')

function __cc() {
  tmp=`mktemp`
  $CC ${CXXFLAGS[*]} $1 -o $tmp && time $tmp ${@:2}
  rm $tmp
}

function __vcc() {
  tmp=`mktemp`
  $CC ${CXXFLAGS[*]} $1 -o $tmp && valgrind ${VFLAGS[*]} $tmp ${@:2}
  rm $tmp
}

function __c() {
  tmp=`mktemp`
  $C ${CFLAGS[*]} $1 -o $tmp && time $tmp ${@:2}
  rm $tmp
}

function __asm() {
  dot_o=`mktemp`
  tmp=`mktemp`
  $C -c $1 -o $dot_o
  $C ${CFLAGS[*]} $1 -o $tmp && time $tmp ${@:2}
  rm $dot_o
  rm $tmp
}

function __vasm() {
  dot_o=`mktemp`
  bin=`mktemp`
  $C -std=c11 -O0 -c $1 -o $dot_o
  $C ${CFLAGS[*]} $dot_o -o $bin && valgrind $bin ${@:2}
  rm $dot_o $bin
}

function __vc() {
  tmp=`mktemp`
  $C ${CFLAGS[*]} $1 -o $tmp && valgrind ${VFLAGS[*]} $tmp ${@:2}
  rm $tmp
}

function c2asm() {
  gcc -std=c11 -fno-asynchronous-unwind-tables -fno-ident -Ofast -S -masm=intel "$1" -o - | vim -c'set ft=nasm' -
}

alias runcc=__cc
alias runc=__c
alias runasm=__asm
alias vruncc=__vcc
alias vrunc=__vc
alias vrunasm=__vasm
