.arch armv8-a

.global _start

.text
_start:
    // Load the value of the CPU register you want to print into x5
    // For example, if you want to print the value of register x1, load it into x5
    mov x5, #65535

    // Call the function to print the binary representation
    bl print_binary

    // Print newline
    ldr x1, =eol        // newline is simply a linefeed (ascii code 10) in Linux
    mov x8, #64         // syscall number for write
    mov x0, #1          // file descriptor for stdout
    mov x2, #1          // number of characters to print -- just one in this case
    svc 0 

    // Exit the program
    mov x8, #93         // syscall number for exit
    mov x0, #0          // exit code 0
    svc 0

print_binary:
    // Function to print the binary representation of x0 register
    // x0: the register value to print
    mov x3, #63         // Bit counter starting from bit 63

print_loop:
    lsr x2, x5, x3     // Shift the value right by x3 bits and store the result in x2
    and x2, x2, #1     // Extract the least significant bit into x2
    add x2, x2, #'0'   // Convert the bit to ASCII '0' or '1'
    ldr x4, =bit       // Load address of output character buffer
    str x2, [x4]       // Store result of shift / mask / convert above
    mov x8, #64        // syscall number for write
    mov x0, #1         // file descriptor 1 (stdout)
    ldr x1, =bit       // the character to print
    mov x2, #1         // number of bytes to write (1 character)
    svc 0

    // Decrement the bit counter and check if we have printed all 64 bits
    subs x3, x3, #1
    bpl print_loop

    ret

.data
eol:  .ascii "\n"

.bss
bit:  .space 8

