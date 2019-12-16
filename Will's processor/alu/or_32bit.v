//32bit or 
module or_32bit(ina, inb, result);
	//input
	input[31:0] ina, inb;
	
	//output
	output[31:0] result;
	
	//circuit
	or or_bit_0(result[0], ina[0], inb[0]);
	or or_bit_1(result[1], ina[1], inb[1]);
	or or_bit_2(result[2], ina[2], inb[2]);
	or or_bit_3(result[3], ina[3], inb[3]);
	or or_bit_4(result[4], ina[4], inb[4]);
	or or_bit_5(result[5], ina[5], inb[5]);
	or or_bit_6(result[6], ina[6], inb[6]);
	or or_bit_7(result[7], ina[7], inb[7]);
	or or_bit_8(result[8], ina[8], inb[8]);
	or or_bit_9(result[9], ina[9], inb[9]);
	or or_bit_10(result[10], ina[10], inb[10]);
	or or_bit_11(result[11], ina[11], inb[11]);
	or or_bit_12(result[12], ina[12], inb[12]);
	or or_bit_13(result[13], ina[13], inb[13]);
	or or_bit_14(result[14], ina[14], inb[14]);
	or or_bit_15(result[15], ina[15], inb[15]);
	or or_bit_16(result[16], ina[16], inb[16]);
	or or_bit_17(result[17], ina[17], inb[17]);
	or or_bit_18(result[18], ina[18], inb[18]);
	or or_bit_19(result[19], ina[19], inb[19]);
	or or_bit_20(result[20], ina[20], inb[20]);
	or or_bit_21(result[21], ina[21], inb[21]);
	or or_bit_22(result[22], ina[22], inb[22]);
	or or_bit_23(result[23], ina[23], inb[23]);
	or or_bit_24(result[24], ina[24], inb[24]);
	or or_bit_25(result[25], ina[25], inb[25]);
	or or_bit_26(result[26], ina[26], inb[26]);
	or or_bit_27(result[27], ina[27], inb[27]);
	or or_bit_28(result[28], ina[28], inb[28]);
	or or_bit_29(result[29], ina[29], inb[29]);
	or or_bit_30(result[30], ina[30], inb[30]);
	or or_bit_31(result[31], ina[31], inb[31]);
endmodule
