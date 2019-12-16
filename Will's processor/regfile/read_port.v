module read_port(
     ctrl_readReg,
     data_readReg,
     reg_data0,
     reg_data1,
     reg_data2,
     reg_data3,
     reg_data4,
     reg_data5,
     reg_data6,
     reg_data7,
     reg_data8,
     reg_data9,
     reg_data10,
     reg_data11,
     reg_data12,
     reg_data13,
     reg_data14,
     reg_data15,
     reg_data16,
     reg_data17,
     reg_data18,
     reg_data19,
     reg_data20,
     reg_data21,
     reg_data22,
     reg_data23,
     reg_data24,
     reg_data25,
     reg_data26,
     reg_data27,
     reg_data28,
     reg_data29,
     reg_data30,
     reg_data31
);
    //input
    input[31:0] reg_data0, reg_data1, reg_data2, reg_data3, reg_data4, reg_data5, reg_data6, reg_data7, reg_data8, reg_data9, reg_data10, reg_data11, reg_data12, reg_data13, reg_data14, reg_data15, reg_data16, reg_data17, reg_data18, reg_data19, reg_data20, reg_data21, reg_data22, reg_data23, reg_data24, reg_data25, reg_data26, reg_data27, reg_data28, reg_data29, reg_data30, reg_data31;
    input[4:0] ctrl_readReg;

    //output
    output[31:0] data_readReg;
    
    //wire
    wire[31:0] w_decoder_tristate;

    //circuit
    //decoder
    decoder read_decoder(ctrl_readReg, w_decoder_tristate);

    //output of read port
    assign data_readReg = w_decoder_tristate[0] ? reg_data0 : 32'bz;
    assign data_readReg = w_decoder_tristate[1] ? reg_data1 : 32'bz;
    assign data_readReg = w_decoder_tristate[2] ? reg_data2 : 32'bz;
    assign data_readReg = w_decoder_tristate[3] ? reg_data3 : 32'bz;
    assign data_readReg = w_decoder_tristate[4] ? reg_data4 : 32'bz;
    assign data_readReg = w_decoder_tristate[5] ? reg_data5 : 32'bz;
    assign data_readReg = w_decoder_tristate[6] ? reg_data6 : 32'bz;
    assign data_readReg = w_decoder_tristate[7] ? reg_data7 : 32'bz;
    assign data_readReg = w_decoder_tristate[8] ? reg_data8 : 32'bz;
    assign data_readReg = w_decoder_tristate[9] ? reg_data9 : 32'bz;
    assign data_readReg = w_decoder_tristate[10] ? reg_data10 : 32'bz;
    assign data_readReg = w_decoder_tristate[11] ? reg_data11 : 32'bz;
    assign data_readReg = w_decoder_tristate[12] ? reg_data12 : 32'bz;
    assign data_readReg = w_decoder_tristate[13] ? reg_data13 : 32'bz;
    assign data_readReg = w_decoder_tristate[14] ? reg_data14 : 32'bz;
    assign data_readReg = w_decoder_tristate[15] ? reg_data15 : 32'bz;
    assign data_readReg = w_decoder_tristate[16] ? reg_data16 : 32'bz;
    assign data_readReg = w_decoder_tristate[17] ? reg_data17 : 32'bz;
    assign data_readReg = w_decoder_tristate[18] ? reg_data18 : 32'bz;
    assign data_readReg = w_decoder_tristate[19] ? reg_data19 : 32'bz;
    assign data_readReg = w_decoder_tristate[20] ? reg_data20 : 32'bz;
    assign data_readReg = w_decoder_tristate[21] ? reg_data21 : 32'bz;
    assign data_readReg = w_decoder_tristate[22] ? reg_data22 : 32'bz;
    assign data_readReg = w_decoder_tristate[23] ? reg_data23 : 32'bz;
    assign data_readReg = w_decoder_tristate[24] ? reg_data24 : 32'bz;
    assign data_readReg = w_decoder_tristate[25] ? reg_data25 : 32'bz;
    assign data_readReg = w_decoder_tristate[26] ? reg_data26 : 32'bz;
    assign data_readReg = w_decoder_tristate[27] ? reg_data27 : 32'bz;
    assign data_readReg = w_decoder_tristate[28] ? reg_data28 : 32'bz;
    assign data_readReg = w_decoder_tristate[29] ? reg_data29 : 32'bz;
    assign data_readReg = w_decoder_tristate[30] ? reg_data30 : 32'bz;
    assign data_readReg = w_decoder_tristate[31] ? reg_data31 : 32'bz;
endmodule
