#!/bin/bash

set -e # stop on error
set -x # echo on

as -o nchello.o nchello.s
ld -o nchello nchello.o -lncurses
