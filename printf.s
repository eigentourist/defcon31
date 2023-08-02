// ARM64 assembly code to invoke printf function directly

// Define printf function prototype
.extern printf

.text
.align 2

.global _start
_start:
    // Prepare the message to be printed
    adr x0, message

    // Call printf
    bl printf

    // Exit the program
    mov x0, #0
    mov x8, #93  // syscall number for exit
    svc #0

.data
message:
    .asciz "Hello, ARM64 assembly with printf!\n"

