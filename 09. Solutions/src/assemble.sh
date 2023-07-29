#! /usr/bin/bash

nasm -f elf64 main.asm
ld main.o -o main
