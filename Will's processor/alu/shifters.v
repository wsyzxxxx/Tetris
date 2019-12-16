//32-bit arithmetic right-shift
module arithmetic_right_shifter(in, shiftamt, result);
		//input
	input[31:0] in;
	input[4:0] shiftamt;
	
	//output
	output[31:0] result;
	
	//wire
	wire sign_bit;
	wire[31:0] w_first_layer, w_second_layer, w_third_layer, w_fourth_layer;
	
	assign sign_bit = in[31];
	
	//first layer circuit
	first_lshift_layer lfirst_layer(shiftamt[0], in, w_first_layer, sign_bit);
	
	//second layer circuit
	second_lshift_layer lsecond_layer(shiftamt[1], w_first_layer, w_second_layer, sign_bit);
	
	//third layer circuit
	third_lshift_layer lthird_layer(shiftamt[2], w_second_layer, w_third_layer, sign_bit);
	
	//fourth layer circuit
	fourth_lshift_layer lfourth_layer(shiftamt[3], w_third_layer, w_fourth_layer, sign_bit);
	
	//fifth layer circuit
	fifth_lshift_layer lfifth_layer(shiftamt[4], w_fourth_layer, result, sign_bit);

endmodule

//32-bit left shifter
module logical_left_shifter(in, shiftamt, result);
	//input
	input[31:0] in;
	input[4:0] shiftamt;
	
	//output
	output[31:0] result;
	
	//wire
	wire[31:0] w_first_layer, w_second_layer, w_third_layer, w_fourth_layer;
	
	//first layer circuit
	first_shift_layer first_layer(shiftamt[0], in, w_first_layer);
	
	//second layer circuit
	second_shift_layer second_layer(shiftamt[1], w_first_layer, w_second_layer);
	
	//third layer circuit
	third_shift_layer third_layer(shiftamt[2], w_second_layer, w_third_layer);
	
	//fourth layer circuit
	fourth_shift_layer fourth_layer(shiftamt[3], w_third_layer, w_fourth_layer);
	
	//fifth layer circuit
	fifth_shift_layer fifth_layer(shiftamt[4], w_fourth_layer, result);
	
endmodule

//shifter first layer
module first_shift_layer(shiftamt, in, out);
	//input
	input[31:0] in;
	input shiftamt;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], in[30], out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], in[29], out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], in[28], out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], in[27], out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], in[26], out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], in[25], out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], in[24], out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], in[23], out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[22], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[21], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[20], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[19], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[18], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[17], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[16], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[15], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[14], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[13], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[12], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[11], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[10], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[9], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[8], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[7], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], in[6], out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], in[5], out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], in[4], out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], in[3], out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], in[2], out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], in[1], out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], in[0], out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], 1'b0, out[0]);
endmodule

//shifter second layer
module second_shift_layer(shiftamt, in, out);
	//input
	input[31:0] in;
	input shiftamt;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], in[29], out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], in[28], out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], in[27], out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], in[26], out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], in[25], out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], in[24], out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], in[23], out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], in[22], out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[21], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[20], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[19], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[18], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[17], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[16], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[15], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[14], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[13], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[12], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[11], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[10], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[9], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[8], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[7], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[6], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], in[5], out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], in[4], out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], in[3], out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], in[2], out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], in[1], out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], in[0], out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], 1'b0, out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], 1'b0, out[0]);
endmodule

//shifter third layer
module third_shift_layer(shiftamt, in, out);
	//input
	input[31:0] in;
	input shiftamt;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], in[27], out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], in[26], out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], in[25], out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], in[24], out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], in[23], out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], in[22], out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], in[21], out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], in[20], out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[19], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[18], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[17], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[16], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[15], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[14], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[13], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[12], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[11], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[10], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[9], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[8], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[7], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[6], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[5], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[4], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], in[3], out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], in[2], out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], in[1], out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], in[0], out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], 1'b0, out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], 1'b0, out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], 1'b0, out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], 1'b0, out[0]);
endmodule

//shifter fourth layer
module fourth_shift_layer(shiftamt, in, out);
	//input
	input[31:0] in;
	input shiftamt;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], in[23], out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], in[22], out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], in[21], out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], in[20], out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], in[19], out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], in[18], out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], in[17], out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], in[16], out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[15], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[14], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[13], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[12], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[11], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[10], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[9], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[8], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[7], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[6], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[5], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[4], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[3], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[2], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[1], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[0], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], 1'b0, out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], 1'b0, out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], 1'b0, out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], 1'b0, out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], 1'b0, out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], 1'b0, out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], 1'b0, out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], 1'b0, out[0]);
endmodule

//shifter fifth layer
module fifth_shift_layer(shiftamt, in, out);
	//input
	input[31:0] in;
	input shiftamt;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], in[15], out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], in[14], out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], in[13], out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], in[12], out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], in[11], out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], in[10], out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], in[9], out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], in[8], out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[7], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[6], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[5], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[4], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[3], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[2], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[1], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[0], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], 1'b0, out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], 1'b0, out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], 1'b0, out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], 1'b0, out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], 1'b0, out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], 1'b0, out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], 1'b0, out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], 1'b0, out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], 1'b0, out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], 1'b0, out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], 1'b0, out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], 1'b0, out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], 1'b0, out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], 1'b0, out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], 1'b0, out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], 1'b0, out[0]);
endmodule


//lshifter first layer
module first_lshift_layer(shiftamt, in, out, sign_bit);
	//input
	input[31:0] in;
	input shiftamt, sign_bit;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], sign_bit, out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], in[31], out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], in[30], out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], in[29], out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], in[28], out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], in[27], out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], in[26], out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], in[25], out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[24], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[23], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[22], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[21], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[20], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[19], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[18], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[17], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[16], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[15], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[14], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[13], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[12], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[11], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[10], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[9], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], in[8], out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], in[7], out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], in[6], out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], in[5], out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], in[4], out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], in[3], out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], in[2], out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], in[1], out[0]);
endmodule

//lshifter second layer
module second_lshift_layer(shiftamt, in, out, sign_bit);
	//input
	input[31:0] in;
	input shiftamt, sign_bit;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], sign_bit, out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], sign_bit, out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], in[31], out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], in[30], out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], in[29], out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], in[28], out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], in[27], out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], in[26], out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[25], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[24], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[23], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[22], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[21], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[20], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[19], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[18], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[17], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[16], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[15], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[14], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[13], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[12], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[11], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[10], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], in[9], out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], in[8], out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], in[7], out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], in[6], out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], in[5], out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], in[4], out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], in[3], out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], in[2], out[0]);

endmodule

//lshifter third layer
module third_lshift_layer(shiftamt, in, out, sign_bit);
	//input
	input[31:0] in;
	input shiftamt, sign_bit;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], sign_bit, out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], sign_bit, out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], sign_bit, out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], sign_bit, out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], in[31], out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], in[30], out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], in[29], out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], in[28], out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[27], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[26], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[25], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[24], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[23], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[22], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[21], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[20], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[19], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[18], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[17], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[16], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[15], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[14], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[13], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[12], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], in[11], out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], in[10], out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], in[9], out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], in[8], out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], in[7], out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], in[6], out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], in[5], out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], in[4], out[0]);

endmodule

//lshifter fourth layer
module fourth_lshift_layer(shiftamt, in, out, sign_bit);
	//input
	input[31:0] in;
	input shiftamt, sign_bit;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], sign_bit, out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], sign_bit, out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], sign_bit, out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], sign_bit, out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], sign_bit, out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], sign_bit, out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], sign_bit, out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], sign_bit, out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], in[31], out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], in[30], out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], in[29], out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], in[28], out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], in[27], out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], in[26], out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], in[25], out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], in[24], out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[23], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[22], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[21], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[20], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[19], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[18], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[17], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[16], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], in[15], out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], in[14], out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], in[13], out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], in[12], out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], in[11], out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], in[10], out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], in[9], out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], in[8], out[0]);

endmodule

//lshifter fifth layer
module fifth_lshift_layer(shiftamt, in, out, sign_bit);
	//input
	input[31:0] in;
	input shiftamt, sign_bit;
	
	//output
	output[31:0] out;
	
	//circuit
	mux_2_1bit mux_0(shiftamt, in[31], sign_bit, out[31]);
	mux_2_1bit mux_1(shiftamt, in[30], sign_bit, out[30]);
	mux_2_1bit mux_2(shiftamt, in[29], sign_bit, out[29]);
	mux_2_1bit mux_3(shiftamt, in[28], sign_bit, out[28]);
	mux_2_1bit mux_4(shiftamt, in[27], sign_bit, out[27]);
	mux_2_1bit mux_5(shiftamt, in[26], sign_bit, out[26]);
	mux_2_1bit mux_6(shiftamt, in[25], sign_bit, out[25]);
	mux_2_1bit mux_7(shiftamt, in[24], sign_bit, out[24]);
	mux_2_1bit mux_8(shiftamt, in[23], sign_bit, out[23]);
	mux_2_1bit mux_9(shiftamt, in[22], sign_bit, out[22]);
	mux_2_1bit mux_10(shiftamt, in[21], sign_bit, out[21]);
	mux_2_1bit mux_11(shiftamt, in[20], sign_bit, out[20]);
	mux_2_1bit mux_12(shiftamt, in[19], sign_bit, out[19]);
	mux_2_1bit mux_13(shiftamt, in[18], sign_bit, out[18]);
	mux_2_1bit mux_14(shiftamt, in[17], sign_bit, out[17]);
	mux_2_1bit mux_15(shiftamt, in[16], sign_bit, out[16]);
	mux_2_1bit mux_16(shiftamt, in[15], in[31], out[15]);
	mux_2_1bit mux_17(shiftamt, in[14], in[30], out[14]);
	mux_2_1bit mux_18(shiftamt, in[13], in[29], out[13]);
	mux_2_1bit mux_19(shiftamt, in[12], in[28], out[12]);
	mux_2_1bit mux_20(shiftamt, in[11], in[27], out[11]);
	mux_2_1bit mux_21(shiftamt, in[10], in[26], out[10]);
	mux_2_1bit mux_22(shiftamt, in[9], in[25], out[9]);
	mux_2_1bit mux_23(shiftamt, in[8], in[24], out[8]);
	mux_2_1bit mux_24(shiftamt, in[7], in[23], out[7]);
	mux_2_1bit mux_25(shiftamt, in[6], in[22], out[6]);
	mux_2_1bit mux_26(shiftamt, in[5], in[21], out[5]);
	mux_2_1bit mux_27(shiftamt, in[4], in[20], out[4]);
	mux_2_1bit mux_28(shiftamt, in[3], in[19], out[3]);
	mux_2_1bit mux_29(shiftamt, in[2], in[18], out[2]);
	mux_2_1bit mux_30(shiftamt, in[1], in[17], out[1]);
	mux_2_1bit mux_31(shiftamt, in[0], in[16], out[0]);
endmodule
