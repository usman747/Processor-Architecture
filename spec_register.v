`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:22:10 05/07/2016 
// Design Name: 
// Module Name:    spec_register 
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
module spec_register(
					input[7:0] data_in,
					input load,
					input clk,
					input rst,
					input inc,
					output reg[7:0] data_out	
    );

always@(posedge clk)
begin
	if(rst)
		data_out<=8'd0;
	
	else if(inc)
		data_out<=data_out+1;
	
	else if(load)
		data_out<=data_in;
	
	else
		data_out<=data_out;
	
end
endmodule
