nop
nop
nop
addi $1  $0  1		# r1 = 1
addi $2  $0  19		# r2 = 19
sll  $1  $1  $2		# r1 = 2^19  - screen start address
addi $3  $0  1		# r3 = 1	 - 1
addi $10 $0  3900	# r10 = 3900
addi $12 $0  5060	# r12 = 2500 - blue color


add  $11 $0  $10	# r11 = 3900
sw   $12 0($1)		# sw to $1 address
sub  $11 $11 $3		# r11 -= 1
bgt  $11 $0  -2		# jump to 10
add  $1  $1  $3		# r1 += 1
j 9					# jump to 9