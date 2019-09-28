%include 'functions.asm'
 
SECTION .data
fizz    db  'Fizz', 0h
buzz    db  'Buzz', 0h
 
SECTION .text
global  _start
 
_start:
 
    mov  edi, 0 ;checkFizz boolean variable
    mov  esi, 0 ;checkBuzz boolean variable
    mov  ecx, 0 ;counter variable
 
nextNumber:
    inc  ecx
 
.checkFizz:
    mov  edx, 0       ;this will hold remainder after division
    mov  eax, ecx
    mov  ebx, 3
    div  ebx          ;divide eax by ebx
    mov  edi, edx     ;move remainder
    cmp  edi, 0       ;compare if the counter divides by 3
    jne  .checkBuzz
    mov  eax, fizz
    call print_string
 
.checkBuzz:
    mov  edx, 0       ;this will hold remainder after division
    mov  eax, ecx
    mov  ebx, 5
    div  ebx          ;divide eax by ebx
    mov  esi, edx     ;move remainder
    cmp  esi, 0       ;compare if the counter divides by 5
    jne  .checkInt
    mov  eax, buzz
    call print_string
    jmp  .continue
 
.checkInt:
    cmp  edi, 0
    je   .continue
    mov  eax, ecx   ;move the counter for printing
    call print_int  ;call our integer printing function
 
.continue:
    mov  eax, 0Ah     ;move an ascii linefeed character into eax
    push eax          ;push the address of eax onto the stack for printing
    mov  eax, esp     ;get the stack pointer (address on the stack of our linefeed char)
    call print_string
    pop  eax
    cmp  ecx, 30
    jne  nextNumber
 
    call quit
