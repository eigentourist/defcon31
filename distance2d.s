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
      ldp d0, d1, [x0], #16     // Load 64-bit floating-point registers d0, d1
                                // from the memory address stored in x0
      ldp d2, d3, [x0]          // We just incremented x0 by 16 bytes above,
                                // so now we can load two more 64-bit float registers
      fsub d4, d2, d0           // Now let's begin by getting the difference between
                                // the two X coordinates of the 2D points given.
      fsub d5, d3, d1           // Do the same here for the Y coordinates - now
                                // we have the ingredients for calculating distance
      fmul d4, d4, d4           // First, let's square the difference of X coordinates
      fmul d5, d5, d5           // Now we square the difference of Y coordinates
      fadd d4, d4, d5           // Then, add the two squared differences together
      fsqrt d4, d4              // Finally, let's get the square root of that sum
      fmov x0, d4               // And move the result over to the 64-bit x0 register
      ldr x1, =result           // Load address of result variable
      str x0, [x1]              // Store the result
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
coordinates:   .double    0.0, 10.0, 20.0, 30.0
message:       .asciz     "Distance: %10.6lf\n"
result:        .double    0.1

