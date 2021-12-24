`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:23:08 05/07/2016 
// Design Name: 
// Module Name:    mex4to1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux4to1(
				 input [7:0]in1,
				 input [7:0]in2,
				 input [7:0]in3,
				 input [7:0]in4,
				 output reg [7:0]out,
				 input [1:0]sel
    );
	 always@(*)
	 begin
		 case(sel)
			 2'd0:
			 out=in1;
			 
			 2'd1:
			 out=in2;
			 
			 2'd2:
			 out=in3;
			 
			 2'd3:
			 out=in4;
		 endcase
	 end


endmodule

