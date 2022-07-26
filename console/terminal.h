#pragma once
#include "../asm/io.h"
#include "../types.h"

uint16_t GetCaretPos(void) {
	uint16_t pos = 0;
	
    	outb(0x3D4, 0x0F);
   	pos |= inb(0x3D5);
    	outb(0x3D4, 0x0E);
    	pos |= ((uint16_t)inb(0x3D5)) << 8;
    	return pos;
}

void CaretVisiblity(BOOL visible) {
	if(!visible) {
		outb(0x3DA, 0x0A);
		outb(0x3D5, 0x20);
	} else {
		outb(0x3D4, 0x0A);
		outb(0x3D5, (inb(0x3D5) & 0xC0) | 0);
	 
		outb(0x3D4, 0x0B);
		outb(0x3D5, (inb(0x3D5) & 0xE0) | 0);		
	}
}

void MoveCaret(int x, int y) {
	uint16_t pos = y * 80 + x;
	 
	outb(0x3D4, 0x0F);
	outb(0x3D5, (uint8_t) (pos & 0xFF));
	outb(0x3D4, 0x0E);
	outb(0x3D5, (uint8_t) ((pos >> 8) & 0xFF));
}

void ClearScreen() {
	MoveCaret(0, 0);
	asm("mov edi, 0xb8000");
	asm("mov rax, 0x0F000F000F000F00"); 
	asm("mov ecx, 500");
	asm("rep stosq");
}

void printf(const char* str, int colour) {
	volatile char* video = (volatile char*)0xb8000;

	int length = strlen(str);
	for(int i = 0; i < length; i++) {
		*video++ = str[i];
		*video++ = colour;
	}
	
	MoveCaret(length, 0);
}

