CC = gcc
AS = nasm
LD = ld

CFLAGS= -Wall -nostdlib -ffreestanding -fno-stack-protector -O0 -fomit-frame-pointer -m32

all: link

compile: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

assemble: start.asm
	nasm -f elf start.asm -o start.o

link: compile assemble linker.ld
	$(LD) -T linker.ld -nostdlib -n -melf_i386 start.o main.o -o kernel

run: kernel
	qemu -m 32m -kernel kernel

clean:	
	rm -f *.o kernel