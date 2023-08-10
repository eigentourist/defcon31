.arch armv8-a

// Adapted from Programming with 64-Bit ARM Assembly Language
// by Stephen Smith (Apress, 2020)
// 
// This program calculates the distance between two 2D points.
// The formula for 2D distance is sqrt( (y2-y1)^2 + (x2-x1)^2 )
// We will apply this formula step by step below.

.extern printf

.align 4
.text

distance:
      ldp q2, q3, [x0]          // Load 128-bit floating-point registers q2, q3
      fsub v1.4s, v2.4s, v3.4s  // Get the differences between the coordinates into v1
      fmul v1.4s, v1.4s, v1.4s  // Square the differences
      faddp v0.4s, v1.4s, v1.4s // Sum the squares and store in v0
      faddp v0.4s, v0.4s, v0.4s // This needs more explanation
      fsqrt s4, s0              // Get square root of the sum - this also needs more explanation
      fcvt d0, s4               // Convert single-precision value to double-precision
      ldr x0, =result           // Load the address of the local variable we want to use
      str d0, [x0]              // Save the distance value into the variable
      ret                       // and return control to our caller


// Main program that calls distance subroutine above
.global _start
_start:
      ldr x0, =coordinates        // Load the starting address of our coordinates
      bl distance                 // Call the distance function above
      ldr x0, =message            // Load x0 with address of printf message
      ldr x2, =result             // Load address of distance result
      ldr d0, [x2]                // Load result value
      str lr, [sp, #-16]!         // Push link register onto the stack
      bl printf                   // Call printf to print computed distance
      ldr lr, [sp], #16           // Pop link register back off stack
      mov x0, #0                  // load x0 with success return code (0)
      mov x8, #93                 // syscall number for exit program
      svc #0

.data
coordinates:   .single    0.0, 0.0, 0.0, 0.0, 17.0, 4.0, 2.0, 1.0
message:       .asciz     "Distance: %16.8lf\n"
result:        .double    0.0

