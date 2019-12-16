module comparator(data_operandA, data_operandB, isLessThan, isNotEqual);
    //interface
    input [31:0] data_operandA, data_operandB;
    output isLessThan, isNotEqual;
    
    //wire
    wire [31:0] adderRes;
    
    //adder for comparation
    adder_32bit compare_adder(data_operandA, ~data_operandB, 1'b1, adderRes);
    
    //compare
    assign isLessThan = (data_operandA[31] ^ data_operandB[31]) ? data_operandA[31] : adderRes[31]; 
    assign isNotEqual = adderRes[0] | adderRes[1] | adderRes[2] | adderRes[3] | adderRes[4] | adderRes[5] | adderRes[6] | adderRes[7] | adderRes[8] | adderRes[9] | adderRes[10] | adderRes[11] | adderRes[12] | adderRes[13] | adderRes[14] | adderRes[15] | adderRes[16] | adderRes[17] | adderRes[18] | adderRes[19] | adderRes[20] | adderRes[21] | adderRes[22] | adderRes[23] | adderRes[24] | adderRes[25] | adderRes[26] | adderRes[27] | adderRes[28] | adderRes[29] | adderRes[30] | adderRes[31];
endmodule
