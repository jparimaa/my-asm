%include 'functions.asm'
 
SECTION .data
msg1    db      'Hello, brave new world!', 0Ah, 0h
msg2    db      'Printing another string, yei!', 0Ah, 0h
 
SECTION .text
global  _start
 
_start:
 
    mov  eax, msg1
    call print_string
 
    mov  eax, msg2
    call print_string
 
    call quit