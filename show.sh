#!/bin/bash

set -e   # stop on error
set -x   # echo on

# Use gnu objdump to disassemble .text sections of an executable file.

objdump -d $1 | more
