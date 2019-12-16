module scoreLatch(d, q, reset, wren, clk);

output reg [31:0] q;
input [31:0] d;
input reset, clk, wren;

initial begin
	q <= 31'd0;
end

always @(posedge clk) begin
	if (~reset) begin
		q <= 31'd0;
	end else if (wren) begin
		q <= d;
	end
end

endmodule
