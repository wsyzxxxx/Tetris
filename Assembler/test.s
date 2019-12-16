nop
addi $1 $2 -2	# comment 0
nop
nop
addi $1 $0 32	# comment 1
add $31 $1 $0	# comment 2
and $30 $29 $28 # comment 3
or $27 $26 $25  # comment 4
sll $5 $9 $2    # comment 5
srl $5 $3 $2	# comment 6
nop
nop
nop
beq $8 $4 22	# comment 7
bgt $9 $21 23	# comment 8
jr $15		# comment 9
j 128		# comment 10
jal 99		# comment 11
input $12	# comment 12
output $17	# comment 13
nop
nop
nop
