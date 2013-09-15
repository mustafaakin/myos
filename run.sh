# Clean
rm -f kernel *.o 

# Assemble
nasm -f elf start.asm -o start.o

# Compile
gcc -Wall -nostdlib -ffreestanding -fno-stack-protector -O0 -fomit-frame-pointer -m32 -c main.c -o main.o

# Link
ld -T linker.ld -nostdlib -n -melf_i386 start.o main.o -o kernel

# Run the virtual machine under qemu
qemu -m 32m -kernel kernel 