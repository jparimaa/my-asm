#!/bin/bash

rm -f ${1}.o ${1}.out 
nasm -f elf ${1}.asm
ld -m elf_i386 -s -o ${1}.out ${1}.o
./${1}.out