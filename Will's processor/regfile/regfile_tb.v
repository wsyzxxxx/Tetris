// ---------- SAMPLE TEST BENCH ----------
`timescale 1 ns / 100 ps
module regfile_tb();
    // inputs to the DUT are reg type
    reg            clock, ctrl_writeEn, ctrl_reset;
    reg [4:0]     ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    reg [31:0]    data_writeReg;

    // outputs from the DUT are wire type
    wire [31:0] data_readRegA, data_readRegB;

    // Tracking the number of errors
    integer errors;
    integer index;    // for testing...
	 integer index2;
	 integer indexa;
	 integer indexb;
	 integer index3;

    // instantiate the DUT
    regfile regfile_ut (clock, ctrl_writeEn, ctrl_reset, ctrl_writeReg,
        ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, data_readRegB);

    // setting the initial values of all the reg
    initial
    begin
        $display($time, " << Starting the Simulation >>");
        clock = 1'b0;    // at time 0
        errors = 0;

        ctrl_reset = 1'b1;   // assert reset
        @(negedge clock);    // wait until next negative edge of clock
        @(negedge clock);    // wait until next negative edge of clock
        ctrl_reset = 1'b0;   // de-assert reset
        @(negedge clock);    // wait until next negative edge of clock

        // Begin testing... (loop over registers)
		  for(index = 0; index <= 31; index = index + 1) begin
				writeRegister(0, 32'h1 << index);
				checkRegister(0, 32'h0);

		  end
		  
		  for(index = 0; index <= 31; index = index + 1) begin
				writeRegister(index, 32'hFFFFFFFF);
				if (index == 32'b0) begin
						checkRegister(index, 32'h0);
				end else begin
						checkRegister(index, 32'hFFFFFFFF);
				end

		  end
		  
		  
        for(index = 0; index <= 31; index = index + 1) begin
            writeRegister(index,  32'hFFFFFFFF - index + 1);
				if (index == 32'b0) begin
					checkRegister(index, 32'h00000000);
				end else begin
					checkRegister(index, 32'hFFFFFFFF - index + 1);
				end
        end
		  
		  writeRegister(1, 32'h7897);
		  checkRegister(1, 32'h7897);
		  
		  writeRegister(1, 32'h0);
		  checkRegister(1, 32'h0);
		  
		  for(index = 0; index <= 31; index = index + 1) begin
				$display("index:%d", index);
				for(index2 = 0; index2 <= 31; index2 = index2 + 1) begin
					 ctrl_reset = 1'b1;
					 ctrl_reset = 1'b0;
				    writeRegister(index2, 32'h1 << index);
				end
				for(index2 = 0; index2 <= 31; index2 = index2 + 1) begin
					if (index2 == 32'b0) begin
								checkRegister(index2, 32'h0);
						 end else begin
								checkRegister(index2, 32'h1 << index);
					end
				end
		  end
		  
		  ctrl_reset = 1'b1; 
        @(negedge clock);
		  for(index = 0; index <= 31; index = index + 1) begin
				checkRegister(index, 32'h0);
		  end
		  ctrl_reset = 1'b0;

        if (errors == 0) begin
            $display("The simulation completed without errors");
        end
        else begin
            $display("The simulation failed with %d errors", errors);
        end

        $stop;
    end



    // Clock generator
    always
         #10     clock = ~clock;    // toggle

    // Task for writing
    task writeRegister;

        input [4:0] writeReg;
        input [31:0] value;

        begin
            @(negedge clock);    // wait for next negedge of clock

            ctrl_writeEn = 1'b1;
            ctrl_writeReg = writeReg;
            data_writeReg = value;

            @(negedge clock); // wait for next negedge, write should be done
            ctrl_writeEn = 1'b0;
        end
    endtask

    // Task for reading
    task checkRegister;

        input [4:0] checkReg;
        input [31:0] exp;

        begin
            @(negedge clock);    // wait for next negedge of clock

            ctrl_readRegA = 5'b0;    // test port A
            ctrl_readRegB = 5'b0;    // test port B
				
				for (indexa = 0; indexa <= 31; indexa = indexa + 1) begin
					@(negedge clock); // wait for next negedge, read should be done
					if (ctrl_readRegA == checkReg) begin
						if(data_readRegA !== exp) begin
							 $display("**Error on port A: read %h but expected %h ctrl_readRegA %h.", data_readRegA, exp, ctrl_readRegA);
							 errors = errors + 1;
						end

						if(data_readRegB !== exp) begin
							 $display("**Error on port B: read %h but expected %h ctrl_readRegB %h.", data_readRegB, exp, ctrl_readRegB);
							 errors = errors + 1;
						end
					end
					
					if(data_readRegA !== data_readRegB) begin
							 $display("**Error on ports: A %h but B %h.", data_readRegA, data_readRegB);
							 errors = errors + 1;
					end
					
					
					@(negedge clock);
					ctrl_readRegA = ctrl_readRegA + 1;
					ctrl_readRegB = ctrl_readRegB + 1;
			   end
        end
    endtask
endmodule
