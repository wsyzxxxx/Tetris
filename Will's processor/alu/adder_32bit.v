//32-bit csa adder with overflow
module adder_32bit(ina, inb, carry_in, sum, overflow);
	//input
	input [31:0] ina, inb;
	input carry_in;
	
	//output
	output [31:0] sum;
	output overflow;
	
	//wire
	wire [15:0] w_g2_sum, w_g3_sum;
	wire w_g1_cout, w_g2_cout, w_g3_cout;
	wire ina32_xor_inb32, ina32_xor_sum, not_ina32_xor_inb32;
	
	//parallel group1
	adder_16bit_csa parallel_16bit_group1_0(ina[15:0], inb[15:0], carry_in, sum[15:0], w_g1_cout);

	//parallel group2
	adder_16bit_csa parallel_16bit_group2_0(ina[31:16], inb[31:16], 1'b0, w_g2_sum, w_g2_cout);
	
	//parallel group3
	adder_16bit_csa parallel_16bit_group3_0(ina[31:16], inb[31:16], 1'b1, w_g3_sum, w_g3_cout);
	
	//mux
	mux_2_1bit mux_sum16(w_g1_cout, w_g2_sum[0], w_g3_sum[0], sum[16]);
	mux_2_1bit mux_sum17(w_g1_cout, w_g2_sum[1], w_g3_sum[1], sum[17]);
	mux_2_1bit mux_sum18(w_g1_cout, w_g2_sum[2], w_g3_sum[2], sum[18]);
	mux_2_1bit mux_sum19(w_g1_cout, w_g2_sum[3], w_g3_sum[3], sum[19]);
	mux_2_1bit mux_sum20(w_g1_cout, w_g2_sum[4], w_g3_sum[4], sum[20]);
	mux_2_1bit mux_sum21(w_g1_cout, w_g2_sum[5], w_g3_sum[5], sum[21]);
	mux_2_1bit mux_sum22(w_g1_cout, w_g2_sum[6], w_g3_sum[6], sum[22]);
	mux_2_1bit mux_sum23(w_g1_cout, w_g2_sum[7], w_g3_sum[7], sum[23]);
	mux_2_1bit mux_sum24(w_g1_cout, w_g2_sum[8], w_g3_sum[8], sum[24]);
	mux_2_1bit mux_sum25(w_g1_cout, w_g2_sum[9], w_g3_sum[9], sum[25]);
	mux_2_1bit mux_sum26(w_g1_cout, w_g2_sum[10], w_g3_sum[10], sum[26]);
	mux_2_1bit mux_sum27(w_g1_cout, w_g2_sum[11], w_g3_sum[11], sum[27]);
	mux_2_1bit mux_sum28(w_g1_cout, w_g2_sum[12], w_g3_sum[12], sum[28]);
	mux_2_1bit mux_sum29(w_g1_cout, w_g2_sum[13], w_g3_sum[13], sum[29]);
	mux_2_1bit mux_sum30(w_g1_cout, w_g2_sum[14], w_g3_sum[14], sum[30]);
	mux_2_1bit mux_sum31(w_g1_cout, w_g2_sum[15], w_g3_sum[15], sum[31]);
	
	//overflow
	xor xor_gate_ina32_inb32(ina32_xor_inb32, ina[31], inb[31]);
	xor xor_gate_ina32_sum(ina32_xor_sum, ina[31], sum[31]);
	not not_gate_ina32_xor_inb32(not_ina32_xor_inb32, ina32_xor_inb32);
	and and_gate_overflow(overflow, not_ina32_xor_inb32, ina32_xor_sum);
endmodule

//16-bit csa adder
module adder_16bit_csa(ina, inb, carry_in, sum, carry_out);
	//input
	input[15:0] ina, inb;
	input carry_in;
	
	//output
	output[15:0] sum;
	output carry_out;
	
	//wire
	wire[7:0] w_g2_sum, w_g3_sum;
	wire w_g1_cout, w_g2_cout, w_g3_cout;
	
	//parallel group1
	adder_8bit_csa parallel_8bit_group1_0(ina[7:0], inb[7:0], carry_in, sum[7:0], w_g1_cout);

	//parallel group2
	adder_8bit_csa parallel_8bit_group2_0(ina[15:8], inb[15:8], 1'b0, w_g2_sum, w_g2_cout);
	
	//parallel group3
	adder_8bit_csa parallel_8bit_group3_0(ina[15:8], inb[15:8], 1'b1, w_g3_sum, w_g3_cout);
	
	//mux
	mux_2_1bit mux_sum8(w_g1_cout, w_g2_sum[0], w_g3_sum[0], sum[8]);
	mux_2_1bit mux_sum9(w_g1_cout, w_g2_sum[1], w_g3_sum[1], sum[9]);
	mux_2_1bit mux_sum10(w_g1_cout, w_g2_sum[2], w_g3_sum[2], sum[10]);
	mux_2_1bit mux_sum11(w_g1_cout, w_g2_sum[3], w_g3_sum[3], sum[11]);
	mux_2_1bit mux_sum12(w_g1_cout, w_g2_sum[4], w_g3_sum[4], sum[12]);
	mux_2_1bit mux_sum13(w_g1_cout, w_g2_sum[5], w_g3_sum[5], sum[13]);
	mux_2_1bit mux_sum14(w_g1_cout, w_g2_sum[6], w_g3_sum[6], sum[14]);
	mux_2_1bit mux_sum15(w_g1_cout, w_g2_sum[7], w_g3_sum[7], sum[15]);
	mux_2_1bit mux_cout(w_g1_cout, w_g2_cout, w_g3_cout, carry_out);
endmodule

//8-bit csa adder
module adder_8bit_csa(ina, inb, carry_in, sum, carry_out);
	//input
	input[7:0] ina, inb;
	input carry_in;
	
	//output
	output[7:0] sum;
	output carry_out;
	
	//wire
	wire[3:0] w_g2_sum, w_g3_sum;
	wire w_g1_cout, w_g2_cout, w_g3_cout;
	
	//parallel group1
	adder_4bit_rca parallel_4bit_group1_0(ina[3:0], inb[3:0], carry_in, sum[3:0], w_g1_cout);

	//parallel group2
	adder_4bit_rca parallel_4bit_group2_0(ina[7:4], inb[7:4], 1'b0, w_g2_sum, w_g2_cout);
	
	//parallel group3
	adder_4bit_rca parallel_4bit_group3_0(ina[7:4], inb[7:4], 1'b1, w_g3_sum, w_g3_cout);
	
	//mux
	mux_2_1bit mux_sum4(w_g1_cout, w_g2_sum[0], w_g3_sum[0], sum[4]);
	mux_2_1bit mux_sum5(w_g1_cout, w_g2_sum[1], w_g3_sum[1], sum[5]);
	mux_2_1bit mux_sum6(w_g1_cout, w_g2_sum[2], w_g3_sum[2], sum[6]);
	mux_2_1bit mux_sum7(w_g1_cout, w_g2_sum[3], w_g3_sum[3], sum[7]);
	mux_2_1bit mux_cout(w_g1_cout, w_g2_cout, w_g3_cout, carry_out);
endmodule

//4-bit rca adder - basic block
module adder_4bit_rca(ina, inb, carry_in, sum, carry_out);
	//input
	input[3:0] ina, inb;
	input carry_in;
	
	//output
	output[3:0] sum;
	output carry_out;
	
	//wire
	wire w_fa1_fa2, w_fa2_fa3, w_fa3_fa4;
	
	//circuit
	full_adder full_adder_1(ina[0], inb[0], carry_in, sum[0], w_fa1_fa2);
	full_adder full_adder_2(ina[1], inb[1], w_fa1_fa2, sum[1], w_fa2_fa3);
	full_adder full_adder_3(ina[2], inb[2], w_fa2_fa3, sum[2], w_fa3_fa4);
	full_adder full_adder_4(ina[3], inb[3], w_fa3_fa4, sum[3], carry_out);
endmodule	
	
// full adder
module full_adder(ina, inb, carry_in, sum, carry_out);
	//input
	input ina, inb;
	input carry_in;
	
	//output
	output sum;
	output carry_out;
	
	//wire
	wire w_gate1_out, w_gate3_out, w_gate4_out;
	
	//circuit
	xor xor_gate_1(w_gate1_out, ina, inb);
	xor xor_gate_2(sum, w_gate1_out, carry_in);
	and and_gate_3(w_gate3_out, w_gate1_out, carry_in);
	and and_gate_4(w_gate4_out, ina, inb);
	or or_gate_5(carry_out, w_gate3_out, w_gate4_out);
endmodule
