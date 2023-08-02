#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o printf.o printf.s -g
ld -o printf printf.o -lc
