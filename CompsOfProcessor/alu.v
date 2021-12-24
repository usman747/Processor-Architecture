`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:25:37 05/07/2016 
// Design Name: 
// Module Name:    alu 
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
module alu(
		input [7:0] in1,
		input [7:0] in2,
		input [1:0] opcode,
		output reg [7:0] data_out,
		output reg [7:0] flag_out
    );

always@(in1,in2,opcode,flag_out,data_out)

begin
	case(opcode)
		2'd0:
		begin
		data_out=in1+in2;
		end
		
		2'd1:
		begin
		data_out=in1-in2;
		end
		
		/*3'd2:
		begin
		data_out=~in1;
		end
		
		3'd3:
		begin
		data_out=in1&in2;
		end*/
		
		2'd2:
		begin
		data_out=in1*in2;
		end
		
		2'd3:
		begin
		data_out = data_out;
		end
		
		
	endcase
	if(data_out==0)
	flag_out=1;
	else 
	flag_out=0;
end


endmodule
