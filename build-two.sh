#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o two.o two.s -g
ld -o two two.o -lc
