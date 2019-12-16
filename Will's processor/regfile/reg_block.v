module reg_block(clk, data, q, enable, reset);
    //input
    input clk, enable, reset;
    input[31:0] data;

    //output
    output[31:0] q;
    
    //32 dffes
    dffe_async dffe_0(clk, data[0], q[0], enable, reset);
    dffe_async dffe_1(clk, data[1], q[1], enable, reset);
    dffe_async dffe_2(clk, data[2], q[2], enable, reset);
    dffe_async dffe_3(clk, data[3], q[3], enable, reset);
    dffe_async dffe_4(clk, data[4], q[4], enable, reset);
    dffe_async dffe_5(clk, data[5], q[5], enable, reset);
    dffe_async dffe_6(clk, data[6], q[6], enable, reset);
    dffe_async dffe_7(clk, data[7], q[7], enable, reset);
    dffe_async dffe_8(clk, data[8], q[8], enable, reset);
    dffe_async dffe_9(clk, data[9], q[9], enable, reset);
    dffe_async dffe_10(clk, data[10], q[10], enable, reset);
    dffe_async dffe_11(clk, data[11], q[11], enable, reset);
    dffe_async dffe_12(clk, data[12], q[12], enable, reset);
    dffe_async dffe_13(clk, data[13], q[13], enable, reset);
    dffe_async dffe_14(clk, data[14], q[14], enable, reset);
    dffe_async dffe_15(clk, data[15], q[15], enable, reset);
    dffe_async dffe_16(clk, data[16], q[16], enable, reset);
    dffe_async dffe_17(clk, data[17], q[17], enable, reset);
    dffe_async dffe_18(clk, data[18], q[18], enable, reset);
    dffe_async dffe_19(clk, data[19], q[19], enable, reset);
    dffe_async dffe_20(clk, data[20], q[20], enable, reset);
    dffe_async dffe_21(clk, data[21], q[21], enable, reset);
    dffe_async dffe_22(clk, data[22], q[22], enable, reset);
    dffe_async dffe_23(clk, data[23], q[23], enable, reset);
    dffe_async dffe_24(clk, data[24], q[24], enable, reset);
    dffe_async dffe_25(clk, data[25], q[25], enable, reset);
    dffe_async dffe_26(clk, data[26], q[26], enable, reset);
    dffe_async dffe_27(clk, data[27], q[27], enable, reset);
    dffe_async dffe_28(clk, data[28], q[28], enable, reset);
    dffe_async dffe_29(clk, data[29], q[29], enable, reset);
    dffe_async dffe_30(clk, data[30], q[30], enable, reset);
    dffe_async dffe_31(clk, data[31], q[31], enable, reset);
endmodule
