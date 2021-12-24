`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:28:11 05/08/2016
// Design Name:   alu
// Module Name:   D:/Xilinx Projects/MCA/aluStim.v
// Project Name:  MCA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module aluStim;

	// Inputs
	reg [7:0] in1;
	reg [7:0] in2;
	reg [2:0] opcode;

	// Outputs
	wire [7:0] data_out;
	wire [7:0] flag_out;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.in1(in1), 
		.in2(in2), 
		.opcode(opcode), 
		.data_out(data_out), 
		.flag_out(flag_out)
	);

	initial begin
		// Initialize Inputs
		in1 = 4;
		in2 = 4;
		opcode = 4;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

