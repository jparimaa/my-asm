;constants
SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data 

   msg1 db "Enter a digit ",0xA
   len1 equ $ - msg1 ;$ refers to previous string

   msg2 db "Please enter a second digit",0xA
   len2 equ $ - msg2 

   msg3 db "The sum is: "
   len3 equ $ - msg3

segment .bss
   ;reserve bytes for numbers and results
   num1 resb 2 
   num2 resb 2 
   res resb 1

section	.text
   global _start    ;must be declared for using gcc
	
_start: 
   ;ask for the first number
   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg1         
   mov edx, len1 
   int 0x80                

   ;read for the first number
   mov eax, SYS_READ 
   mov ebx, STDIN  
   mov ecx, num1 
   mov edx, 2
   int 0x80            

   ;ask for the second number
   mov eax, SYS_WRITE        
   mov ebx, STDOUT         
   mov ecx, msg2          
   mov edx, len2         
   int 0x80

   ;read for the second number
   mov eax, SYS_READ  
   mov ebx, STDIN  
   mov ecx, num2 
   mov edx, 2
   int 0x80        

   ;print the result text
   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg3          
   mov edx, len3         
   int 0x80

   mov eax, [num1]
   sub eax, '0' ;subtracting ascii '0' to convert it into a decimal number
	
   mov ebx, [num2]
   sub ebx, '0' ;subtracting ascii '0' to convert it into a decimal number

   add eax, ebx ;sum the two numbers   
   add eax, '0' ;add '0' to to convert the sum from decimal to ASCII
   
   mov [res], eax ;storing the sum in memory location res
   
   ;print the sum
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 1
   int 0x80

exit:  
   mov eax, SYS_EXIT   
   xor ebx, ebx 
   int 0x80