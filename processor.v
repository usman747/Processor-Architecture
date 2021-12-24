`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:33:54 05/07/2016 
// Design Name: 
// Module Name:    processor 
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
module processor(
	input rst,
	input clk,
	input  [2:0]fpga_select,
	output [7:0]fpga_out,
	output [7:0]alu_out,
	output [3:0]opo,
	output [7:0]data_ram,
	output [7:0]R0_OUT,
	output [7:0]R1_OUT,
	output [7:0]R2_OUT,
	output [7:0]R3_OUT,
	output [7:0]BUS1,
	output [7:0]ALU_FLAG_OUT
	);
reg [27:0]counter;
reg sclk;

always@(posedge clk) 
begin
	if(rst==1)
	begin
		counter<=28'd0;
		sclk<=0;
	end
	else if(counter<=28'd100000000)
		counter<=counter+28'd1;
	else
	begin
		counter<=28'd0;
		sclk<=~sclk;
	end
end						
	
wire [7:0]address,IR_out,sp;
wire 			load_R0_out,
				load_R1_out,
				load_R2_out,
				load_R3_out,
				inc_PC_out,
				load_PC_out,
				load_Add_R_out,
				load_Reg_Y_out,
				load_Reg_Z_out,
				load_IR_out,
				read_out,
				write_out,
				push,
				pop ;
				
wire [1:0]opcode_out;
wire [2:0]Mux_1_sel_out; 
wire [1:0]Mux_2_sel_out; 
				
memory ram(.rst(rst),.read(read_out),.write(write_out),.data_in(BUS1),
.address(address),.out(data_ram),.push(push),.pop(pop),.sp(sp));


datapath DP(.rst(rst),
				.clk(clk),
				.load_R0(load_R0_out),
				.load_R1(load_R1_out),
				.load_R2(load_R2_out),
				.load_R3(load_R3_out),
				.inc_PC(inc_PC_out),
				.load_PC(load_PC_out),
				.load_Add_R(load_Add_R_out),
				.load_Reg_Y(load_Reg_Y_out),
				.load_Reg_Z(load_Reg_Z_out),
				.load_IR(load_IR_out),
				.opcode(opcode_out),
				.Mux_1_sel(Mux_1_sel_out),
				.Mux_2_sel(Mux_2_sel_out),
				.data_ram(data_ram),
				.fpga_select(fpga_select),	
				.alu_out(alu_out),
				.address(address),
				.IR_out(IR_out),
				.R0_out(R0_OUT),
				.R1_out(R1_OUT),
				.R2_out(R2_OUT),
				.R3_out(R3_OUT),
				.fpga_out(fpga_out),
				.Bus_1(BUS1),
				.alu_flag(ALU_FLAG_OUT),
				.push(push),
				.pop(pop),
				.pointer(sp)
				);
				
				
controlUnit CU(
				.rst(rst),
				.clk(clk),
				.IR_out(IR_out),
				.load_R0(load_R0_out),
				.load_R1(load_R1_out),
				.load_R2(load_R2_out),
				.load_R3(load_R3_out),
				.inc_PC(inc_PC_out),
				.load_PC(load_PC_out),
				.load_Add_R(load_Add_R_out),
				.load_Reg_Y(load_Reg_Y_out),
				.load_Reg_Z(load_Reg_Z_out),
				.load_IR(load_IR_out),			
				.opcode(opcode_out),
				.Mux_1_sel(Mux_1_sel_out),
				.Mux_2_sel(Mux_2_sel_out),
				.read(read_out),
				.write(write_out),
				.flag_out(ALU_FLAG_OUT),
				.push(push),
				.pop(pop)
				
);

assign opo = IR_out[7:4];
endmodule
