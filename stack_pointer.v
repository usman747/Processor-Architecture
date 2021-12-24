`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:02 06/05/2016 
// Design Name: 
// Module Name:    stack_pointer 
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
module stack_pointer(
    input clk,
    input rst,
    input push,
    input pop,
    output reg [7:0] pointer
    );
always@(posedge clk)
	 begin
		
		if(rst)
		begin
			pointer <= 8'd0;
		end
		
		else if(push)
		begin
			pointer <= pointer + 8'd1;
		end
		
		else if(pop)
		begin
			pointer <= pointer - 8'd1;
		end
		
		else
		begin
			pointer <= pointer;
		end
		
	 end

endmodule
