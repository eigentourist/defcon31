#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o d2d.o d2d.s -g
as -o d2caller.o d2caller.s -g
ld -o d2a d2d.o d2caller.o -lc
