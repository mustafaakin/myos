RESTORE=\033[0m

RED=\033[00;31m
GREEN=\033[00;32m
YELLOW=\033[00;33m
BLUE=\033[00;34m
PURPLE=\033[00;35m
CYAN=\033[00;36m


SHELL = bash
CC = gcc
AS = nasm
LD = ld
QEMU = qemu-system-i386

CFLAGS= -Wall -nostdlib -ffreestanding -fno-stack-protector -O0 -fomit-frame-pointer -m32

OBJS = \
	start.o\
	main.o\


all: link

compile: main.c
	@echo -e "${RED}Compiling ${RESTORE}"
	$(CC) $(CFLAGS) -c main.c -o main.o
	@echo ""
	
assemble: start.asm
	@echo -e "${GREEN}Assembling${RESTORE}"
	nasm -f elf start.asm -o start.o
	@echo ""

link: compile assemble linker.ld
	@echo -e "${YELLOW}Linking compiled objects into single kernel binary${RESTORE}"
	$(LD) -T linker.ld -nostdlib -n -melf_i386 $(OBJS) -o kernel
	@echo ""

run: all
	@echo -e "${PURPLE}Running MyOS under QEMU${RESTORE}"
	$(QEMU) -m 32m -kernel kernel
	@echo ""

clean:	
	@echo -e "${CYAN}Cleaning the compiled files and the kernel${RESTORE}"
	rm -f *.o kernel
	@echo ""
