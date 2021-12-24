`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:52:06 05/09/2016 
// Design Name: 
// Module Name:    deMux1to4 
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
module deMux1to4(input [7:0]in,
					  input [1:0] sel,
					  
					  output reg [7:0] regOut0,
					  output reg [7:0] regOut1,
					  output reg [7:0] regOut2,
					  output reg [7:0] regOut3
    );
	 
	 always@(*)
	 begin
	 regOut0 = 8'd0;
	 regOut1 = 8'd0;
	 regOut2 = 8'd0;
	 regOut3 = 8'd0;
		
		case(sel)
			2'd0: 
			//regOut0=in;
			regOut3=in;
			
			2'd1: 
			//regOut1=in;
			regOut3=in;
			
			2'd2: 
			//regOut2=in;
			regOut3=in;
			
			2'd3: 
			regOut3=in;
		endcase
	 end
	  
endmodule