        .data
n:      .asciz  "\n\n"
str0:   .asciz  "%d"
str1:   .asciz  "%d\n"
str2:   .asciz  "*****Input ID*****\n"
str3:   .asciz  "**Please Enter Member 1 ID:**\n"
str4:   .asciz  "**Please Enter Member 2 ID:**\n"
str5:   .asciz  "**Please Enter Member 3 ID:**\n"
str6:   .asciz  "**Please Enter Command**\n"
str7:   .asciz  "*****Print Team Member ID and ID Summation*****\n"
str8:   .asciz  "ID Summation = %d\n"
str9:   .asciz  "*****End Print*****\n"
char:   .asciz  "%s"
id1:    .word   56
id2:    .word   0
id3:    .word   0
cmd:    .word   0

        .text
        .globl  id
id:     stmfd   sp!, {lr}
        stmfd   sp!, {r0-r3}


        ldr     r0, =str2
        bl      printf

        ldr     r0, =str3
        bl      printf
        ldr     r0, =str0
        ldr     r1, =id1              @CE1
        bl      scanf

        ldr     r0, =str4             @CE2
        bl      printf
        ldr     r0, =str0
        ldr     r1, =id2
        bl      scanf

        ldr     r0, =str5             @CE3
        bl      printf
        ldr     r0, =str0
        ldr     r1, =id3
        bl      scanf

        ldr     r0, =str6
        bl      printf

        ldr     r0, =char
        ldr     r1, =cmd
        bl      scanf
        ldr     r0, =cmd
        ldr     r0, [r0]
        cmp     r0, #112

        ldr     r0, =str7
        bleq    printf
        ldr     r0, =str1
        ldr     r1, =id1
        ldr     r1, [r1]
        mov     r4, r1

        bleq    printf
        ldr     r0, =str1
        ldr     r1, =id2
        ldr     r1, [r1]
        add     r4, r4, r1
        bleq    printf
        ldr     r0, =str1
        ldr     r1, =id3
        ldr     r1, [r1]
        add     r4, r4, r1
        bleq    printf
        ldr     r0, =n
        bleq    printf
        ldr     r0, =str8
        mov     r1, r4

        bleq    printf
        ldr     r0, =str9
        bleq    printf
        ldmfd   sp!,{r0-r3}

        mov     r5, r4
		str     r5, [r0]

		ldr		r5, =id1
		ldr     r5, [r5]
		str		r5, [r1]

		ldr		r5, =id2
		ldr     r5, [r5]
		str		r5, [r2]

		ldr		r5, =id3
		ldr     r5, [r5]
		str		r5, [r3]

		mov     r0, r4

        ldmfd   sp!,{lr}
        mov     pc, lr
