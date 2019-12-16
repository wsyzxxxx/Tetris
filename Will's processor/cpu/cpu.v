/**
 * NOTE: you should not need to change this file! This file will be swapped out for a grading
 * "skeleton" for testing. We will also remove your imem and dmem file.
 *
 * NOTE: skeleton should be your top-level module!
 *
 * This skeleton file serves as a wrapper around the processor to provide certain control signals
 * and interfaces to memory elements. This structure allows for easier testing, as it is easier to
 * inspect which signals the processor tries to assert when.
 */

module cpu(clock, reset, imem_clock, dmem_clock, processor_block, regfile_clock, 
					 //The following outputs are just for testing with my test instructions, and can be ignored.
					 q_dmem, q_imem, address_imem, data_writeReg, overflow, address_dmem, r8, r9, r10, r11, r12, r30, r31);
    input clock, reset;

    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    output [11:0] address_imem;
    output [31:0] q_imem;
	output imem_clock;
    assign imem_clock = ~clock;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (~clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    output [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    output [31:0] q_dmem;
	output dmem_clock;
	assign dmem_clock = ~clock;
    dmem my_dmem(
        .address    (address_dmem),       // address of data
        .clock      (~clock),             // may need to invert the clock
        .data	     (data),    				// data you want to write
        .wren	     (wren),     				// write enable
        .q          (q_dmem)    				// data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
    wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
	output [31:0] r8, r9, r10, r11, r12, r30, r31;
	output regfile_clock;
	assign regfile_clock = clock;
    regfile my_regfile(
        clock,
        ctrl_writeEnable,
        reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB,
		r8, r9, r10, r11, r12, r30, r31
    );
	 
	output processor_block, overflow;
    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        clock,                          // I: The master clock
        reset,                          // I: A reset signal
		  processor_block,
		  overflow,

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

endmodule
