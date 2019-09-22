%include 'functions.asm'
 
SECTION .data
msg1    db  'Please enter your name: ', 0h
msg2    db  'Hello, ', 0h
 
SECTION .bss
input   resb    255 ;reserve a 255 byte space in memory for the users input string
 
SECTION .text
global  _start
 
_start: 
    mov  eax, msg1
    call print_string
 
    mov  edx, 255       ;number of bytes to read
    mov  ecx, input     ;reserved space to store our input (known as a buffer)
    mov  ebx, STDIN
    mov  eax, SYS_READ
    int  80h
 
    mov  eax, msg2
    call print_string
 
    mov  eax, input     ;move our buffer into eax (Note: input contains a linefeed)
    call print_string   ;call our print function
 
    call quit
