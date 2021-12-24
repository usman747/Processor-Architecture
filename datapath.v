`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:26:59 05/07/2016 
// Design Name: 
// Module Name:    datapath 
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
module datapath(  input rst,
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
						input [1:0]opcode,
						input [2:0]Mux_1_sel,
						input [1:0]Mux_2_sel,
						input [7:0]data_ram,
						input push,
						input pop,
						input [2:0]fpga_select,
						output [7:0]alu_out,
						output [7:0]address,
						output [7:0]IR_out,
						output [7:0]R0_out,
						output [7:0]R1_out,
						output [7:0]R2_out,
						output [7:0]R3_out,
						output [7:0]Bus_1,
						output [7:0]pointer,
						output [7:0]alu_flag,
						output reg [7:0]fpga_out		
    );

wire [7:0]pc_out,Reg_Y_out,Reg_Z_out;
wire [7:0]Bus_2;

always@(*) 
begin
	
	if(rst==1)
	begin
		fpga_out=8'd0;
	end

	else
	begin
		case(fpga_select)
		3'd0: 
		fpga_out=clk;
		
		3'd1: 
		fpga_out=pc_out;
		
		3'd2: 
		fpga_out=alu_out;
		
		3'd3: 
		fpga_out=R0_out;
		
		3'd4:
		fpga_out=R1_out;
		
		3'd5:
		fpga_out=R2_out;
		
		3'd6:
		fpga_out=R3_out;
				
		
		default:fpga_out=8'b11111111;
		endcase
	end

end


spec_register PC(.clk(clk),.rst(rst), .data_in(Bus_2), .data_out(pc_out), .inc(inc_PC), .load(load_PC));
register IR(.clk(clk), .rst(rst), .data_in(Bus_2), .data_out(IR_out), .load(load_IR));
register R0(.clk(clk), .rst(rst), .data_in(Bus_2), .data_out(R0_out), .load(load_R0));
register R1(.clk(clk), .rst(rst), .data_in(Bus_2), .data_out(R1_out), .load(load_R1));
register R2(.clk(clk), .rst(rst), .data_in(Bus_2), .data_out(R2_out), .load(load_R2));
register R3(.clk(clk), .rst(rst), .data_in(Bus_2), .data_out(R3_out), .load(load_R3));
register Add_R(.clk(clk), .rst(rst), .data_in(Bus_2), .data_out(address), .load(load_Add_R));
register Reg_Y(.clk(clk), .rst(rst), .data_in(Bus_2), .data_out(Reg_Y_out), .load(load_Reg_Y)); 
register Reg_Z(.clk(clk), .rst(rst), .data_in(alu_flag), .data_out(Reg_Z_out), .load(load_Reg_Z)); 
mux8to1 Mux_1( .in1(R0_out), .in2(R1_out), .in3(R2_out), .in4(R3_out), .in5(pc_out), 
					.in6(IR_out), .in7(8'd0), .in8(8'd0), .out(Bus_1), .sel(Mux_1_sel));
mux4to1 Mux_2(.in1(alu_out), .in2(Bus_1), .in3(data_ram), .in4(8'd0), .out(Bus_2), .sel(Mux_2_sel)); 
alu ALU(.in1(R0_out),.in2(R1_out), .opcode(opcode), .data_out(alu_out), .flag_out(alu_flag));
stack_pointer sp(.clk(clk), .rst(rst), .push(push), .pop(pop), .pointer(pointer));
endmodule

