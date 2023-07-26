#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o printreg.o printreg.s -g
ld -o printreg printreg.o
