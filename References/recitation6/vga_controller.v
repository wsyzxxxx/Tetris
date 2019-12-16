module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 ps2_out,
							 ps2_key_pressed);

// reset the VGA output
input iRST_n;
//clock of the VGA
input iVGA_CLK;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
//output color Red Green Blue, from 0 to 255
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;         
///////// ////
//address of the VGA point of 640 * 320                
reg [18:0] ADDR;
//to store the RGB data 3 * 8 = 24
reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [7:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
	
/////////////////////////
//////Add switch-input logic here
//reg[18:0] squarePoint;
reg[7:0] input_index;
input[7:0] ps2_out;
input ps2_key_pressed;

localparam squareWidth = 100;
localparam squareHeight = 100;

localparam LEFT = 8'h6b;
localparam RIGHT = 8'h74;
localparam UP = 8'h75;
localparam DOWN = 8'h72;
integer x, y;
integer actualX, actualY;

initial begin
	x <= 200;
	y <= 200;
end

//always@(posedge iVGA_CLK) begin
//if (counter > 1228800) begin
//squareClk = ~squareClk;
//counter = 0;
//end else begin
//counter = counter + 1;
//end
//end

//always@(posedge ps2_key_pressed) begin
//if (!control)
//	control <= ~control;
//end

always@(posedge ps2_key_pressed) begin
//if (control) begin
case (ps2_out)
	UP: begin
		if (y > 0) begin
			y = y - 10;
		end
		//squarePoint = (squarePoint - 19'd5 * 19'd640) < 19'd0 ? 19'd0 : (squarePoint - 19'd5 * 19'd640);
	end
	
	DOWN: begin
		if (y < 480 - squareHeight) begin
			y = y + 10;
		end
	end
	
	LEFT: begin
		if (x > 0) begin
			x = x - 10;
		end
	end
	
	RIGHT: begin
		if (x < 640 - squareWidth) begin
			x = x + 10;
		end
	end
	
//	default: begin
//		squarePoint = squarePoint + 19'd100;
//	end
endcase
	//squarePoint <= squarePoint + 19'd5;
//	control <= ~control;
//end
end

always@(*) begin
	actualX = ADDR % 19'd640;
	actualY = ADDR / 19'd640;

	if (actualX >= x && actualX < (x + squareWidth) && 
		 actualY >= y && actualY < (y + squareHeight)) begin
		input_index <= 8'h2;
		end else begin
		input_index <= index;
	end
end



//////Color table output
img_index	img_index_inst (
	.address ( input_index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
//////
//////latch valid data at falling edge;
always@(posedge VGA_CLK_n) 
	bgr_data <= bgr_data_raw;
assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0]; 
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule
 	















