#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o hello.o hello.s
ld -o hello hello.o
