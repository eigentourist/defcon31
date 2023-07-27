// Print "Hello World!" to stdout.
// X0-X2: parameters to linux function services
// X8: linux function number

.text

// Global label to provide a starting address for the linker
.global _start

// Set up parameters
_start:    mov x0, #1                   // 1 = stdout
           ldr x1, =msg                 // Pointer to string
           mov x2, #14                  // Length of string
           mov x8, #64                  // Linux write system call
           svc 0                        // Call Linux to print

// Set up parameters to exit the program and then call Linux to do it.
           mov x0, #0                   // Use 0 return code
           mov x8, #93                  // Code 93 terminates the program
           svc 0                        // Call Linux to terminate

.data
msg:       .ascii "Hello, World!\n"
