%include 'functions.asm'
 
SECTION .data
filename db 'README.md', 0h ;the filename to open
 
SECTION .bss
fileContents resb 1024,      ;variable to store file contents
 
SECTION .text
global  _start
 
_start: 
    mov     ecx, O_RDONLY
    mov     ebx, filename
    mov     eax, SYS_OPEN
    int     80h
 
    mov     edx, 1024           ;number of bytes to read
    mov     ecx, fileContents
    mov     ebx, eax            ;move the opened file descriptor
    mov     eax, SYS_READ
    int     80h
 
    mov     eax, fileContents   ;move the memory address of file contents variable into eax for printing
    call    print_string_LF
 
    call    quit