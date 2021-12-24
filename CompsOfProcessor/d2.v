`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:09 04/01/2016 
// Design Name: 
// Module Name:    data_path 
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
module d2(input rst,
input clk,
input load_R0,
input load_R1,
input load_R2,
input load_R3,
input inc_PC,
input load_PC,
input load_Add_R,
input load_Reg_Y,
input load_Reg_Z,
input load_IR,
input [2:0]alu_select,
input [2:0]Mux_1_sel,
input [1:0]Mux_2_sel,
output [7:0]address,
output [7:0]ir_out,
input [7:0]data_ram,
output reg [7:0]fpga_out,
output [7:0]alu_flags,
input[1:0]fpga_select,

	 input [7:0]isr1_in,
	 input [7:0]isr2_in,
	 input [1:0]gprf_sel_read,
	 input [1:0]gprf_sel_write,
	 input load_isr1,
	 input load_isr2,
	 input load_argreg1,
	 input load_argreg2,
	 input inc_SP,
	 input dec_SP,
	 input load_SP,
	 output reg[7:0]data_to_ram
    );

wire [7:0]pc_out,sp_out,Reg_Y_out,alu_out,gprf_out,isr1_out,isr2_out,argreg1_out,argreg2_out,R0_out,R3_out;
wire [7:0]Bus_1,Bus_2;

always@(*)
begin
if(rst==1)
begin
	fpga_out=8'd0;
end
else
begin
	case(fpga_select)
	2'd0: fpga_out=clk;
	2'd1: fpga_out=pc_out;
	2'd2: fpga_out=alu_out;
	2'd3: fpga_out=R3_out;
	default:fpga_out=8'b11111111;
	endcase
end
end


spec_register PC(
					.clk(clk),
					.rst(rst),
					.data_in(Bus_2),
					.data_out(pc_out),
					.inc(inc_PC),
					.load(load_PC)
					);

//spec_pointer SP(
//					.clk(clk),
//					.rst(rst),
//					.data_in(Bus_2),
//					.data_out(sp_out),
//					.inc(inc_SP),
//					.dec(dec_SP),
//					.load(load_SP)
//					);
register IR(
				.clk(clk),
				.rst(rst),
				.data_in(Bus_2),
				.data_out(ir_out),
				.load(load_IR)
				);
				
//RegisterFile gprf(
//				.clk(clk),
//				.rst(rst),
//				.in(Bus_2),
//				.sel_read(gprf_sel_read),
//				.sel_write(gprf_sel_write),
//				.load_R0(load_R0),
//				.load_R1(load_R1),
//				.load_R2(load_R2),
//				.load_R3(load_R3),
//				.R0_out(R0_out),
//				.R3_out(R3_out),
//				.out(gprf_out));	
				
register isr1(
				.clk(clk),
				.rst(rst),
				.data_in(isr1_in),
				.data_out(isr1_out),
				.load(load_isr1)
				);

register isr2(
				.clk(clk),
				.rst(rst),
				.data_in(isr2_in),
				.data_out(isr2_out),
				.load(load_isr2)
				);

register argreg1(
				.clk(clk),
				.rst(rst),
				.data_in(Bus_2),
				.data_out(argreg1_out),
				.load(load_argreg1)
				);

register argreg2(
				.clk(clk),
				.rst(rst),
				.data_in(Bus_2),
				.data_out(argreg2_out),
				.load(load_argreg2)
				);

register Add_R(
				.clk(clk),
				.rst(rst),
				.data_in(Bus_2),
				.data_out(address),
				.load(load_Add_R)
				);

register Reg_Y(
				.clk(clk),
				.rst(rst),
				.data_in(Bus_2),
				.data_out(Reg_Y_out),
				.load(load_Reg_Y)
				);

register Reg_Z(
				.clk(clk),
				.rst(rst),
				.data_in(alu_flags),
				.data_out(flags_out),
				.load(load_Reg_Z)
				);

mux8to1 Mux_1(
				.in1(gprf_out),
				.in2(isr1_out),
				.in3(isr2_out),
				.in4(argreg1_out),
				.in5(argreg2_out),
				.in6(pc_out),
				.in7(ir_out),
				.in8(sp_out),
				.out(Bus_1),
				.sel(Mux_1_sel)
				);

mux4to1 Mux_2(
				.in1(alu_out),
				.in2(Bus_1),
				.in3(data_ram),
				.in4(8'd0),
				.out(Bus_2),
				.sel(Mux_2_sel)
				);

alu ALU_(
				.in1(Reg_Y_out),
				.in2(Bus_1),
				.alu_select(alu_select),
				.data_out(alu_out),
				.flag_out(alu_flags)
				);
				
always@(Bus_1)
	data_to_ram<=Bus_1;
endmodule
