#!/bin/bash

set -e # stop on error
set -x # echo on

as -o nchello.o nchello.s -g
ld -o nchello nchello.o -lncurses
