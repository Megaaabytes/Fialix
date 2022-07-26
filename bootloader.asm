; this code uses 61 bytes of the bootloaders space, leaving me only
; 451 bytes left for style.

[org 0x7c00]
mov [BOOT_DISK], dl

mov bp, 0x7c00
mov sp, bp

; Disk
mov ah, 0x0e
mov al, 'D'
int 0x10

; Load
mov al, 'L'
int 0x10

mov ah, 0x02
mov bx, KERNEL_LOADER
mov al, 6 ; change to 20 later
mov dl, [BOOT_DISK]
mov ch, 0x00
mov dh, 0x00
mov cl, 0x02
int 0x13
jc LoadFailure

; Print s to indicate load succeed.
mov ah, 0x0e
mov al, 'S'
int 0x10
jmp KERNEL_LOADER ; begin loading the kernel.
jmp $ ; this shouldn't be called.

LoadFailure:
	mov ah, 0x0e
	mov al, 'F'
	int 0x10
	jmp $

KERNEL_LOADER equ 0x7e00
BOOT_DISK: db 1
times 510-($-$$) db 0
dw 0xaa55
