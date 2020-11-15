.text
j main

addtoque:
    addi $r28, $r28, 1 # sp1
    sw $r29, 0($r28)
    addi $r15, $r0, 1 #####
    sw $r15, 50($r29) #####
    jr $r31

main:
    addi $r1, $r0, 1
checkPressedloop:
    addi $r10, $r0, 10
    addi $r31, $r31, 1000 # cko $r2
    add $r0, $r0, $r0
    bne $r1, $r2, 1 # beq | pressed, start subroutine
    j checkPressedloop
startFlip:
    addi $r31, $r31, 2000 # clrpr
    addi $r31, $r31, 3000 # bid $r3
    add $r0, $r0, $r0
    lw $r4, 0($r3)
    bne $r4, $r10, 1 #beq | bomb if eq
    j continue
infLoop:
    addi $r9, $r0, 9
    sw $r9, 0($r3)
    blt $r0, $r1, -1
continue:
    add $r29, $r3, $r0

openBlock:
    addi $r27, $r0, 30 # 27 is sp0
    addi $r28, $r0, 30 # 28 is sp1

    addi $r31, $r31, 4000 # nck
    add $r0, $r0, $r0
    lw $r6, 0($r29)
    bne $r0, $r6, 1
    j endque
    jal addtoque
initialque:
    bne $r27, $r28, 1
    j continueQue
    j endque
continueQue:
    lw $r29, 0($r28)
    addi $r28, $r28, -1
    #check left
    addi $r7, $r0, 5
    addi $r8, $r0, 10
    addi $r9, $r0, 15
    addi $r10, $r0, 0
    addi $r11, $r0, 20
    
    bne $r29, $r7, 5
    bne $r29, $r8, 4
    bne $r29, $r9, 3
    bne $r29, $r10, 2
    bne $r29, $r11, 1
    j contleft
    j noleft
contleft:
    addi $r29, $r29, -1
    lw $r5, 0($r29)
    addi $r31, $r31, 4000 # nck
    add $r0, $r0, $r0
    lw $r6, 0($r29)
    bne $r6, $r0, 2
    sw $r5, 0($r29)
    j skipadd_left
    
    lw $r12, 50($r29) #####
    bne $r12, $r0, 1#####
    j skipadd_left#####
    jal addtoque
skipadd_left:
    addi $r29, $r29, 1
noleft:
    #check right
    

    addi $r7, $r0, 4
    addi $r8, $r0, 9
    addi $r9, $r0, 14
    addi $r10, $r0, 19
    addi $r11, $r0, 24
    
    bne $r29, $r7, 5
    bne $r29, $r8, 4
    bne $r29, $r9, 3
    bne $r29, $r10, 2
    bne $r29, $r11, 1
    j contright
    j noright
contright:
    addi $r29, $r29, 1
    lw $r5, 0($r29)
    addi $r31, $r31, 4000 # nck
    add $r0, $r0, $r0
    lw $r6, 0($r29)
    bne $r6, $r0, 2
    sw $r5, 0($r29)
    j skipadd_right
    
    lw $r12, 50($r29) #####
    bne $r12, $r0, 1#####
    j skipadd_right#####
    
    jal addtoque
skipadd_right:
    addi $r29, $r29, -1

   
noright:
    #check up
    addi $r7, $r0, 0
    addi $r8, $r0, 1
    addi $r9, $r0, 2
    addi $r10, $r0, 3
    addi $r11, $r0, 4
    
    bne $r29, $r7, 5
    bne $r29, $r8, 4
    bne $r29, $r9, 3
    bne $r29, $r10, 2
    bne $r29, $r11, 1
    j contup
    j noup
contup:
    addi $r29, $r29, -5 #
    lw $r5, 0($r29)
    addi $r31, $r31, 4000 # nck
    add $r0, $r0, $r0
    lw $r6, 0($r29)
    bne $r6, $r0, 2
    sw $r5, 0($r29)
    j skipadd_up
    
    lw $r12, 50($r29) #####
    bne $r12, $r0, 1#####
    j skipadd_up#####
    
    jal addtoque
skipadd_up:
    addi $r29, $r29, 5
noup:

#check down
    addi $r7, $r0, 20
    addi $r8, $r0, 21
    addi $r9, $r0, 22
    addi $r10, $r0, 23
    addi $r11, $r0, 24
    
    bne $r29, $r7, 5
    bne $r29, $r8, 4
    bne $r29, $r9, 3
    bne $r29, $r10, 2
    bne $r29, $r11, 1
    j contdown
    j nodown
contdown:
    addi $r29, $r29, 5 #
    lw $r5, 0($r29)
    addi $r31, $r31, 4000 # nck
    add $r0, $r0, $r0
    lw $r6, 0($r29)
    bne $r6, $r0, 2
    sw $r5, 0($r29)
    j skipadd_up
    
    lw $r12, 50($r29) #####
    bne $r12, $r0, 1#####
    j skipadd_down#####
    
    jal addtoque
skipadd_down:
    addi $r29, $r29, -5
nodown:

    j initialque
endque:
    j checkPressedloop


# checkPressedloop(blockid):
#     if(block!=0): cko
#     else :
#         checkPressedloop(0)
#         checkPressedloop(1)
#         checkPressedloop(2)
#         ...
#         checkPressedloop(7) ## 8 surrounding blocks to check
#     return
# for loop:
#  avoid checking boundary
#  check all surrounding add flag
# for loop:
#     iterate mine and checi flagged
#     call first loop
