.section .data
hello_msg:
    .asciz "Hello World!"

.section .text
.global _start

.extern initscr, printw, refresh, getch, endwin

_start:
    // Set up the stack frame
    mov x29, sp
    // Initialize the ncurses library
    bl initscr
    // Print "Hello World!" using printw
    ldr x0, =hello_msg
    bl printw
    // Refresh the screen
    bl refresh
    // Wait for user input
    bl getch
    // Clean up and exit
    bl endwin
    mov x8, #93
    mov x0, #0
    svc #0

