section	.text
   global _start     ;must be declared for linker (ld)

_start:             ;tell linker entry point
	
   ;write hello world
   mov	edx,12      ;message length
   mov	ecx,hello   ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel
	
   mov	[hello],  dword 'Brav'    ; Change Hello to Brave
   mov	[hello+4],  byte 'e'    ; Change Hello to Brave
	   
   ;write brave world
   mov	edx,12      ;message length
   mov	ecx,hello   ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel
	
   mov	eax,1       ;system call number (sys_exit)
   int	0x80        ;call kernel

section	.data
hello db 'Hello World',0xA