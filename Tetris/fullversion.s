nop
addi $9  $0 3
j welcome
restart: sw  $0  4095($0)
addi $31 $0 10     # r31 = 20
sw   $31 4094($0)  # 4094 = 31
addi $31 $0 27     # $ra = 25
addi $29 $0 1024   # r29 = 1024 - dmem start address
addi $28 $0 1224   # r28 = 1224 - dmem end address
clrdm: sw   $0  0($29)
addi $29 $29 1
bgt  $28 $29 clrdm
addi $29 $0 1024
addi $27 $0 1      # r27 = 1
addi $26 $0 20     # r26 = 20
sll  $27 $27 $26    # r27 = 2^20  - block start address
add $26 $0 $27
dtos: addi $29 $0 1024
add $27 $0 $26
lw   $25 0($29)     # r25 = dmem[r29]
sw   $25 0($27)     # block[r27] = r25
addi $27 $27 1      # r27 += 1
addi $29 $29 1      # r29 += 1
bgt  $28 $29 -5     # jump to 9   lw   $25 0($29)
jr $31              # jump to $ra
nop                 #####################################end of initial
nop                 #------------------------------------start of while loop
addi $17 $0 1213    # r17 for 189
addi $9 $0 3        # r9 for die
addi $2  $0 1024     # r2 = 1024
addi $18 $2 9      # r18 for number 2^20 + 9 r boarder
addi $3  $0 1      # r3 = 1     - 1
addi $10 $0 1024   # r10 = 1024
addi $11 $0 10      # r11 = 9
sll  $10 $10 $11    # r10 = 4,200,000
addi $24 $17 11
addi $23 $17 21
put3: sw   $9  0($24)
addi $24 $24 1
bgt  $23 $24 put3
addi $24 $0 115    # r24 for key "s"   d115
addi $23 $0 97     # r23 for key "a"   d97
addi $22 $0 100    # r22 for key "d"   d100
addi $21 $0 119    # r21 for key "w"   d119
addi $20 $0 113     # r20 for key "q"   d27 addi $7 $0 4  #
whilelp: addi $24 $0 20 
sll  $24 $3 $24 
lw   $7 0($24)
lw   $24 4095($0)
addi $24 $24 1
sw   $24 4095($0)
output $24
addi $8 $0 0       #initial status
addi $24 $0 2    # r24 for key "s"   d115
addi $23 $0 3     # r23 for key "a"   d97
addi $22 $0 4    # r22 for key "d"   d100
beq  $7  $0 shpa   # 0
beq  $7  $3 shpb   # 1
beq  $7  $24 shpc  # 2
beq  $7  $23 shpd  # 3
beq  $7  $22 shpe  # 4

cat: lw $24 0($1)
lw $23 0($4)
lw $22 0($5)
lw $21 0($6)
beq $9 $24 gameover
beq $9 $23 gameover
beq $9 $22 gameover
beq $9 $21 gameover
sw   $3  0($1)      # sw to $1 address
sw   $0  -10($1)    # sw to the last $1 address to make it black
sw   $3  0($4)      # sw to $1 address
sw   $0  -10($4)    # sw to the last $1 address to make it black
sw   $3  0($5)      # sw to $1 address
sw   $0  -10($5)    # sw to the last $1 address to make it black
sw   $3  0($6)      # sw to $1 address
sw   $0  -10($6)    # sw to the last $1 address to make it black
jal dtos

add  $11 $0 $10    # r11 = 4,200,000  - j jump to here
waitin: addi $24 $0 115    # r24 for key "s"   d115 for now
addi $23 $0 97     # r23 for key "a"   d97
addi $22 $0 100    # r22 for key "d"   d100
addi $21 $0 119    # r21 for key "w"   d119
addi $20 $0 113		# r20 for "q"
addi $25 $0 112     # r25 for "p"
input $12           # r12 used for input signal
beq  $12 $23 lrl    # jump to move lr part if "a"
beq  $12 $22 lrr    # jump to move lr part if "d"
beq  $12 $24 spdup      # jump to 35 add if press "s"
beq  $12 $21 rtt    # how to rotate
beq  $12 $25 pause
depause: sub  $11 $11 $3     # r11 -= 1
bgt  $11 $0 waitin     # jump to input 12
spdup: lw $19 10($1)     #
beq  $19 $9 die
lw $19 10($4)     #
beq  $19 $9 die
lw $19 10($5)     #
beq  $19 $9 die
lw $19 10($6)     #
beq  $19 $9 die
bgt  $1 $17 die
addi $1 $1 10     # r1 += 10
addi $4 $4 10
addi $5 $5 10     # r1 += 10
addi $6 $6 10
j cat             # jump to 34   add $11 $0 $0

rtt: sw   $0 0($1)
sw   $0 0($4)
sw   $0 0($5)
sw   $0 0($6)
addi $24 $0 4
addi $23 $0 2
beq $7 $0 rtta         # 0
beq $7 $3 rttb         # 1
beq $7 $23 rttc         # 2
beq $7 $9 rttd         # 3
beq $7 $24 rtte         # 4
j waitin

die: sw   $9  0($1)      # sw to $1 address
sw   $9  0($4)      # sw to $1 address
sw   $9  0($5)      # sw to $1 address
sw   $9  0($6)      # sw to $1 address
add  $24 $1 $0
jal checkcln
add  $24 $4 $0
jal checkcln
add  $24 $5 $0
jal checkcln
add  $24 $6 $0
jal checkcln
j clnrf

checkcln: addi $14 $2 10    # counter
incheckcln: bgt  $14 $24 getline
addi $14 $14 10
j incheckcln

getline: addi $16 $14 -11
ingetline: addi $14 $14 -1
beq $16 $14 clnline
lw  $15 0($14)
beq $15 $0 checknext
j ingetline

checknext: add $24 $31 $0
jal dtos
add $31 $24 $0
jr $31

clnrf: jal dtos
j whilelp

clnline: sw $24 10($9)
lw $24 4095($0)
addi $24 $24 10
sw   $24 4095($0)
output $24
sw $31 4092($0)
lw $31 4094($0)
bgt $24 $31 speedup # j to speedup

ctnc: lw $31 4092($0) # here is ctnc
lw $24 10($9)
addi $14 $16 10
inclnline: sw $0 0($14)
addi  $14 $14 -1
beq   $14 $16 mvdown
j inclnline

mvdown: addi $14 $16 10
inmvdown: lw   $15 0($16)
sw   $15 0($14)
addi $16 $16 -1
addi $14 $14 -1
beq  $16 $0 clnfst
j inmvdown

clnfst: sw $0 0($16)
addi $16 $16 1
beq  $16 $18 checkcln
j clnfst

nop                 #--------------------------------move left and right start
lrl: add $13 $1 $0    # r13 = r1 
add $24 $4 $0
add $23 $5 $0
add $22 $6 $0
lrllp: beq $13  $2 waitin # back if boarder
addi $13 $13 -10    # r13 = r1 - 10
bgt  $2  $13 lrllp1     # move right
j lrllp
lrllp1: beq $24  $2 waitin 
addi $24 $24 -10  #r13 -= 10
bgt  $2  $24 lrllp2     # jump to move left 
j lrllp1
lrllp2: beq $23  $2 waitin 
addi $23 $23 -10  #r13 -= 10
bgt  $2  $23 lrllp3     # jump to move left 
j lrllp2
lrllp3: beq $22  $2 waitin 
addi $22 $22 -10  #r13 -= 10
bgt  $2  $22 ml     # jump to move left 
j lrllp3               # check again

lrr: add $13 $1 $0  # r13 = r1
add $24 $4 $0
add $23 $5 $0
add $22 $6 $0
lrrlp: beq $13  $18 waitin # back if boarder
addi $13 $13 -10    # r13 = r1 - 10
bgt  $2  $13 lrrlp1     # move right
j lrrlp
lrrlp1: beq $24  $18 waitin 
addi $24 $24 -10  #r13 -= 10
bgt  $2  $24 lrrlp2     # jump to move left 
j lrrlp1
lrrlp2: beq $23  $18 waitin 
addi $23 $23 -10  #r13 -= 10
bgt  $2  $23 lrrlp3     # jump to move left 
j lrrlp2
lrrlp3: beq $22  $18 waitin 
addi $22 $22 -10  #r13 -= 10
bgt  $2  $22 mr     # jump to move left 
j lrrlp3               # check again

ml: lw $19 -1($1) 
beq  $19 $9 waitin
lw $19 -1($4) 
beq  $19 $9 waitin
lw $19 -1($5) 
beq  $19 $9 waitin
lw $19 -1($6) 
beq  $19 $9 waitin
addi $1 $1 -1   # move left
sw $3 0($1)
sw $0 1($1)
addi $4 $4 -1   # move left
sw $3 0($4)
sw $0 1($4)
addi $5 $5 -1   # move left
sw $3 0($5)
sw $0 1($5)
addi $6 $6 -1   # move left
sw $3 0($6)
sw $0 1($6)
jal dtos
j waitin             # jump back

mr: lw $19 1($1)
beq  $19 $9 waitin 
lw $19 1($4) 
beq  $19 $9 waitin
lw $19 1($5) 
beq  $19 $9 waitin
lw $19 1($6) 
beq  $19 $9 waitin
addi $6 $6 1    # move right
sw $3 0($6)
sw $0 -1($6)
addi $5 $5 1    # move right
sw $3 0($5)
sw $0 -1($5)
addi $4 $4 1    # move right
sw $3 0($4)
sw $0 -1($4)
addi $1 $1 1    # move right
sw $3 0($1)
sw $0 -1($1)
jal dtos
j waitin             # jump back

updtrtt: sw   $3 0($1)
sw   $3 0($4)
sw   $3 0($5)
sw   $3 0($6)
jal dtos
j waitin

shpa: addi $1 $2 14      # r1 = 2^20 + 4 -center of the battle area
addi $4 $2 3
addi $5 $2 4
addi $6 $2 5
j cat
rtta: beq $8 $0 shpa1
beq $8 $3 shpa2
beq $8 $23 shpa3
beq $8 $9 shpa0
j updtrtt
shpa1: lw $24 0($1)
lw $23 0($4)
lw $22 0($5)
lw $21 -11($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 -11
j incre
shpa2: add $22 $6 $0
shpa2lp: beq $22 $18 updtrtt
addi $22 $22 -10
bgt $2 $22 shpa2mv
j shpa2lp
shpa2mv: lw $24 -11($1)
lw $23 1($4)
lw $22 1($5)
lw $21 0($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 -11      # r1 = 2^20 + 4 -center of the battle area
addi $4 $4 1
addi $5 $5 1
addi $6 $6 0
j incre
shpa3: lw $24 11($1)
lw $23 0($4)
lw $22 0($5)
lw $21 0($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 11      # r1 = 2^20 + 4 -center of the battle area
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j incre
shpa0: add $22 $6 $0
shpa0lp: beq $22 $2 updtrtt
addi $22 $22 -10
bgt $2 $22 shpa0mv
j shpa0lp
shpa0mv: lw $24 0($1)
lw $23 -1($4)
lw $22 -1($5)
lw $21 11($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 0
addi $4 $4 -1
addi $5 $5 -1
addi $6 $6 11
j incre

shpb: addi $1 $2 14
addi $4 $2 15
addi $5 $2 4
addi $6 $2 5
j cat
rttb: beq $8 $0 shpb1
beq $8 $3 shpb2
beq $8 $23 shpb3
beq $8 $9 shpb0
j updtrtt
shpb1: addi $1 $1 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j incre
shpb2: addi $1 $1 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j incre
shpb3: addi $1 $1 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j incre
shpb0: addi $1 $1 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j incre

shpc: addi $1 $2 14
addi $4 $2 15
addi $5 $2 3
addi $6 $2 4
j cat
rttc: beq $8 $0 shpc1
beq $8 $3 shpc2
beq $8 $23 shpc3
beq $8 $9 shpc0
j updtrtt
shpc1: lw $24 -1($1)
lw $23 -12($4)
lw $22 1($5)
lw $21 -10($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 -1
addi $4 $4 -12
addi $5 $5 1
addi $6 $6 -10
j incre
shpc2: add $22 $6 $0
shpc2lp: beq $22 $18 updtrtt
addi $22 $22 -10
bgt $2 $22 shpc2mv
j shpc2lp
shpc2mv: lw $24 1($1)
lw $23 12($4)
lw $22 -1($5)
lw $21 10($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 1
addi $4 $4 12
addi $5 $5 -1
addi $6 $6 10
j incre
shpc3: lw $24 -1($1)
lw $23 -12($4)
lw $22 1($5)
lw $21 -10($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 -1
addi $4 $4 -12
addi $5 $5 1
addi $6 $6 -10
j incre
shpc0: add $22 $6 $0
shpc0lp: beq $22 $18 updtrtt
addi $22 $22 -10
bgt $2 $22 shpc0mv
j shpc0lp
shpc0mv: lw $24 1($1)
lw $23 12($4)
lw $22 -1($5)
lw $21 10($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 1
addi $4 $4 12
addi $5 $5 -1
addi $6 $6 10
j incre

shpd: addi $1 $2 34
addi $4 $2 24
addi $5 $2 14
addi $6 $2 4
j cat
rttd: beq $8 $0 shpd1
beq $8 $3 shpd2
beq $8 $23 shpd3
beq $8 $9 shpd0
j updtrtt
shpd1: add $22 $6 $0
addi $21 $18 -1
shpd1lp: beq $22 $18 updtrtt
beq $22 $21 updtrtt
beq $22 $2 updtrtt
addi $22 $22 -10
bgt $2 $22 shpd1mv
j shpd1lp
shpd1mv: lw $24 -11($1)
lw $23 0($4)
lw $22 11($5)
lw $21 22($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 -11
addi $4 $4 0
addi $5 $5 11
addi $6 $6 22
j incre
shpd2: lw $24 11($1)
lw $23 0($4)
lw $22 -11($5)
lw $21 -22($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 11
addi $4 $4 0
addi $5 $5 -11
addi $6 $6 -22
j incre
shpd3: add $22 $6 $0
addi $21 $18 -1
shpd3lp: beq $22 $18 updtrtt
beq $22 $21 updtrtt
beq $22 $2 updtrtt
addi $22 $22 -10
bgt $2 $22 shpd3mv
j shpd3lp
shpd3mv: lw $24 -11($1)
lw $23 0($4)
lw $22 11($5)
lw $21 22($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 -11
addi $4 $4 0
addi $5 $5 11
addi $6 $6 22
j incre
shpd0: lw $24 11($1)
lw $23 0($4)
lw $22 -11($5)
lw $21 -22($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 11
addi $4 $4 0
addi $5 $5 -11
addi $6 $6 -22
j incre

shpe: addi $1 $2 25
addi $4 $2 15
addi $5 $2 4
addi $6 $2 5
j cat
rtte: beq $8 $0 shpe1
beq $8 $3 shpe2
beq $8 $23 shpe3
beq $8 $9 shpe0
j updtrtt
shpe1: add $22 $6 $0
shpe1lp: beq $22 $18 updtrtt
addi $22 $22 -10
bgt $2 $22 shpe1mv
j shpe1lp
shpe1mv: lw $24 -11($1)
lw $23 0($4)
lw $22 12($5)
lw $21 1($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 -11
addi $4 $4 0
addi $5 $5 12
addi $6 $6 1
j incre
shpe2: lw $24 11($1)
lw $23 11($4)
lw $22 -1($5)
lw $21 -1($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 11
addi $4 $4 11
addi $5 $5 -1
addi $6 $6 -1
j incre
shpe3: add $22 $6 $0
shpe3lp: beq $22 $2 updtrtt
addi $22 $22 -10
bgt $2 $22 shpe3mv
j shpe3lp
shpe3mv: lw $24 -1($1)
lw $23 -12($4)
lw $22 0($5)
lw $21 11($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 -1
addi $4 $4 -12
addi $5 $5 0
addi $6 $6 11
j incre
shpe0: lw $24 1($1)
lw $23 1($4)
lw $22 -11($5)
lw $21 -11($6)
beq $9 $24 updtrtt
beq $9 $23 updtrtt
beq $9 $22 updtrtt
beq $9 $21 updtrtt
addi $1 $1 1
addi $4 $4 1
addi $5 $5 -11
addi $6 $6 -11
j incre

incre: addi $8 $8 1
addi $24 $0 4    # r24 for key "s"   d115 for now
beq $8 $24 clr8    # clear when 4
j updtrtt #waited

clr8: addi $8 $0 0
j updtrtt #waited

gameover: sw $9 0($1)
sw $9 0($4)
sw $9 0($5)
sw $9 0($6)
jal dtos
ingameover: addi $24 $0 29  # do something to signal the VGA into a mode
sll   $24 $3 $24
lw    $12 4095($0)
add   $24 $24 $12
output $24
input $12
addi $24 $0 114  # enter
beq $12 $24 restart
beq $12 $20 welcome  # quit to be waited
j ingameover

welcome: addi $23 $0 30
addi $3 $0 1
sll $23 $3 $23
output $23
addi $24 $0 114
input $12
beq $12 $24 restart
j welcome

pause: addi $25 $0 28
addi $3 $0 1
sll  $25 $3 $25
lw   $24 4095($0)
add  $25 $25 $24
output $25
addi $25 $0 112
addi $24 $0 113
input $12
beq $12 $25 depause0
beq $12 $24 welcome
j pause

depause0: lw $24 4095($0)
output $24
j depause

speedup: add $31 $31 $31
sw $31 4094($0)
addi $31 $0 1
srl $10 $10 $31
j ctnc