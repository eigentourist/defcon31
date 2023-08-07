#!/bin/bash

set -e   # stop on error
set -x   # echo on

gcc -o d2 d2d.s d2main.s -g
