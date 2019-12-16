module write_port(ctrl_writeReg, ctrl_writeEnable, out);
    //input
    input[4:0] ctrl_writeReg;
    input ctrl_writeEnable;

    //output
    output[31:0] out;

    //wire
    wire[31:0] w_decoder_andgates;

    //circuit
    //decoder
    decoder write_decoder(ctrl_writeReg, w_decoder_andgates);

    //output of write port
    //and and_gate_0(out[0], ctrl_writeEnable, w_decoder_andgates[0]);
    and and_gate_1(out[1], ctrl_writeEnable, w_decoder_andgates[1]);
    and and_gate_2(out[2], ctrl_writeEnable, w_decoder_andgates[2]);
    and and_gate_3(out[3], ctrl_writeEnable, w_decoder_andgates[3]);
    and and_gate_4(out[4], ctrl_writeEnable, w_decoder_andgates[4]);
    and and_gate_5(out[5], ctrl_writeEnable, w_decoder_andgates[5]);
    and and_gate_6(out[6], ctrl_writeEnable, w_decoder_andgates[6]);
    and and_gate_7(out[7], ctrl_writeEnable, w_decoder_andgates[7]);
    and and_gate_8(out[8], ctrl_writeEnable, w_decoder_andgates[8]);
    and and_gate_9(out[9], ctrl_writeEnable, w_decoder_andgates[9]);
    and and_gate_10(out[10], ctrl_writeEnable, w_decoder_andgates[10]);
    and and_gate_11(out[11], ctrl_writeEnable, w_decoder_andgates[11]);
    and and_gate_12(out[12], ctrl_writeEnable, w_decoder_andgates[12]);
    and and_gate_13(out[13], ctrl_writeEnable, w_decoder_andgates[13]);
    and and_gate_14(out[14], ctrl_writeEnable, w_decoder_andgates[14]);
    and and_gate_15(out[15], ctrl_writeEnable, w_decoder_andgates[15]);
    and and_gate_16(out[16], ctrl_writeEnable, w_decoder_andgates[16]);
    and and_gate_17(out[17], ctrl_writeEnable, w_decoder_andgates[17]);
    and and_gate_18(out[18], ctrl_writeEnable, w_decoder_andgates[18]);
    and and_gate_19(out[19], ctrl_writeEnable, w_decoder_andgates[19]);
    and and_gate_20(out[20], ctrl_writeEnable, w_decoder_andgates[20]);
    and and_gate_21(out[21], ctrl_writeEnable, w_decoder_andgates[21]);
    and and_gate_22(out[22], ctrl_writeEnable, w_decoder_andgates[22]);
    and and_gate_23(out[23], ctrl_writeEnable, w_decoder_andgates[23]);
    and and_gate_24(out[24], ctrl_writeEnable, w_decoder_andgates[24]);
    and and_gate_25(out[25], ctrl_writeEnable, w_decoder_andgates[25]);
    and and_gate_26(out[26], ctrl_writeEnable, w_decoder_andgates[26]);
    and and_gate_27(out[27], ctrl_writeEnable, w_decoder_andgates[27]);
    and and_gate_28(out[28], ctrl_writeEnable, w_decoder_andgates[28]);
    and and_gate_29(out[29], ctrl_writeEnable, w_decoder_andgates[29]);
    and and_gate_30(out[30], ctrl_writeEnable, w_decoder_andgates[30]);
    and and_gate_31(out[31], ctrl_writeEnable, w_decoder_andgates[31]);
endmodule
