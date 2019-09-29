;write 'Hello World!' to a file

%include 'functions.asm'
 
SECTION .data
filename db 'readme.txt', 0h
contents db 'Hello world!', 0h
 
SECTION .text
global  _start
 
_start: 
    mov     ecx, 0777      ;file permissions
    mov     ebx, filename
    mov     eax, SYS_CREAT
    int     80h
 
    mov     edx, 12        ;number of bytes to write
    mov     ecx, contents  ;move the memory address of our contents string into ecx
    mov     ebx, eax       ;move the file descriptor of the file we created into ebx
    mov     eax, SYS_WRITE
    int     80h           
 
    call    quit          

;$ ./write_file.out && cat readme.txt 
;Hello world!