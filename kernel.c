#include "console/colours.h"
#include "string/string.h"
#include "console/terminal.h"

extern void _start() {
	ClearScreen();
	MoveCaret(0, 0);
	
	int colour = 1;
	while(1) {
		if(colour == 15)
			colour = 1;
			
		printf("Hello World!", colour);
		colour++;
	}
	
	return;
}
