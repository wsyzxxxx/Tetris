module dffe_async(clk, d, q, enable, reset);
	 //input
	 input clk, d, enable, reset;
	 
	 //output
	 output reg q;
     
     initial begin
        q <= 1'b0;
     end
	 
	 always@(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 1'b0;
		end else if (enable) begin
			q <= d;
		end
	 end
endmodule
