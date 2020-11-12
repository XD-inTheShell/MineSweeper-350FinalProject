j main

openBlock:
addi $r31, $r31, 4000 # nck 
lw $5, 0($r29)
jr $ra


main:
    addi $r9, $r0, 9
    addi $r10, $r0, 10
    addi $r1, $r0, 1
checkPressedloop:
    addi $r31, $r31, 1000 # cko $r2
    bne $r1, $r2, checkPressedloop
    addi $r31, $r31, 2000 # clrpr
    addi $r31, $r31, 3000 # bid $r3
    lw $r4, 0($r3)
    bne $r4, $r10, continue                ##bomb if eq
    sw $r9 0(r3)
infLoop:
    blt $r0, $r1, infLoop
continue:
    add $r29, $r3, $r0
    jal openBlock
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