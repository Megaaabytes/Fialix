#pragma once
#include "../types.h"

void* memset(void *s, int c, size_t len) {
	unsigned char* _s = (unsigned char*)s;

	while(len--)
	{
		*_s++ = (unsigned char)c;
	}
}

void* memcpy(void* dest, const void* str, size_t n) {	
	unsigned char* _dest = (unsigned char*)dest;
	unsigned char* _str = (unsigned char*)str;

	for(size_t i = 0; i < n; i++) {
		_dest[i] = _str[i];
	}
}
