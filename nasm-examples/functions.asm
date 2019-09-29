;collection of useful functions and constants

SYS_EXIT  equ 1
SYS_FORK  equ 2
SYS_READ  equ 3
SYS_WRITE equ 4
SYS_OPEN  equ 5
SYS_CREAT equ 8
SYS_TIME  equ 13

STDIN     equ 0
STDOUT    equ 1

O_RDONLY  equ 0

;calculate the length of the string
;in: string in eax 
;out: length in eax
string_length: 
    push ebx
    mov  ebx, eax
 
next_char:
    cmp  byte [eax], 0
    jz   finished
    inc  eax
    jmp  next_char
 
finished:
    sub  eax, ebx   ;how many bytes between start of the string and end (null terminator)
    pop  ebx
    ret
 

;print the string
;in: string in eax
print_string:
    push edx
    push ecx
    push ebx
    push eax
    call string_length
 
    mov  edx, eax   ;length of the string
    pop  eax
 
    mov  ecx, eax   ;string to be printed
    mov  ebx, STDOUT
    mov  eax, SYS_WRITE
    int  80h
 
    pop  ebx
    pop  ecx
    pop  edx
    ret

;print the string with linefeed
;in: string in eax
print_string_LF:
    call    print_string
 
    push eax            ;push eax onto the stack to preserve it while we use the eax register in this function
    mov  eax, 0Ah       ;0Ah is the ascii character for a linefeed
    push eax            ;push the linefeed onto the stack so we can get the address
    mov  eax, esp       ;move the address of the current stack pointer into eax for printing
    call print_string
    pop  eax            ;remove our linefeed character from the stack
    pop  eax            ;restore the original value of eax before our function was called
    ret

;print integer
;in: integer in eax
print_int:
    push eax            ;preserve on the stack to be restored
    push ecx            ;preserve on the stack to be restored
    push edx            ;preserve on the stack to be restored
    push esi            ;preserve on the stack to be restored
    mov  ecx, 0         ;counter of how many bytes we need to print in the end
 
divideLoop:
    inc  ecx            ;count each byte to print - number of characters
    mov  edx, 0
    mov  esi, 10
    idiv esi            ;divide eax by esi
    add  edx, 48        ;convert edx to it's ascii representation - edx holds the remainder after a divide instruction
    push edx            ;push edx (string representation of an intger) onto the stack
    cmp  eax, 0         ;can the integer be divided anymore?
    jnz  divideLoop     ;jump if not zero
 
printLoop:
    dec  ecx            ;count down each byte that we put on the stack
    mov  eax, esp       ;mov the stack pointer into eax for printing
    call print_string   ;call our string print function
    pop  eax            ;remove last character from the stack to move esp forward
    cmp  ecx, 0         ;have we printed all bytes we pushed onto the stack?
    jnz  printLoop      ;jump if not zero
 
    pop  esi            ;restore esi
    pop  edx            ;restore edx
    pop  ecx            ;restore ecx
    pop  eax            ;restore eax
    ret    

;print integer with linefeed
;in: integer in eax
print_int_LF:
    call print_int  ;call our integer printing function
 
    push eax            ;push eax onto the stack to preserve it while we use the eax register in this function
    mov  eax, 0Ah       ;move 0Ah into eax - 0Ah is the ascii character for a linefeed
    push eax            ;push the linefeed onto the stack so we can get the address
    mov  eax, esp       ;move the address of the current stack pointer into eax for sprint
    call print_string
    pop  eax            ;remove our linefeed character from the stack
    pop  eax            ;restore the original value of eax before our function was called
    ret

;quit the program succesfully
quit:
    mov     ebx, 0
    mov     eax, SYS_EXIT
    int     80h
    ret