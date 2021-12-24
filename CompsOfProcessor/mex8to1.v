`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:24:12 05/07/2016 
// Design Name: 
// Module Name:    mex8to1 
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
module mux8to1(
					 input [7:0]in1,
					 input [7:0]in2,
					 input [7:0]in3,
					 input [7:0]in4,
					 input [7:0]in5,
					 input [7:0]in6,
					 input [7:0]in7,
					 input [7:0]in8,
					 input [2:0]sel,
					 output reg [7:0]out
    );
	 always@(*)
	 begin
		 case(sel)
			 3'd0:
			 out<=in1;
			 
			 3'd1:
			 out<=in2;
			 
			 3'd2:
			 out<=in3;
			 
			 3'd3:
			 out<=in4;
			 
			 3'd4:
			 out<=in5;
			 
			 3'd5:
			 out<=in6;
			 
			 3'd6:
			 out<=in7;
			 
			 3'd7:
			 out<=in8;
		 endcase	 
	 end
	 
endmodule

