%include 'functions.asm'

SECTION .text
global _start

_start:
    
    pop  ecx                ;first value on the stack is the number of arguments

nextArg:    
    cmp  ecx, 0h            ;check to see if we have any arguments left
    jz   noMoreArgs    
    pop  eax                ;pop the next argument off the stack
    call print_string_LF
    dec  ecx
    jmp  nextArg

noMoreArgs:
    call quit