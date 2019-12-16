//32-bit DFFE (Register)
module dffe_32(clk, d, q, reset);
	//input
	input [31:0] d;
	input clk;
	input reset;
	
	//output
	output reg [31:0] q;
	
	//logic
	initial begin
		q <= 32'd0;
	end
	
	always@(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'd0;
		end else begin
			q <= d;
		end
	end
endmodule
