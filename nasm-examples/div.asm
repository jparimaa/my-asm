;divide 91 by 9 and print the result

%include 'functions.asm'
 
SECTION .data
msg1    db  ' remainder '   ;a message string to correctly output result
 
SECTION .text
global  _start
 
_start:
    mov  eax, 91        ;move our first number into eax
    mov  ebx, 9         ;move our second number into ebx
    div  ebx            ;divide eax by ebx
    call print_int      ;call our integer print function on the quotient
    mov  eax, msg1      ;move our message string into eax
    call print_string
    mov  eax, edx       ;move our remainder into eax
    call print_int_LF   ;call our integer printing with linefeed function
    call quit

;$ ./div.out 
;10 remainder 1
