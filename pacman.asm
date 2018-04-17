 bits 16
 org 0x7C00
 
 ; CHS
 cli	
 mov ah , 0x02;take the whole code not only the first 512 bytes
 mov al ,6
 mov dl , 0x80
 mov ch ,0
 mov dh , 0
 mov cl , 2
 mov BX , Start
 INT 0x13
 jmp Start
 	
times (510 - ($ - $$)) db 0
db 0x55, 0xAA

Start:

  	
  section .bss
  
  x_coord   RESW 2 ; [x_coord] is the head, [x_coord+2] is the next cell, etc.
  y_coord   RESW 2 ; Same here 
  ghost1_x  RESW 2
  ghost1_y  RESW 2
  ghost2_x  RESW 2
  ghost2_y  RESW 2
  ghost3_x  RESW 2
  ghost3_y  RESW 2
  ghost4_x  RESW 2
  ghost4_y  RESW 2
  ghost5_x  RESW 2
  ghost5_y  RESW 2
  ghost6_x  RESW 2
  ghost6_y  RESW 2
  temp1     RESB 2
  temp2     RESB 2
  t1        RESB 2
  t2        RESB 2
  t3        RESB 2
  t4        RESB 2
  t5        RESB 2
  t6        RESB 2
  t7        RESB 2
  t8        RESB 2
  t9        RESB 2
  t10       RESB 2
  t11       RESB 2
  t12       RESB 2
  length    RESB 2
  length1   RESB 2
  x_egg     RESB 2
  y_egg     RESB 2
  score     RESB 2
  direction RESB 12
  section  .text
  pressed: dd 0x00;no movment at yhe start
 ;disply starting message
  mov bl ,0011_1011b
  mov bh ,0;page number
  mov dl ,0x18;colomn
  mov dh , 0x09;row
  mov BL, 0x03;attribute
  mov al ,0;update
  mov CX , 23;no. of chars
  push cs
  pop es
  mov bp,  welcome
  mov AH, 0x13 ; Draw mode (text)
  INT 0x10  
  jmp msglend3
  welcome:db "press any key to START",0
 
  msglend3:
   
  mov AH, 0x00 ;
  mov AL, 0x00 ; 
  INT 0x16   ; get key storke from keyboard
  mov byte[direction],0	
  game: 
  	
  mov AX , 0x00
  mov [pressed] ,AX;set default direction for new game
  xor AX,AX	   
  mov AH, 0x00 ; video mode
  mov AL, 0x03 ; text mode 80*25 ,16 colors ,8 pages
  INT 0x10
  CALL ClearScreen
  CALL drawDots
  CALL drawWall
  CALL drawWall2
  CALL drawWall3
  CALL drawWall4
  CALL drawWall5
  CALL drawWall6
  CALL drawWall7
  CALL drawWall8
  CALL SetInitialCoords
  CALL read_input
  ret


 ClearScreen:
  mov dl, 0x00
  msgscreen: db ' ',0
  mov bl , 0x0F
  mov CX ,1
  mov bp , msgscreen
  mov dh, 0x00
  mov AL, 0
  mov AH, 0x13
  x_loop_begin:
   mov dh, 0x00
        
   y_loop_begin:

    INT 0x10
    INC dh
    cmp dh, 25
    JNAE y_loop_begin
   y_loop_end:
   INC dl
   cmp dl, 80
   JNAE x_loop_begin
   RET 
   
  drawWall:;square
  mov dl, 5 ; column
  mov dh, 2 ; row
  loop1:
  inc dh
  CALL draw
  cmp dh, 26
  jl loop1
  
  mov dl, 4
  mov dh, 2
  loop2:
  inc dl
  CALL draw
  cmp dl, 75
  jl loop2
  ret
  
  drawWall2:
  mov dl, 75
  mov dh, 2
  loop3:
  inc dh
  CALL draw
  cmp dh, 24
  jl loop3
  
  mov dl, 4
  mov dh, 24
  loop4:
  inc dl
  CALL draw
  cmp dl, 75
  jl loop4
  ret
  
  draw:
  mov bl , 0x04;red
  mov bh , 0
  mov al ,0
  walling:dd 0xDB
  mov CX ,1
  mov bp, walling
  mov AH, 0x13 ; Draw mode (text)
  INT 0x10         ; Draw
  RET 
  
   drawWall3:;vertical1
  mov dl, 26 ;column
  mov dh, 8 ;row
  
  loop5:
  inc dh
  CALL draw2
  cmp dh, 19
  jl loop5
	
  mov dl, 55
  mov dh, 8
  
  loop6:
  inc dh
  CALL draw2
  cmp dh, 19
  jl loop6
  ret 
  
 drawWall4:;horizontal_11 
 mov dl, 26 ;column
 mov dh, 8 ;row
 loop9:
 inc dl
 CALL draw2
 cmp dl, 40
 jl loop9	
	
 mov dl, 26
 mov dh, 7
  
 loop10:
 inc dh
 CALL draw2
 cmp dh, 19
 jl loop10	
 ret
	
 drawWall5:;horizontal_12 
 mov dl, 55 ;column
 mov dh,8 ;row
 loop7:
 inc dh
 CALL draw2
 cmp dh, 19
 jl loop7	
	
 mov dl, 40
 mov dh, 19
  
 loop8:
 inc dl
 CALL draw2
 cmp dl, 55
 jl loop8	 
 ret

  drawWall6:;vertical2
  mov dl, 15 ;column
  mov dh, 5 ;row
  
  loop5_1:
  inc dh
  CALL draw2
  cmp dh, 22
  jl loop5_1
	
  mov dl, 65
  mov dh, 5
  
  loop6_1:
  inc dh
  CALL draw2
  cmp dh, 22
  jl loop6_1
  ret
   
 drawWall7:;horizontal_21 
 mov dl, 15 ;column
 mov dh, 22 ;row
 loop9_1:
 inc dl
 CALL draw2
 cmp dl, 60
 jl loop9_1	
	
 mov dl, 15
 mov dh, 4
  
 loop10_1:
 inc dh
 CALL draw2
 cmp dh, 22
 jl loop10_1	
 ret
	
 drawWall8:;horizontal_22 
 mov dl, 65 ;column
 mov dh,4 ;row
 loop7_1:
 inc dh
 CALL draw2
 cmp dh, 22
 jl loop7_1	
	
 mov dl, 19
 mov dh, 5
  
 loop8_1:
 inc dl
 CALL draw2
 cmp dl, 65
 jl loop8_1	 
 ret

 draw2:
 mov BL, 0x0c
  
 mov bh , 0
 mov al ,0
 walling2:dd 0xDB
 mov CX ,1
 mov bp, walling2
 mov AH, 0x13 ; Draw mode (text)
 INT 0x10     ; Draw
 ret
 
  drawDots:

 mov dl, 0x06
  msgdot: db '.'
  mov bl , 0x0F
  mov CX ,1
  mov bp , msgdot
  mov dh, 0x00
  mov AL, 0
  mov AH, 0x13
  x_loop_begin_1:
   mov dh, 0x04
        
   y_loop_begin_1:

    INT 0x10
    INC dh
    cmp dh, 25
    JNAE y_loop_begin_1
   y_loop_end_1:
   INC dl
   cmp dl, 74
   JNAE x_loop_begin_1
   RET 
   
 
   SetInitialCoords:
	mov AX, 9 ; Initial x
        mov BX, 11; Initial y
	mov [x_coord], AX
	mov [y_coord], BX       
  
        mov AX, 6
        mov CX, 3
        mov [ghost1_x], AX
	mov [ghost1_y], CX
        
        mov AX, 74
        mov CX, 3
        mov [ghost2_x], AX
	mov [ghost2_y], CX
        
        mov AX, 16
        mov CX, 6
        mov [ghost3_x], AX
	mov [ghost3_y], CX

        mov AX, 64
        mov CX, 6
        mov [ghost4_x], AX
	mov [ghost4_y], CX

        mov AX, 27
        mov CX, 9
        mov [ghost5_x], AX
	mov [ghost5_y], CX

        mov AX, 54
        mov CX, 18
        mov [ghost6_x], AX
	mov [ghost6_y], CX 
        ret


  
  read_input:  ;Repeatedly check for keyboard input
  delay:
  mov eDX ,4511111
  delay_loop:
  dec eDX
  jg delay_loop
     
  mov ah, [pressed]
  check_key:
  in al, 0x64;
  and al, 1;
  cmp al , 0
  jle here
	
  in al, 0x60;
  mov ah , al
  

  cmp al ,[pressed]
  je here
  
  cmp al ,0xC8
  je change_direction
  
  cmp al , 0xCB
  je change_direction
  
  cmp al , 0xCD
  je change_direction
  
  cmp al , 0xD0
  je change_direction
  
  cmp al , 0x00
  je change_direction
  
  jmp check_key 
  
  change_direction:
  mov [pressed], ah;new direction
  
  here:
  
   CALL INTerpretKeypress
   CALL read_input

 INTerpretKeypress:
  mov ah , [pressed]
  cmp ah, 0xC8
  je up_pressed

  cmp ah, 0xCB
  je left_pressed

  cmp ah, 0xD0
  je down_pressed

  cmp ah, 0xCD
  je right_pressed
  
  cmp ah, 0x00;blocked
  je doNothing
  
  RET ;invalid keypress ,start listening again

  up_pressed:
  mov AX, [x_coord]
  mov BX, [y_coord]
  DEC BX
  JMP implement

  left_pressed:
  mov AX, [x_coord]
  mov BX, [y_coord]
  DEC AX
  JMP implement

  down_pressed:
  mov AX, [x_coord]
  mov BX, [y_coord]
  INC BX
  JMP implement
  
  right_pressed:
  mov AX, [x_coord]
  mov BX, [y_coord]
  INC AX
  JMP implement
  
  doNothing:
  mov AX, [x_coord]
  mov BX, [y_coord]
    
  implement:
  mov [temp1], AX
  mov [temp2], BX
  CALL moveGhosts
  CALL ShiftGhosts
  CALL Drawghosts
  CALL CheckWallCollision
  CALL CheckVerticalWallCollision
  CALL CheckVertical1WallCollision
  CALL CheckHorizontalWallCollision
  CALL CheckHorizontal1WallCollision
  CALL CheckGhostsCollision
  CALL ShiftPacman
  CALL DrawPacman
  
  
  RET
  
  
 
  
  
  CheckWallCollision:
  mov CX , [temp1]
  mov BX , [temp2]
  ;square 
  cmp CX , 5
  je collapsed
  
  cmp CX , 75
  je collapsed
  
  cmp BX , 2
  je collapsed
 
  cmp BX , 24
  je collapsed
  ret
  
  CheckVerticalWallCollision:
  mov CX , [temp1]
  mov BX , [temp2]
  cmp CX , 26
  je res1  
  cmp CX , 55
  je res1
  ret
  
  res1:
  cmp BX , 8
  jg res2
  ret
  
  res2:
  cmp BX , 19
  jle collapsed
  ret 
  
  CheckVertical1WallCollision:
  mov CX , [temp1]
  mov BX , [temp2]
  cmp CX , 15
  je res1_1  
  cmp CX , 65
  je res1_1
  ret
  
  res1_1:
  cmp BX , 4
  jg res2_1
  ret
  
  res2_1:
  cmp BX , 22
  jle collapsed
  ret 
  
  CheckHorizontalWallCollision:
  mov CX , [temp1]
  mov BX , [temp2]
  cmp BX , 8
  je res11
  cmp BX , 19
  je res33
  ret
  
  res11:
  cmp CX , 26
  jge res22
  ret
  
  res22:
  cmp CX , 40
  jle collapsed
  ret
  
  res33:
  cmp CX , 40
  jge res44
  ret
  
  res44:
  cmp CX,55
  jle collapsed
  ret
  
  CheckHorizontal1WallCollision:
  mov CX , [temp1]
  mov BX , [temp2]
  cmp BX , 5
  je res11_1
  cmp BX , 22
  je res33_1
  ret
  
  res11_1:
  cmp CX , 18
  jge res22_1
  ret
  
  res22_1:
  cmp CX , 65
  jle collapsed
  ret
  
  res33_1:
  cmp CX , 18
  jge res44_1
  ret
  
  res44_1:
  cmp CX,60
  jle collapsed
  ret
  
  collapsed:
  mov AL, 0x00
  mov [pressed], AL
  jmp check_key
  ret
  

  ShiftPacman:
   
     
   mov dh, [x_coord];old position
   mov dl, [y_coord]
  
   mov [x_coord+2], dh
   mov [y_coord+2], dl
   
   mov dh, [temp1]
   mov [x_coord], dh;new position
   mov dh, [temp2]
   mov [y_coord], dh
   ret
   
   ShiftGhosts:
   mov dh, [ghost1_x];old position
   mov dl, [ghost1_y]
   mov [ghost1_x+2], dh
   mov [ghost1_y+2], dl
   
   mov dh, [t1]
   mov [ghost1_x], dh;new position
   mov dh, [t2]
   mov [ghost1_y], dh
   
   
   mov dh, [ghost2_x];old position
   mov dl, [ghost2_y]
  
   mov [ghost2_x+2], dh
   mov [ghost2_y+2], dl
   
   mov dh, [t3]
   mov [ghost2_x], dh;new position
   mov dh, [t4]
   mov [ghost2_y], dh
   
   
   mov dh, [ghost3_x];old position
   mov dl, [ghost3_y]
  
   mov [ghost3_x+2], dh
   mov [ghost3_y+2], dl
   
   mov dh, [t5]
   mov [ghost3_x], dh;new position
   mov dh, [t6]
   mov [ghost3_y], dh
   
   
   mov dh, [ghost4_x];old position
   mov dl, [ghost4_y]
  
   mov [ghost4_x+2], dh
   mov [ghost4_y+2], dl
   
   mov dh, [t7]
   mov [ghost4_x], dh;new position
   mov dh, [t8]
   mov [ghost4_y], dh
   
   
   mov dh, [ghost5_x];old position
   mov dl, [ghost5_y]
  
   mov [ghost5_x+2], dh
   mov [ghost5_y+2], dl
   
   mov dh, [t9]
   mov [ghost5_x], dh;new position
   mov dh, [t10]
   mov [ghost5_y], dh
   
   
   mov dh, [ghost6_x];old position
   mov dl, [ghost6_y]
  
   mov [ghost6_x+2], dh
   mov [ghost6_y+2], dl
   
   mov dh, [t11]
   mov [ghost6_x], dh;new position
   mov dh, [t12]
   mov [ghost6_y], dh
   RET
  
  
   DrawPacman:
   
   mov dl, [x_coord+2]
   mov dh, [y_coord+2]
   CALL clear
  
   mov dl, [x_coord]
   mov dh, [y_coord]
   mov bl , 0x0E;yellow
   CALL drawthing
   ret
  
  clear:
  mov bl ,0x00
  mov al ,0
  mov CX ,1
  cls:db ' ',0
  mov bp, cls
  mov AH, 0x13 ;Draw mode (text)
  INT 0x10     ;Draw
  xor al ,al
  xor CX ,CX
  RET

  drawthing:
  mov bh , 0
  mov al ,0x00
  msg:dd 0x01
  mov CX ,1
  mov bp, msg
  mov AH, 0x13 ;Draw mode (text)
  INT 0x10     ;Draw
  RET
  
  Drawghosts:
   mov dl, [ghost1_x+2]
   mov dh, [ghost1_y+2]
   CALL clear
   mov dl, [ghost1_x]
   mov dh, [ghost1_y]
   mov bl , 0x01
   CALL drawthing2
   
   mov dl, [ghost2_x+2]
   mov dh, [ghost2_y+2]
   CALL clear
   mov dl, [ghost2_x]
   mov dh, [ghost2_y]
   mov bl , 0x02
   CALL drawthing2
   
   mov dl, [ghost3_x+2]
   mov dh, [ghost3_y+2]
   CALL clear
   mov dl, [ghost3_x]
   mov dh, [ghost3_y]
   mov bl , 0x03
   CALL drawthing2
   
   mov dl, [ghost4_x+2]
   mov dh, [ghost4_y+2]
   CALL clear
   mov dl, [ghost4_x]
   mov dh, [ghost4_y]
   mov bl , 0x05
   CALL drawthing2
   
   mov dl, [ghost5_x+2]
   mov dh, [ghost5_y+2]
   CALL clear
   mov dl, [ghost5_x]
   mov dh, [ghost5_y]
   mov bl , 0x08
   CALL drawthing2
   
   mov dl, [ghost6_x+2]
   mov dh, [ghost6_y+2]
   CALL clear
   mov dl, [ghost6_x]
   mov dh, [ghost6_y]
   mov bl , 0x06
   CALL drawthing2
   ret
  
  drawthing2:
  mov bh , 0
  mov al ,0x00
  msg2:dd 0x04
  mov CX ,1
  mov bp, msg2
  mov AH, 0x13 ;Draw mode (text)
  INT 0x10     ;Draw
  RET
  
  moveGhosts:
  mov AX,[ghost1_x]
  mov CX,[ghost1_y]
  cmp AX,6
  jne a3
  a1:
  cmp CX,3
  jne a2
  mov byte[direction],1
  mov byte[direction+1],0
  a2:
  cmp CX,23
  jne a5
  mov byte[direction],0
  mov byte[direction+1],1
  a3:
  cmp AX,14
  jne a5
  cmp CX,23
  jne a4
  mov byte[direction+1],0
  mov byte[direction],-1
  a4:
  cmp CX,3
  jne a5
  mov byte[direction+1],-1
  mov byte[direction],0
  a5:
  add CX,[direction]
  add AX,[direction+1]
  mov [t2],CX
  mov [t1],AX
  
  
  mov AX,[ghost2_x]
  mov CX,[ghost2_y]
  cmp AX,74
  jne b3
  b1:
  cmp CX,3
  jne b2
  mov byte[direction+2],1
  mov byte[direction+3],0
  b2:
  cmp CX,23
  jne b5
  mov byte[direction+2],0
  mov byte[direction+3],-1
  b3:
  cmp AX,66
  jne b5
  cmp CX,23
  jne b4
  mov byte[direction+3],0
  mov byte[direction+2],-1
  b4:
  cmp CX,3
  jne b5
  mov byte[direction+3],1
  mov byte[direction+2],0
  b5:
  add CX,[direction+2]
  add AX,[direction+3]
  mov [t4],CX
  mov [t3],AX
  
  
  mov AX,[ghost3_x]
  mov CX,[ghost3_y]
  cmp AX,16
  jne c3
  c1:
  cmp CX,6
  jne c2
  mov byte[direction+4],1
  mov byte[direction+5],0
  c2:
  cmp CX,21
  jne c5
  mov byte[direction+4],0
  mov byte[direction+5],1
  c3:
  cmp AX,25
  jne c5
  cmp CX,21
  jne c4
  mov byte[direction+5],0
  mov byte[direction+4],-1
  c4:
  cmp CX,6
  jne c5
  mov byte[direction+5],-1
  mov byte[direction+4],0
  c5:
  add CX,[direction+4]
  add AX,[direction+5]
  mov [t6],CX
  mov [t5],AX
  
  
  mov AX,[ghost4_x]
  mov CX,[ghost4_y]
  cmp AX,64
  jne d3
  d1:
  cmp CX,6
  jne d2
  mov byte[direction+6],1
  mov byte[direction+7],0
  d2:
  cmp CX,21
  jne d5
  mov byte[direction+6],0
  mov byte[direction+7],-1
  d3:
  cmp AX,56
  jne d5
  cmp CX,21
  jne d4
  mov byte[direction+7],0
  mov byte[direction+6],-1
  d4:
  cmp CX,6
  jne d5
  mov byte[direction+7],1
  mov byte[direction+6],0
  d5:
  add CX,[direction+6]
  add AX,[direction+7]
  mov [t8],CX
  mov [t7],AX
  
  
  mov AX,[ghost5_x]
  mov CX,[ghost5_y]
  cmp AX,27
  jne e3
  e1:
  cmp CX,9
  jne e2
  mov byte[direction+8],1
  mov byte[direction+9],0
  e2:
  cmp CX,12
  jne e5
  mov byte[direction+8],0
  mov byte[direction+9],1
  e3:
  cmp AX,54
  jne e5
  cmp CX,12
  jne e4
  mov byte[direction+9],0
  mov byte[direction+8],-1
  e4:
  cmp CX,9
  jne e5
  mov byte[direction+9],-1
  mov byte[direction+8],0
  e5:
  add CX,[direction+8]
  add AX,[direction+9]
  mov [t10],CX
  mov [t9],AX
  
  
  mov AX,[ghost6_x]
  mov CX,[ghost6_y]
  cmp AX,54
 ;cmp CX,18
  jne f3
  f1:
  ;cmp AX,54
  cmp CX,18
  jne f2
  mov byte[direction+10],-1
  mov byte[direction+11],0
  f2:
  ;cmp AX,27
  cmp CX,15
  jne f5
  mov byte[direction+10],0
  mov byte[direction+11],-1
  f3:
  ;cmp CX,14
 cmp AX,27
  jne f5
  ;cmp AX,27
  cmp CX,15
  jne f4
  mov byte[direction+11],0
  mov byte[direction+10],1
  f4:
 cmp CX,18
  ;cmp AX,54
  jne f5
  mov byte[direction+11],1
  mov byte[direction+10],0
  f5:
  add CX,[direction+10]
  add AX,[direction+11]
  mov [t12],CX
  mov [t11],AX
  ret
  
  CheckGhostsCollision:
  mov AX, [temp1]
  mov BX, [temp2]
  cmp AX, [ghost1_x]
  je next
  n1:
  cmp AX, [ghost2_x]
  je next1
  n2:
  cmp AX, [ghost3_x]
  je next2
  n3:
  cmp AX, [ghost4_x]
  je next3
  n4:
  cmp AX, [ghost5_x]
  je next4
  n5:
  cmp AX, [ghost6_x]
  jne no_collision_1
  je next5
  next:
  cmp BX, [ghost1_y]
  je restart
  jne n1
  next1:
  

  cmp BX, [ghost2_y]
  je restart
  jne n2
  next2:
  

  cmp BX, [ghost3_y]
  je restart
  jne n3
  next3:
  

  cmp BX, [ghost4_y]
  je restart
  jne n4
  next4:
  

  cmp BX, [ghost5_y]
  je restart
  jne n5
  next5:
  
  
  cmp BX, [ghost6_y]
  je restart
  
  no_collision_1:
  RET
  
 
  
  restart:
  CALL ClearScreen
  mov bl ,0011_1011b
  mov bh ,0
  mov dl ,0x20
  mov dh , 0x08
  mov BL, 0x0c
  mov al ,0
  mov CX , 11
  push cs
  pop es
  mov bp,  lost
  mov AH, 0x13 ; Draw mode (text)
  INT 0x10  
  jmp msglend 
  lost:db "Game Over!",0
  msglend:
  lost1:
  delay1:
  mov eDX ,99999999
  delay_loop1:
  dec eDX
  jg delay_loop1

  CALL ClearScreen
  mov bl ,0011_1011b
  mov bh ,0
  mov dl ,0x18
  mov dh , 0x06
  mov BL, 0x0c
  mov al ,1
  mov CX , 25
  push cs
  pop es
  mov bp,  lost2
  mov AH, 0x13 ; Draw mode (text)
  INT 0x10  
  jmp msglend2 
  
  lost2:db "press any key to restart",0
  msglend2: 
  
  mov AH, 0x00 ;
  mov AL, 0x00 ; 
  INT 0x16   ; 
     
  cmp al , 0x72 
  je poINT
  poINT: 
  CALL game
   

times (0x400000 - 512) db 0

db 	0x63, 0x6F, 0x6E, 0x65, 0x63, 0x74, 0x69, 0x78, 0x00, 0x00, 0x00, 0x02
db	0x00, 0x01, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
db	0x20, 0x72, 0x5D, 0x33, 0x76, 0x62, 0x6F, 0x78, 0x00, 0x05, 0x00, 0x00
db	0x57, 0x69, 0x32, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x78, 0x04, 0x11
db	0x00, 0x00, 0x00, 0x02, 0xFF, 0xFF, 0xE6, 0xB9, 0x49, 0x44, 0x4E, 0x1C
db	0x50, 0xC9, 0xBD, 0x45, 0x83, 0xC5, 0xCE, 0xC1, 0xB7, 0x2A, 0xE0, 0xF2
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00