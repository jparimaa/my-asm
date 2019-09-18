SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

SECTION .data
msg  db   'Hello, brave new world!', 0Ah
 
SECTION .text
global  _start
 
_start: 
    mov  eax, msg
    call strlen
 
    mov  edx, eax
    mov  eax, SYS_WRITE
    mov  ebx, STDOUT
    mov  ecx, msg
    int  80h
 
    mov  eax, SYS_EXIT
    mov  ebx, 0
    int  80h
 
;in: str in eax 
;out: length in eax
strlen: 
    push ebx
    mov  ebx, eax
 
nextchar:
    cmp  byte [eax], 0
    jz   finished
    inc  eax
    jmp  nextchar
 
finished:
    sub  eax, ebx ;how many bytes between start of the string and end (null terminator)
    pop  ebx
    ret