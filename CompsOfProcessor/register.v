`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:20:58 05/07/2016 
// Design Name: 
// Module Name:    register 
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
module register(
					input [7:0] data_in,
					input load,
					input clk,
					input rst,
					output reg [7:0]data_out
    );
	 
	 
always@(posedge clk)
begin
	if(rst)
		begin
			data_out<=8'd0;
		end

	else if(load)
		begin
			data_out<=data_in;
		end

	else
		begin
			data_out<=data_out;
		end
end

endmodule
