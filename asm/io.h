#pragma once
#include "../types.h"

static inline void outb(unsigned short port, unsigned char val) {
	asm volatile("out %1, %0" : : "a"(val), "Nd"(port));
}

static inline uint8_t inb(uint16_t port) {
    uint8_t ret;
    asm volatile ( "inb %0, %1"
                   : "=a"(ret)
                   : "Nd"(port) );
    return ret;
}

static inline void IO_pause(void) {
	outb(0x80, 0);
}
