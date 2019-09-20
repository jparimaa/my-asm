SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

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
  
;quit the program succesfully
quit:
    mov     ebx, 0
    mov     eax, SYS_EXIT
    int     80h
    ret