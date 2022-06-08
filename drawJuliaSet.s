        .data
num1:  .word 4000000
num2:  .word 1500 

	    .text
	    .global  drawJuliaSet
	    .type    drawJuliaSet, %function

drawJuliaSet:
	    stmfd	sp!, {r4-r11,lr}	
        sub sp, sp, #28
		mov r4, #0  @x 
		mov r5, #0  @y
		mov r6, r0   
		mov r7, r1  
		mov r8, r2  @r8為width
		mov r9, r3  @r9為height
		
loop1:  cmp r4, r8  @r4為x=0
        bge fin_1   @0>=r8 b fin_1
		mov r5, #0
		
loop2:  cmp r5, r9  @r4為y=0
        bge fin_2   @0>=r9 b fin_2 
        mov r1, r8, asr #1 @r1為(width>>1)
        sub r0, r4, r1  @x - (width>>1)
        ldr r2, =num2   @將數值1500讀入
		ldr r2, [r2]
		mul r0, r0, r2   @1500 * (x - (width>>1))
	    bl  __aeabi_idiv @r0=r0/r1                                                      
		str r0, [sp,#4]  @將zx存入sp+4的位置
        mov r1, r9, asr #1 @r1為(height>>1)
		sub r0, r5, r1   @y - (height>>1)
		mov r2, #1000	 
		mul r0, r0, r2	 @1000 * (y - (height>>1))
	    bl  __aeabi_idiv @r0=r0/r1
		str r0, [sp, #8] @將zy存入sp+8的位置
		mov r0, #255
		str r0, [sp, #12]
		
loop3:  ldr r2, [sp, #4] @zx
        ldr r3, [sp, #8] @zy
		mul r2, r2, r2   @ r2 = zx * zx
        mul r3, r3, r3   @ r3 = zy * zy 
        add r0, r2, r3   @ r0 = zx * zx + zy * zy 	
		ldr r1,=num1 	 
        ldr r1, [r1]     @ r1 = 4000000
		cmp r0, r1		
		bge fin_3		 @r0>=4000000 ,跳出
		ldr r1, [sp,#12] @r1=255
		cmp r1, #0
		ble fin_3		 @r1<=0 ,跳出
		sub r0, r2, r3   @ r0 = zx * zx - zy * zy 
		mov r1, #1000  
		bl  __aeabi_idiv @r0/r1
		add r0, r0, r6
		str r0, [sp,#16] @將tmp存入sp+16
		ldr r2, [sp,#4]  @r2為zx
		ldr r3, [sp,#8]  @r3為zy
		mov r0, #2 
		mul r0, r0, r2 
		mul r0, r0, r3   @r0 = 2 * zx * zy
		mov r1, #1000
		bl  __aeabi_idiv
		add r0, r0, r7   @r0 = (2 * zx * zy)/1000 + cY
		str r0, [sp,#8]  @將r0更新zy
		ldr r0, [sp,#16] 
		str r0, [sp,#4]  @將tmp更新zx
		ldr r0, [sp,#12]
		sub r0, r0, #1   @i--
		str r0, [sp,#12] @i存入sp+12
		b   loop3 
		
fin_3:  ldr r0, [sp,#12]     @r0 = 255
        and r0, r0, #0xFF    @r0 = i&0xFF
		mov r1, r0, asl #8   @r1 = (i&0xFF)<<8
        orr r0, r0, r1       @r0 = ((ix0xFF)<<8) | (i&0xFF)
		mvn r0, r0			 @r0 = (~r0) r0為color
        mov r2, #640 		 
		mul r1, r2, r5   @ r1 = y * 640
		mov r3, #2
		mul r1, r1, r3   @ r1 = y * 640 * 2 
		mul r2, r3, r4   @ r2 = x * 2 
		add r1, r1, r2	 @ r1 = y * 640 * 2 + x * 2
        add r1, r1, #104 @計算該顏色坐標位置
		strh r0, [sp,r1] @frame[y][x] = color
        
		
		add r5, r5, #1   @y++
        b   loop2
		
fin_2:  add r4, r4, #1   @x++
        b   loop1
		

		
fin_1:  add sp, sp, #28
		mov r0, #0
		cmp r0, #5
		movle r0, #5
		addle r0, r0,r0,lsl #2 
		cmple r0, #25
		moveq r0, #0
		subs r0, r14,r13
        ldmfd   sp!, {r4-r11, pc}
        .end

