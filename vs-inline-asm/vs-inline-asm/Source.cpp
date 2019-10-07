#include <cstdio>

char printFormat2[] = "%s\n";

void printString(char string[])
{
	__asm
	{
		mov eax, string
		push eax
		mov eax, offset printFormat2
		push eax
		call printf
		pop ebx
		pop ebx
	}
}

int main()
{
	char str[] = "Hell oh world";
	printString(str);
	return 0;
}
