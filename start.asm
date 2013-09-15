BITS 32
EXTERN main
GLOBAL start

SECTION .grub_sig
signature:
 	MAGIC equ 0x1BADB002
    FLAGS equ 0
    dd MAGIC, FLAGS, -(MAGIC+FLAGS)

SECTION .text
start:
    mov esp, _sys_stack     ; End of stack area
    call main
    jmp $                   ; Infinite loop

SECTION .bss
    resb 16384              ; reserve 16384 bytes for stack
_sys_stack:                 ; end of stack