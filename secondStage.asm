; I should really rename this file to kernelLoader.asm but im lazy.

[bits 16]
mov ah, 0x0e
mov al, 'K' ; signify that the kernel loader was loaded into memory.
int 0x10

; enter protected mode
; enable A20
in al, 0x92
or ax, 2
out 0x92, al

cli
lgdt [GDT_Descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax

jmp CODE_SEG:ProtectedMode ; make the jump to protected mode
jmp $ ; Should never end up here

%include "gdt32.asm"

; gdt64 source file will switch to 32 then to 16. 
%include "gdt64.asm"

[bits 32]
ProtectedMode:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ebp, 0x90000
	mov esp, ebp
	
	call CPUIDExists
	call LongModeAvaliable
	call InitPaging

	lgdt [GDT_Descriptor64]
	jmp CODE_SEG64:Longland

	jmp $ 

%include "CheckCPU.asm"
%include "paging.asm"

[bits 64]
[extern _start]

Longland:
	mov ax, DATA_SEG64
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	
	mov edi, 0xb8000
	mov rax, 0x1F201F201F201F20 
	mov ecx, 500
	rep stosq

	call _start
	
	mov edi, 0xb8000 ; Maybe a feature like "It is now safe to turn off your computer." one of those one features in windows.
	mov rax, 0x4400440044004400 
	mov ecx, 500
	rep stosq
	
	jmp $
times 2048-($-$$) db 0
