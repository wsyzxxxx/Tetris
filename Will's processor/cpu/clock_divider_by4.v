module clock_divider_by4(clk, reset, out_clk);
	//input
	input clk;
	input reset;
	
	//output
	output reg out_clk;
	
	//register
	reg counter;
	
	//logic
	initial begin
		out_clk <= 1'b0;
		counter <= 1'b0;
	end
	
	always@(posedge clk or posedge reset) begin
		if (reset) begin
			out_clk <= 1'b0;
			counter <= 1'b0;
		end else if (counter == 1'b1) begin
			out_clk <= ~out_clk;
			counter <= 1'b0;
		end else begin
			counter <= ~counter;
		end
	end
	
endmodule
