module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
    //interfaces
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;
    
    //wire
    wire [31:0] adderInA, adderInB, adderRes;
    wire adderCin;
    wire [31:0] andRes, orRes, sraRes, sllRes;
    wire[31:0] w_and_or, w_sll_sra;
	wire[31:0] w_add_sub_and_or, w_sll_sra_and_or;
    
    //logic selection
    assign adderInA = data_operandA;
    assign adderInB = ctrl_ALUopcode[0] ? ~data_operandB : data_operandB;
    assign adderCin = ctrl_ALUopcode[0];
    assign w_and_or = ctrl_ALUopcode[0] ? orRes : andRes;
    assign w_sll_sra = ctrl_ALUopcode[0] ? sraRes : sllRes;
    assign w_add_sub_and_or = ctrl_ALUopcode[1] ? w_and_or : w_sll_sra;
    assign data_result = (ctrl_ALUopcode[1] | ctrl_ALUopcode[2]) ? w_add_sub_and_or : adderRes;
    
    //functions
	adder_32bit alu_adder(.ina(adderInA), .inb(adderInB), .carry_in(adderCin), .sum(adderRes), .overflow(overflow));
    comparator alu_comparator(data_operandA, data_operandB, isLessThan, isNotEqual);
	and_32bit alu_and(data_operandA, data_operandB, andRes);
	or_32bit alu_or(data_operandA, data_operandB, orRes);
	arithmetic_right_shifter alu_sra(data_operandA, ctrl_shiftamt, sraRes);
	logical_left_shifter alu_sll(data_operandA, ctrl_shiftamt, sllRes);
endmodule
