;constants
SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data 
   lessThanFiveMsg db "Number is less than five",0xA
   lessThanFiveMsgLen equ $ - lessThanFiveMsg

   fiveOrGreaterMsg db "Number is five or greater",0xA
   fiveOrGreaterMsgLen equ $ - fiveOrGreaterMsg

section	.text
   global _start
	
_start: 
   mov eax, 1
   mov ebx, 5
   cmp eax, ebx
   jl less_than_five 

five_or_greater:
   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, fiveOrGreaterMsg
   mov edx, fiveOrGreaterMsgLen
   int 0x80
   jmp exit
   
less_than_five:
   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, lessThanFiveMsg
   mov edx, lessThanFiveMsgLen
   int 0x80

exit:  
   mov eax, SYS_EXIT   
   xor ebx, ebx 
   int 0x80