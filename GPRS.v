`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:48:50 05/09/2016 
// Design Name: 
// Module Name:    GPRS 
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
module GPRS(input clk,
	 input rst,
    input [7:0]in,
    input [1:0] sel_read,
	 input [1:0] sel_write,
    input load_R0,
	 input load_R1,
	 input load_R2,
	 input load_R3,
	 output [7:0] R0_out,
	 output [7:0] R3_out,
    output [7:0] out
    );
	 
	 
wire [7:0]R0_in,R1_in,R2_in,R3_in,R1_out,R2_out;
	
deMux1to4 demux(		//for writing data
				.in(in),
				.sel(sel_write),
				.regOut0(R0_in),
				.regOut1(R1_in),
				.regOut2(R2_in),
				.regOut3(R3_in)
				);
				

register R0(
				.clk(clk),
				.rst(rst),
				.data_in(R0_in),
				.data_out(R0_out),
				.load(load_R0)
				);

register R1(
				.clk(clk),
				.rst(rst),
				.data_in(R1_in),
				.data_out(R1_out),
				.load(load_R1)
				);

register R2(
				.clk(clk),
				.rst(rst),
				.data_in(R2_in),
				.data_out(R2_out),
				.load(load_R2)
				);

register R3(
				.clk(clk),
				.rst(rst),
				.data_in(R3_in),
				.data_out(R3_out),
				.load(load_R3)
				);

mux4to1 Mux(		  //for reading data
				.in1(R0_out),
				.in2(R1_out),
				.in3(R2_out),
				.in4(R3_out),
				.out(out),
				.sel(sel_read)
				);	 

endmodule
