/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal
	true_clock,
	true_overflow,

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;
	 output true_overflow;
	 
	 //slow down the clock
	 wire divided_clock;
	 output true_clock;
	 assign true_clock = divided_clock;
	 clock_divider_by4 clock_divider(clock, reset, divided_clock);

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 //PC and I-Mem part
	 wire [31:0] PC_input, PC_output, PC_add_out, PC_add_imme_out, bne_select_out, blt_select_out, JI_address, JI_select_out;
	 wire bne_control, blt_control;
	 assign address_imem = PC_output[11:0];
	 dffe_32 PC(.clk(divided_clock), .d(PC_input), .q(PC_output), .reset(reset));
	 
	 
	 //PC logic part
	 wire invisLessThan;
	 not not_gate7(invisLessThan, isLessThan);
	 adder_32bit PC_add(.ina(PC_output), .inb(32'd1), .carry_in(1'b0), .sum(PC_add_out), .overflow());
	 adder_32bit PC_add_imme(.ina(PC_add_out), .inb(sign_imme), .carry_in(1'b0), .sum(PC_add_imme_out), .overflow());
	 assign bne_control = (invopcode0 & opcode[1] & invopcode2) ? 1'b1 : 1'b0;
	 assign blt_control = (invopcode0 & opcode[1] & opcode[2]) ? 1'b1 : 1'b0;
	 assign bne_select_out = (bne_control & isNotEqual) ? PC_add_imme_out : PC_add_out;
	 assign blt_select_out = (blt_control & invisLessThan & isNotEqual) ? PC_add_imme_out : bne_select_out;
	 assign JI_address[31:27] = PC_add_out[31:27];
	 assign JI_address[26:0] = JI_target;
	 assign JI_select_out = ((opcode[0] & invopcode2) | (opcode[4] & opcode[1] & isNotEqual)) ? JI_address : blt_select_out;
	 assign PC_input = (opcode[2] & invopcode1 & invopcode0) ? data_readRegB : JI_select_out;
	 
	 
	 //for all types instuctions
	 wire [4:0] opcode;
	 assign opcode = q_imem[31:27];
	 wire [4:0] rd;
	 assign rd = q_imem[26:22];
	 
	 
	 //For R-Type instruction
	 wire [4:0] rs, rt;
	 assign rs = q_imem[21:17];
	 assign rt = q_imem[16:12];
	 wire [4:0] shamt, aluopcode;
	 assign shamt = q_imem[11:7];
	 assign aluopcode = q_imem[6:2];
	 
	 
	 //For I-type instruction
	 wire [16:0] immediate;
	 assign immediate = q_imem[16:0];
	 
	 
	 //For JI-Type instruction
	 wire [26:0] JI_target;
	 assign JI_target = q_imem[26:0];
	 
	 
	 //Register Part
	 wire invopcode0, invopcode1, invopcode2, invopcode3, invopcode4;
	 wire rdrt_select;
	 assign ctrl_readRegA = opcode[4]? 5'd30 : rs;
	 assign ctrl_readRegB = (opcode[1] | opcode[2]) ? rd : rt;
	 not not_gate0(invopcode0, opcode[0]);
	 not not_gate1(invopcode1, opcode[1]);
	 not not_gate2(invopcode2, opcode[2]);
	 not not_gate3(invopcode3, opcode[3]);
	 not not_gate4(invopcode4, opcode[4]);
	 
	 //sign-extension
	 wire [31:0] sign_imme;
	 assign sign_imme[16:0] = immediate[16:0];
	 generate
		 genvar i;
		 for (i = 31; i > 16; i = i - 1) begin : sign_extension
			assign sign_imme[i] = immediate[16];
		 end
	 endgenerate
	 
	 //ALU part
	 wire [31:0] tempaluinA, tempaluinB, aluinA, aluinB, aluinB_data;
	 wire [4:0] aluop;
	 wire [31:0] alu_result;
	 wire isNotEqual, isLessThan, overflow, true_overflow;
	 wire invaluop1, invaluop2;
	 wire [1:0] overflow_value;
	 not not_gate5(invaluop1, aluop[1]);
	 not not_gate6(invaluop2, aluop[2]);
	 assign tempaluinA = data_readRegA;
	 assign aluinB_data = (opcode[0] | opcode[3]) ? sign_imme : data_readRegB;
	 assign tempaluinB = opcode[4] ? 32'd0 : aluinB_data;
	 assign aluop = (opcode[3] | opcode[2]) ? 5'd0 : aluopcode;
    assign true_overflow = ((invopcode0 & invopcode1 & invopcode2 & invopcode3 & invaluop1 & invaluop2) | (opcode[0] & invopcode1 & opcode[2] & invopcode4)) ? overflow : 1'b0;
	 assign overflow_value[0] = invopcode0;
	 assign overflow_value[1] = opcode[0] | aluop[0];
	 alu core_alu(.data_operandA(aluinA), .data_operandB(aluinB), .ctrl_ALUopcode(aluop),
			.ctrl_shiftamt(shamt), .data_result(alu_result), .isNotEqual(isNotEqual), 
			.isLessThan(isLessThan), .overflow(overflow));
	 
	 //to store the value from Regfile to ALU
	 dffe_32 aluA(.clk(invdivided_clock), .d(tempaluinA), .q(aluinA), .reset(reset));
	 dffe_32 aluB(.clk(invdivided_clock), .d(tempaluinB), .q(aluinB), .reset(reset));
	 
	 //D-Mem part
	 assign address_dmem = alu_result[11:0];
	 assign data = data_readRegB;
	 assign wren = opcode[0] & opcode[1] & opcode[2] & invdivided_clock;
	 
	 //write register part
	 wire [31:0] write_data, write_ra_data, write_rstatus_data, select_ra_rstatus;
	 wire [4:0] ctrl_ra_rstatus;
	 wire write_en_value, invdivided_clock;
	 //prepare write data
	 assign write_ra_data = PC_add_out;
	 assign write_rstatus_data[1:0] = opcode[4] ? JI_address[1:0] : overflow_value;
	 assign write_rstatus_data[31:2] = opcode[4] ? JI_address[31:2] : 30'b0;
	 assign write_data = opcode[3] ? q_dmem : alu_result;
	 //select write data
	 assign select_ra_rstatus = (opcode[4] | true_overflow) ? write_rstatus_data : write_ra_data;
	 assign data_writeReg = (true_overflow | opcode[1] | opcode[4]) ? select_ra_rstatus : write_data;
	 //select write control
	 assign ctrl_ra_rstatus = (opcode[4] | true_overflow) ? 5'd30 : 5'd31;
	 assign ctrl_writeReg = (true_overflow | opcode[1] | opcode[4]) ? ctrl_ra_rstatus : rd;
	 //write enable
	 assign write_en_value = (opcode[2] & invopcode1 & opcode[0]) | (invopcode2 & opcode[1] & opcode[0]) | (invopcode0 & invopcode1 & invopcode2);
	 not not_gate_clk(invdivided_clock, divided_clock);
	 assign ctrl_writeEnable = invdivided_clock & write_en_value;
endmodule
