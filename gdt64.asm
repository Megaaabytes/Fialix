[bits 32]
CODE_SEG64 equ code_descriptor64 - GDT64_Start
DATA_SEG64 equ data_descriptor64 - GDT64_Start

GDT64_Start:
	null_descriptor64:
		dd 0x0
		dd 0x0
	code_descriptor64:
		dw 0xffff
		dw 0x0
		db 0x0
		db 0b10011010
		db 0b10101111
		db 0x0
	data_descriptor64:
		dw 0xffff
		dw 0x0

		db 0x0
		db 0b10010010
		db 0b10101111
		db 0x0

GDT64_End:

GDT_Descriptor64:
	dw GDT64_End - GDT64_Start - 1
	dq GDT64_Start
[bits 16]
