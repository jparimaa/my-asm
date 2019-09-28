%include 'functions.asm'
 
SECTION .data
childMsg    db  'This is the child process', 0h
parentMsg   db  'This is the parent process', 0h
 
SECTION .text
global  _start
 
_start:
 
    mov  eax, SYS_FORK
    int  80h
 
    cmp  eax, 0 ;if eax is zero we are in the child process
    jz   child  ;jump if eax is zero
 
parent:
    mov  eax, parentMsg 
    call print_string_LF
    mov  eax, SYS_TIME
    int  80h
    call print_int_LF
 
    call quit           
 
child:
    mov  eax, childMsg  
    call print_string_LF
    mov  eax, SYS_TIME
    int  80h
    call print_int_LF
 
    call quit           