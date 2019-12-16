module regfile(
    clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, 
    data_readRegB,
    r8, r9, r10, r11, r12, r30, r31
);
    //interface
    input clock, ctrl_writeEnable, ctrl_reset;
    input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    input [31:0] data_writeReg;
    output [31:0] data_readRegA, data_readRegB;
    
    output [31:0] r8, r9, r10, r11, r12, r30, r31;
    
    assign r8 = w_reg_q8;
    assign r9 = w_reg_q9;
    assign r10 = w_reg_q10;
    assign r11 = w_reg_q11;
    assign r12 = w_reg_q12;
    assign r30 = w_reg_q30;
    assign r31 = w_reg_q31;

    //wire
    wire[31:0] w_write_enable;
    wire[31:0] w_reg_q0, w_reg_q1, w_reg_q2, w_reg_q3, w_reg_q4, w_reg_q5, w_reg_q6, w_reg_q7, w_reg_q8, w_reg_q9, w_reg_q10, w_reg_q11, w_reg_q12, w_reg_q13, w_reg_q14, w_reg_q15, w_reg_q16, w_reg_q17, w_reg_q18, w_reg_q19, w_reg_q20, w_reg_q21, w_reg_q22, w_reg_q23, w_reg_q24, w_reg_q25, w_reg_q26, w_reg_q27, w_reg_q28, w_reg_q29, w_reg_q30, w_reg_q31;
	 
    //circuit
    write_port regfile_write(ctrl_writeReg, ctrl_writeEnable, w_write_enable);
    read_port regfile_readA(ctrl_readRegA, data_readRegA, w_reg_q0, w_reg_q1, w_reg_q2, w_reg_q3, w_reg_q4, w_reg_q5, w_reg_q6, w_reg_q7, w_reg_q8, w_reg_q9, w_reg_q10, w_reg_q11, w_reg_q12, w_reg_q13, w_reg_q14, w_reg_q15, w_reg_q16, w_reg_q17, w_reg_q18, w_reg_q19, w_reg_q20, w_reg_q21, w_reg_q22, w_reg_q23, w_reg_q24, w_reg_q25, w_reg_q26, w_reg_q27, w_reg_q28, w_reg_q29, w_reg_q30, w_reg_q31);
    read_port regfile_readB(ctrl_readRegB, data_readRegB, w_reg_q0, w_reg_q1, w_reg_q2, w_reg_q3, w_reg_q4, w_reg_q5, w_reg_q6, w_reg_q7, w_reg_q8, w_reg_q9, w_reg_q10, w_reg_q11, w_reg_q12, w_reg_q13, w_reg_q14, w_reg_q15, w_reg_q16, w_reg_q17, w_reg_q18, w_reg_q19, w_reg_q20, w_reg_q21, w_reg_q22, w_reg_q23, w_reg_q24, w_reg_q25, w_reg_q26, w_reg_q27, w_reg_q28, w_reg_q29, w_reg_q30, w_reg_q31);

    reg_block reg_0(clock, 32'b0, w_reg_q0, 1'b0, 1'b1);
    reg_block reg_1(clock, data_writeReg, w_reg_q1, w_write_enable[1], ctrl_reset);
    reg_block reg_2(clock, data_writeReg, w_reg_q2, w_write_enable[2], ctrl_reset);
    reg_block reg_3(clock, data_writeReg, w_reg_q3, w_write_enable[3], ctrl_reset);
    reg_block reg_4(clock, data_writeReg, w_reg_q4, w_write_enable[4], ctrl_reset);
    reg_block reg_5(clock, data_writeReg, w_reg_q5, w_write_enable[5], ctrl_reset);
    reg_block reg_6(clock, data_writeReg, w_reg_q6, w_write_enable[6], ctrl_reset);
    reg_block reg_7(clock, data_writeReg, w_reg_q7, w_write_enable[7], ctrl_reset);
    reg_block reg_8(clock, data_writeReg, w_reg_q8, w_write_enable[8], ctrl_reset);
    reg_block reg_9(clock, data_writeReg, w_reg_q9, w_write_enable[9], ctrl_reset);
    reg_block reg_10(clock, data_writeReg, w_reg_q10, w_write_enable[10], ctrl_reset);
    reg_block reg_11(clock, data_writeReg, w_reg_q11, w_write_enable[11], ctrl_reset);
    reg_block reg_12(clock, data_writeReg, w_reg_q12, w_write_enable[12], ctrl_reset);
    reg_block reg_13(clock, data_writeReg, w_reg_q13, w_write_enable[13], ctrl_reset);
    reg_block reg_14(clock, data_writeReg, w_reg_q14, w_write_enable[14], ctrl_reset);
    reg_block reg_15(clock, data_writeReg, w_reg_q15, w_write_enable[15], ctrl_reset);
    reg_block reg_16(clock, data_writeReg, w_reg_q16, w_write_enable[16], ctrl_reset);
    reg_block reg_17(clock, data_writeReg, w_reg_q17, w_write_enable[17], ctrl_reset);
    reg_block reg_18(clock, data_writeReg, w_reg_q18, w_write_enable[18], ctrl_reset);
    reg_block reg_19(clock, data_writeReg, w_reg_q19, w_write_enable[19], ctrl_reset);
    reg_block reg_20(clock, data_writeReg, w_reg_q20, w_write_enable[20], ctrl_reset);
    reg_block reg_21(clock, data_writeReg, w_reg_q21, w_write_enable[21], ctrl_reset);
    reg_block reg_22(clock, data_writeReg, w_reg_q22, w_write_enable[22], ctrl_reset);
    reg_block reg_23(clock, data_writeReg, w_reg_q23, w_write_enable[23], ctrl_reset);
    reg_block reg_24(clock, data_writeReg, w_reg_q24, w_write_enable[24], ctrl_reset);
    reg_block reg_25(clock, data_writeReg, w_reg_q25, w_write_enable[25], ctrl_reset);
    reg_block reg_26(clock, data_writeReg, w_reg_q26, w_write_enable[26], ctrl_reset);
    reg_block reg_27(clock, data_writeReg, w_reg_q27, w_write_enable[27], ctrl_reset);
    reg_block reg_28(clock, data_writeReg, w_reg_q28, w_write_enable[28], ctrl_reset);
    reg_block reg_29(clock, data_writeReg, w_reg_q29, w_write_enable[29], ctrl_reset);
    reg_block reg_30(clock, data_writeReg, w_reg_q30, w_write_enable[30], ctrl_reset);
    reg_block reg_31(clock, data_writeReg, w_reg_q31, w_write_enable[31], ctrl_reset);
endmodule
