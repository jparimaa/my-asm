section .data
msg1 db "The result is " 
len1 equ $- msg1
msg2 db " with remainder " 
len2 equ $- msg2

segment .bss
quotient resb 1
remainder resb 1

section	.text
   global _start    ;must be declared for using gcc
	
_start:             ;tell linker entry point
   mov	ax,'9'      ;the divident must be ax or other respective register
   sub  ax,'0'      ;convert to number
	
   mov 	bl,'2'      ;the divisor shall be in bl
   sub  bl,'0'      ;convert to number
   div 	bl          ;actual division, quotient shall be in al and remainder in ah
   add	al,'0'      ;convert to ascii	
   add	ah,'0'      ;convert to ascii	
   mov 	[quotient], al
   mov 	[remainder], ah

   mov	ecx,msg1	
   mov	edx,len1
   mov	ebx,1	;file descriptor (stdout)
   mov	eax,4	;system call number (sys_write)
   int	0x80	;call kernel
	
   mov	ecx,quotient
   mov	edx,1
   mov	ebx,1	;file descriptor (stdout)
   mov	eax,4	;system call number (sys_write)
   int	0x80	;call kernel

   mov	ecx,msg2	
   mov	edx,len2
   mov	ebx,1	;file descriptor (stdout)
   mov	eax,4	;system call number (sys_write)
   int	0x80	;call kernel

   mov	ecx,remainder
   mov	edx,1
   mov	ebx,1	;file descriptor (stdout)
   mov	eax,4	;system call number (sys_write)
   int	0x80	;call kernel
	
   mov	eax,1	;system call number (sys_exit)
   int	0x80	;call kernel
	