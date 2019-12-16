nop # Basic Arithmetic Test with no Hazards
nop # Values initialized using addi (positive only) and sub
nop # dmem should contain only 0s before instructions execute
nop
nop
nop # Initialize Values
addi $3 $0 1	# r3 = 1
addi $4 $0 35	# r4 = 35
addi $1 $0 3	# r1 = 3
addi $2 $0 21	# r2 = 21
sub $3 $0 $3	# r3 = -1
sub $4 $0 $4	# r4 = -35
nop
nop # Positive Value Tests
add $5 $2 $1	# r5 = r2 + r1 = 24
sub $6 $2 $1	# r6 = r2 - r1 = 18
and $7 $2 $1	# r7 = r2 & r1 = 1
or $8 $2 $1 	# r8 = r2 | r1 = 23
sll $9 $1 4 	# r9 = r1 << 4 = 48
sra $10 $2 2	# r10 = r2 >> 2 = 5
nop
nop # Negative Value Tests
addi $11 $2 -89	# r11 = r2 - 89 = -68
add $12 $4 $2	# r12 = r4 + r2 = -14
sub $13 $4 $2	# r13 = r4 - r2 = -56
sll $14 $3 16	# r14 = r3 << 16 = -65536
sra $15 $4 16	# r15 = r4 >> 16 = -1
nop
nop # Load/Store Tests
sw $1 1($0) 	# dmem[1] = r1 = 3
sw $2 2($0) 	# dmem[2] = r2 = 21
sw $3 0($1) 	# dmem[r1] = r3 = -1 (should be dmem[3])
lw $16 1($0) 	# r16 = dmem[1] = 3
lw $17 2($0) 	# r17 = dmem[2] = 21
lw $18 0($1) 	# r18 = dmem[3] = -1
nop
nop
nop
addi $11 $0 -11
addi $12 $0 22
add $14 $11 $12
add $14 $14 $14
j 44
nop
jal 47
nop
nop
add $13 $31 $0
nop
nop
bne $14 $11 5
nop
nop
nop
nop
nop
bne $14 $12 10
blt $14 $11 10
blt $11 $14 2
nop
nop
addi $20 $0 1
sll $20 $20 31
sub $21 $20 1
bex 66
nop
setx 0
addi $21 $20 -1
bex 70
nop
setx 0
addi $21 $0 1
sll $21 $21 30
addi $22 $21 1
bex 74
nop
setx 0
addi $23 $0 -1
sub $22 $21 $23
bex 79
nop
nop
nop


