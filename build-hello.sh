#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o hello.o hello.s -g
ld -o hello hello.o
