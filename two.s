.arch armv8-a   // Raspberry Pi 3b has ARM Cortex-A53
                // Cortex-A64 implements ARMv8-A architecture
                // and supports 64-bit address space
                // and 64-bit data bus

.extern printf

.data
    // Try changing this number to see how the two's complement formula
    // works. The program will show you the unsigned (two's complement)
    // number that the negative number translates to. Or, in more mathematical
    // terms, the two's complement value of any number a is 2^n - a, where n
    // is the number of bits in the integer. Here, n is 64, because we are
    // working with the full width of the 64-bit registers of the processor.
    integer: .quad -16
    // An easier way to think about it is that 

.text

.global _start
_start:
    // Print intro message
    ldr x0, =msg
    bl printf

    // Load the value of the CPU register you want to print into x5
    // For example, if you want to print the value of register x1, load it into x5
    ldr x0, =integer
    ldr x5, [x0]

    // Call the function to print the binary representation
    // Be careful about the order in which you call these functions
    bl print_binary
    bl print_newline
    bl print_signed
    bl print_unsigned

    // Exit the program
    mov x8, #93         // syscall number for exit
    mov x0, #0          // exit code 0
    svc 0

print_newline:
    ldr x1, =eol        // newline is simply a linefeed (ascii code 10) in Linux
    mov x8, #64         // syscall number for write
    mov x0, #1          // file descriptor for stdout
    mov x2, #1          // number of characters to print -- just one in this case
    svc 0
    ret

print_signed:
    ldr x0, =signed_int_str
    ldr x2, =integer
    ldr x1, [x2]
    str lr, [sp, #-16]! // push link register so we can return
    bl printf           // call printf function
    ldr lr, [sp], #16   // pop link register value so we can return
    ret

print_unsigned:
    ldr x0, =unsigned_int_str
    ldr x2, =integer
    ldr x1, [x2]
    str lr, [sp, #-16]! // push link register
    bl printf
    ldr lr, [sp], #16   // pop link register
    ret

print_binary:
    // Function to print the binary representation of x5 register
    // x5: the register value to print
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
    bpl print_loop     // Still more bits to print, so loop again

    ret                // All done printing, so return

.data
msg:  .asciz "The negative representation of a number A in two's complement is\nan unsigned number B which, when A is added to it, equals zero.\n\n"
eol:  .ascii "\n"
signed_int_str:   .asciz "Signed value: %d\n"
unsigned_int_str: .asciz "Unsigned value: %u\n"

.bss
bit:  .space 8

