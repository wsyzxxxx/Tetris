nop
addi $8 $0 1 		# $8 = 1
sll $8 $8 31 		# $8 = -2147483648
addi $9 $0 1 		# $9 = 1
sub $8 $8 $9 		# overflow $30 = 3
bex 7 				# jump to 7
nop
setx 0 				# $30 = 0
addi $8 $8 -1 		# overflow $30 = 2
bex 11 				# $jump to 11
nop
setx 0 				# $30 = 0
bex 15 				# not jump
addi $8 $0 65535 	# $8 = 65535
sll $9 $8 15 		# $9 = 2147450880
addi $8 $0 32767 	# $8 = 32767
add $9 $8 $9 		# $9 = 2147483647
addi $10 $0 1 		# $10 = 1
add $9 $9 $10 		# overflow $30 = 1
bex 21 				# jump to 21
nop
setx 0 				# $30 = 0
addi $10 $0 -1 		# $10 = -1
sub $9 $9 $10 		# overflow $30 = 3
bex 26 				# jump to 26
nop
setx 0 				# $30 = 0
bex 30 				# not jump
addi $8 $0 12 		# $8 = 12
sw $9 15($8) 		# save 2147483647 to 27
sw $8 17($8) 		# save 12 to 29
addi $8 $0 65535 	# $8 = 65535
sll $9 $8 15 		# $9 = 2147450880
addi $8 $0 32767 	# $8 = 32767
add $9 $8 $9 		# $9 = 2147483647
or $10 $8 $9 		# $10 = 2147483647
bne $10 $9 1 		# not jump
nop
addi $8 $0 12 		# $8 = 12
lw $9 17($8) 		# $9 = 12
lw $9 15($8) 		# $9 = 2147483647
lw $9 17($8) 		# $9 = 12
lw $9 0($0) 		# $9 = 0
blt $8 $9 5 		# not jump
blt $9 $8 1 		# jump to 46
nop
blt $8 $8 5 		# not jump
add $30 $30 $30 	# $30 = 0
add $0 $8 $8 		# $0 = 0
add $8 $8 $8 		# $8 = 24
nop					#PC = 50
addi $8, $0, 1		#8: 1
addi $9, $8, 2		#9: 3
addi $10, $9, -2	#10: 1
add $9, $8, $9		#9: 4
sub $9, $9, $8		#9: 3
bne $8, $9, 1		#PC+=2
addi $11, $0, 1		#11: 0
bne $8, $10, 1		#PC++
addi $12, $0, 1		#12: 1
blt $8, $9, 1		#PC+=2
add $12, $12, $11	#12: 1
blt $9, $8, 1		#PC+=1
add $11, $11, $12	#11: 1
j 66				#PC=66
sra $11, $11, 1		#11: 2
jal 80				#PC = 80, $31 = 67
bne $8, $10, 1		#PC++
bne $8, $9, 1		#PC+=2
blt $9, $8, 1		#PC+=1
blt $8, $10, 1		#PC+=1
blt $8, $9, 1		#PC+=2
sra $11, $11, 1		#11:2
j 75				#PC=75
sra $11, $11, 1		#11:2
jal 80				#PC = 80, $31 = 76
j 66				#PC = 66
nop
nop
nop
nop
jr $31				#PC = 67 / 76