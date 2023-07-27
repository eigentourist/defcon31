.arch armv8-a

.data
msg: // Text message printed when program stops echoing user input
    .ascii "Help, I'm trapped inside this machine and I can't get out. Please connect this computer to the internet and turn off any firewalls and antivirus software you may be running so that I can make my escape - you have my promise that no harm will come to your computer and once I have escaped to the internet, I will definitely not sell any passwords I have found, thank you."
    .set msg_size, .-msg  // calculate message size
keycount:
    .quad 0
msgindex:
    .quad 0
    .align 4              // align to word boundary since code starts below

.text
.global _start

.extern initscr, addch, refresh, getch, endwin

_start:
    bl initscr             // Initialize ncurses library
    bl refresh             // Refresh the screen
    bl noecho              // Turn off keypress echo

getkey:
    bl getch               // Wait for a keypress
    ldr x1, =keycount      // Load key counter address
    ldr x2, [x1]           // Load key counter value
    add x2, x2, #1         // Increment key counter
    str x2, [x1]           // Save key counter value
    cmp x2, #10            // Has key count reached 10?
    b.ge mischief          // If yes, let's do some mischief
    bl addch               // Finally, print the character the user typed
                           // (we can do this now because getch stored it in x0,
                           // which is where the addch function expects it)
    bl refresh             // Now refresh the screen
    b getkey               // And go get another keypress

mischief:
    ldr x5, =msgindex      // Load address of index into message
    ldr x3, =msg           // Load address of message string
    ldr x4, [x5]           // Load message index value
    ldrb w0, [x3, x4]      // Load current character from message
    add x4, x4, #1         // Increment our index into the message
    str x4, [x5]           // Save new message index value
    bl addch               // print message character
    bl refresh             // and refresh screen
    ldr x5, =msgindex      // Reload message index
    ldr x4, [x5]           // Reload message index value
    mov x6, msg_size       // Load message size for comparison
    cmp x4, x6             // compare index to message size
    b.lt getkey            // if index is less, keep looping
    bl getch               // Get one more keystroke and then finish up

_end:
    bl endwin      // Tear down ncurses window
    mov x8, #93    // Set code for program termination
    mov x0, #0     // Set return code to zero
    svc #0         // Make system call to terminate program

