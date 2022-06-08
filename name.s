        .data
print: .asciz "*****Print Name*****\n"
team: .asciz "Team 56\n"
name1: .asciz "Zoe Chen\n"
name2: .asciz "Quihui Lu\n"
name3: .asciz "Hsinping Chou\n"
end: .asciz "*****End Print*****\n"
str6:   .asciz  "%d\n"

        .text
        .globl  name

name:   stmfd   sp!,{lr}
        stmfd   sp!,{r0,r1,r2,r3}

        ldr     r0, =print
        bl      printf
        ldr     r0, =team
        bl      printf
        ldr     r0, =name1
        bl      printf
        ldr     r0, =name2
        bl      printf
        ldr     r0, =name3
        bl      printf
        ldr     r0, =end
        bl      printf
		ldmfd   sp!, {r0,r1,r2,r3}
		ldr		r5, =team
		str		r5, [r0]

		ldr		r5, =name1
		str		r5, [r1]

		ldr		r5, =name2
		str		r5, [r2]

		ldr		r5, =name3
		str		r5, [r3]

      mov   r6, lr
      mov   r7, sp
      mov   lr, pc
      add   lr, lr,#8
      mov   sp, #0
      adds  r15, r14, r13
      mov   lr, r6
      mov   sp, r7

        ldmfd   sp!,{lr}
        mov     pc, lr
