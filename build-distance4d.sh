#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o distance4d.o distance4d.s -g
ld -o distance4d distance4d.o -lc
