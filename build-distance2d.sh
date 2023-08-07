#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o distance2d.o distance2d.s -g
ld -o distance2d distance2d.o -lc
