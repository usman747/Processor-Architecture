`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:35:01 05/10/2016
// Design Name:   processor
// Module Name:   C:/Users/Desktop/MCA/procStim.v
// Project Name:  MCA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module processorstim;

	// Inputs
	reg rst;
	reg clk;
	reg [1:0] fpga_select;

	// Outputs
	wire [7:0] fpga_out;
	wire [7:0] alu_out;
	wire [3:0] opo;
	wire [7:0] data_ram;
	wire [7:0] R0_OUT;
	wire [7:0] R1_OUT;
   wire [7:0] R2_OUT;
	wire [7:0] R3_OUT;
	wire [7:0] BUS1;
	wire [7:0] ALU_FLAG_OUT;
	
	// Instantiate the Unit Under Test (UUT)
	processor uut (
		.rst(rst), 
		.clk(clk), 
		.fpga_select(fpga_select), 
		.fpga_out(fpga_out), 
		.alu_out(alu_out), 
		.opo(opo), 
		.data_ram(data_ram),
		.R0_OUT(R0_OUT),
		.R1_OUT(R1_OUT),
		.R2_OUT(R2_OUT),
		.R3_OUT(R3_OUT),
		.BUS1(BUS1),
		.ALU_FLAG_OUT(ALU_FLAG_OUT)
	);
always
#10 clk = ~clk;
	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		fpga_select = 0;

		// Wait 100 ns for global reset to finish
		#50;
      rst = 0;
		fpga_select = 2'd2;
		
		
		#500;
		fpga_select = 2'd3;
	end
      
endmodule

