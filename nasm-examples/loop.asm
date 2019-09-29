;print 10 stars (*) in a loop

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data 
   msg db "*", 0xA
   msgLen equ $ - msg

section	.text
    global _start
	
_start:    
    mov ecx,10	
l1:
    push ecx
    mov eax, SYS_WRITE         
    mov ebx, STDOUT         
    mov ecx, msg
    mov edx, msgLen
    int 0x80
    pop ecx
    loop l1

exit:  
    mov eax, SYS_EXIT
    int 0x80

;$ ./loop.out 
;*
;*
;*
;*
;*
;*
;*
;*
;*
;*
