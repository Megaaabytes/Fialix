	rm -d -rf build
	mkdir build
	nasm -fbin bootloader.asm -o build/bootloader.bin
	# nasm -fbin nullbytes.asm -o build/nullbytes.bin
	nasm -f elf64 secondStage.asm -o build/secondStage.o
	$GCC64/x86_64-elf-gcc -masm=intel -ffreestanding -mno-red-zone -m64 -c kernel.c -o build/kernel.o
	$GCC64/x86_64-elf-ld -o build/kernel.bin -Ttext 0x7e00 build/secondStage.o build/kernel.o --oformat binary
	cat build/bootloader.bin build/kernel.bin > build/OS.bin 
	# cat build/OS.bin build/nullbytes.bin > build/OS.bin
	dd if=/dev/zero of=build/boot.iso bs=512 count=1440
	dd if=build/bootloader.bin of=build/boot.iso conv=notrunc bs=512 seek=0 count=1
	dd if=build/kernel.bin of=build/boot.iso conv=notrunc bs=512 seek=1 count=2048
