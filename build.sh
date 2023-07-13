#!/bin/bash

set -e   # stop on error
set -x   # echo on

as -o ${1}.o ${1}.s
ld -o ${1} ${1}.o

