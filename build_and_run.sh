#!/bin/bash

nasm -f elf ${1}.asm
ld -m elf_i386 -s -o ${1}.out ${1}.o
./${1}.out