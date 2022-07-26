NoLongMode:
	mov ebx, 0xb8000
	mov al, 'N'
	mov ah, 0x40
	mov [ebx], ax
		
	mov ebx, 0xb8002
	mov al, 'o'
	mov [ebx], ax
		
	mov ebx, 0xb8004
	mov al, ''
	mov ah, 0x40
	mov [ebx], ax	

	mov ebx, 0xb8006
	mov al, 'l'
	mov [ebx], ax
		
	mov ebx, 0xb8008
	mov al, 'o'
	mov [ebx], ax
		
	mov ebx, 0xb800A
	mov al, 'n'
	mov [ebx], ax

	mov ebx, 0xb800C
	mov al, 'g'
	mov [ebx], ax				
	jmp $

LongModeAvaliable:
	mov eax, 0x80000000
	cpuid
	cmp eax, 0x80000001
	jb NoLongMode

	mov eax, 0x80000001
	cpuid
	test edx, 1 << 29
	jz NoLongMode
	ret

CPUIDExists:
	pushfd
	pop eax
	mov ecx, eax
	xor eax, 1 << 21
	push eax
	popfd
	pushfd
	pop eax
	push ecx
	popfd
	xor eax, ecx
	jz NoLongMode
	ret
