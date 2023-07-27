#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o gremlin.o gremlin.s -g
ld -o gremlin gremlin.o -lncurses
