module decoder(in, out);
    //input
    input[4:0] in;

    //output
    output[31:0] out;

    //wire
    wire[4:0] not_in;
    
    //circuit
    //invert the input
    inverter_5bit invert_input(in, not_in);

    //and gates to get the output
    //and and_gate_out0(out[0], not_in[0], not_in[1], not_in[2], not_in[3], not_in[4]);
    and and_gate_out1(out[1], in[0], not_in[1], not_in[2], not_in[3], not_in[4]);
    and and_gate_out2(out[2], not_in[0], in[1], not_in[2], not_in[3], not_in[4]);
    and and_gate_out3(out[3], in[0], in[1], not_in[2], not_in[3], not_in[4]);
    and and_gate_out4(out[4], not_in[0], not_in[1], in[2], not_in[3], not_in[4]);
    and and_gate_out5(out[5], in[0], not_in[1], in[2], not_in[3], not_in[4]);
    and and_gate_out6(out[6], not_in[0], in[1], in[2], not_in[3], not_in[4]);
    and and_gate_out7(out[7], in[0], in[1], in[2], not_in[3], not_in[4]);
    and and_gate_out8(out[8], not_in[0], not_in[1], not_in[2], in[3], not_in[4]);
    and and_gate_out9(out[9], in[0], not_in[1], not_in[2], in[3], not_in[4]);
    and and_gate_out10(out[10], not_in[0], in[1], not_in[2], in[3], not_in[4]);
    and and_gate_out11(out[11], in[0], in[1], not_in[2], in[3], not_in[4]);
    and and_gate_out12(out[12], not_in[0], not_in[1], in[2], in[3], not_in[4]);
    and and_gate_out13(out[13], in[0], not_in[1], in[2], in[3], not_in[4]);
    and and_gate_out14(out[14], not_in[0], in[1], in[2], in[3], not_in[4]);
    and and_gate_out15(out[15], in[0], in[1], in[2], in[3], not_in[4]);
    and and_gate_out16(out[16], not_in[0], not_in[1], not_in[2], not_in[3], in[4]);
    and and_gate_out17(out[17], in[0], not_in[1], not_in[2], not_in[3], in[4]);
    and and_gate_out18(out[18], not_in[0], in[1], not_in[2], not_in[3], in[4]);
    and and_gate_out19(out[19], in[0], in[1], not_in[2], not_in[3], in[4]);
    and and_gate_out20(out[20], not_in[0], not_in[1], in[2], not_in[3], in[4]);
    and and_gate_out21(out[21], in[0], not_in[1], in[2], not_in[3], in[4]);
    and and_gate_out22(out[22], not_in[0], in[1], in[2], not_in[3], in[4]);
    and and_gate_out23(out[23], in[0], in[1], in[2], not_in[3], in[4]);
    and and_gate_out24(out[24], not_in[0], not_in[1], not_in[2], in[3], in[4]);
    and and_gate_out25(out[25], in[0], not_in[1], not_in[2], in[3], in[4]);
    and and_gate_out26(out[26], not_in[0], in[1], not_in[2], in[3], in[4]);
    and and_gate_out27(out[27], in[0], in[1], not_in[2], in[3], in[4]);
    and and_gate_out28(out[28], not_in[0], not_in[1], in[2], in[3], in[4]);
    and and_gate_out29(out[29], in[0], not_in[1], in[2], in[3], in[4]);
    and and_gate_out30(out[30], not_in[0], in[1], in[2], in[3], in[4]);
    and and_gate_out31(out[31], in[0], in[1], in[2], in[3], in[4]);
endmodule
