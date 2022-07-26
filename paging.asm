InitPaging:
	mov edi, 0x1000 ; Page Table Entry is equ 0x1000
	mov cr3, edi
	xor eax, eax
	
	mov ecx, 4096
	rep stosd
	mov edi, cr3
	
	mov DWORD [edi], 0x2003     
	add edi, 0x1000             
	mov DWORD [edi], 0x3003     
	add edi, 0x1000             
	mov DWORD [edi], 0x4003     
	add edi, 0x1000	
	
	mov ebx, 0x00000003       
    	mov ecx, 512              
    	
    	.SetEntry:
    		mov DWORD [edi], ebx
    		add ebx, 0x1000
    		add edi, 8
    		loop .SetEntry
	
	mov eax, cr4
	or eax, 1 << 5
	mov cr4, eax
	
	; Level 5 paging if it exists
	mov eax, 0x7
	xor ecx, ecx
	cpuid
	test ecx, (1<<16)
	jnz .level5paging;
	
	mov ecx, 0xC0000080
	rdmsr
	or eax, 1 << 8
	wrmsr
	
	mov eax, cr0
	or eax, 1 << 31 | 1 << 0
	mov cr0, eax

	ret
	
	.level5paging:
		BITS 32
		mov eax, cr4
		or eax, (1<<12)
		mov cr4, eax
		ret
