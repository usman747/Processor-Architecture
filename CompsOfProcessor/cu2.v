`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:51:13 04/16/2016 
// Design Name: 
// Module Name:    Control_Unit 
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
module cu2(
				output reg load_R0,
				output reg load_R1,
				output reg load_R2,
				output reg load_R3,
				output reg inc_PC,
				output reg load_PC,
				output reg load_Add_R,
				output reg load_Reg_Y,
				output reg load_Reg_Z,
				output reg load_IR,
				output reg [3:0]alu_select,
				output reg [2:0]Mux_1_sel,
				output reg [1:0]Mux_2_sel,
				output reg read,
				output reg write,
				output reg [1:0]gprf_sel_read,
				output reg [1:0]gprf_sel_write,
				output reg load_isr1,
				output reg load_isr2,
				output reg load_argreg1,
				output reg load_argreg2,
				output reg inc_SP,
				output reg dec_SP,
				output reg load_SP,
				input rst,
				input clk,
				input [7:0]opcode,
				input [7:0]alu_flags
    );

parameter fetch1 =5'd0;
parameter fetch2 =5'd1;

parameter execute1 =5'd2;

parameter cbr=5'd3;

parameter AND=5'd4;

parameter NOT=5'd5;

parameter rdm=5'd6;
parameter rdm1=5'd7;

parameter ridm=5'd8;
parameter ridm1=5'd9;
parameter ridm2=5'd10;

parameter widm=5'd11;
parameter widm1=5'd12;
parameter widm2=5'd13;

parameter rdr=5'd14;
parameter rdr1=5'd15;

parameter ridr=5'd16;
parameter ridr1=5'd17;
parameter ridr2=5'd18;

reg[4:0]pstate,nstate;
reg [1:0]reg_sel;

always@(posedge clk)
	begin
		if(rst)
			pstate<=fetch1;
		else
			pstate<=nstate;
	end

always@(*)
	begin
			if(rst)
				begin
				  load_R0<=0;
				  load_R1<=0;
				  load_R2<=0;
				  load_R3<=0;
				  inc_PC<=0;
				  load_PC<=0;
				  load_Add_R<=0;
				  load_Reg_Y<=0;
				  load_Reg_Z<=0;
				  load_IR<=0;
				  alu_select<=0;
				  Mux_1_sel<=0;
				  Mux_2_sel<=0;
				  read<=0;
				  gprf_sel_read<=0;
				  gprf_sel_write<=0;
				  load_isr1<=0;
				  load_isr2<=0;
				  load_argreg1<=0;
				  load_argreg2<=0;
			     inc_SP<=0;
			 	  dec_SP<=0;
			     load_SP<=0;
								
				end

			else
					begin

					  load_R0<=0;
					  load_R1<=0;
					  load_R2<=0;
					  load_R3<=0;
					  inc_PC<=0;
					  load_PC<=0;
					  load_Add_R<=0;
					  load_Reg_Y<=0;
					  load_Reg_Z<=0;
					  load_IR<=0;  
					  Mux_1_sel<=0;
					  Mux_2_sel<=0;
					  read<=0;
					  load_isr1<=0;
					  load_isr2<=0;
					  load_argreg1<=0;
					  load_argreg2<=0;
					  inc_SP<=0;
					  dec_SP<=0;
					  load_SP<=0;
						
						case(pstate)
						
										fetch1:
											begin
												nstate<=fetch2;
												Mux_1_sel <= 3'd5;
												Mux_2_sel <= 2'd1;
												load_Add_R <= 1;
											end
										
										fetch2:
											begin
												nstate<=execute1;
												inc_PC<=1;
												read<=1;
												load_IR <= 1;	
												Mux_1_sel <= 3'd5;
												Mux_2_sel <= 2'd2;
												load_Reg_Y<=1;
												
											end
										
										execute1:
											begin
												if(opcode[7:4]==4'd0)
													begin
														alu_select<=3'd0;
														gprf_sel_read<=2'd0;
														
														Mux_1_sel <= 3'd5;
														Mux_2_sel <= 2'd2;
														load_Reg_Z<=1;
														nstate<=	fetch1;
													end
													
												else if(opcode[7:4]==4'd1)
													begin
														alu_select<=3'd1;
														Mux_1_sel <= 3'd5;
														Mux_2_sel <= 2'd2;
														load_Reg_Z<=1;
														nstate<=	fetch1;
													end

												else if(opcode[7:4]==4'd2)
													begin
														alu_select<=3'd2;
														Mux_1_sel <= 3'd5;
														Mux_2_sel <= 2'd2;
														load_Reg_Z<=1;
														nstate<=	fetch1;
													end

												else if(opcode[7:4]==4'd3)
													begin
														gprf_sel_read<=opcode[3:2];
														Mux_1_sel <= 3'd0;
														Mux_2_sel <= 2'd1;
														load_Reg_Y <= 1;
														load_Reg_Z<=1;
														nstate<=	AND;
													end
						
												
												else if(opcode[7:4]==4'd4)
													begin
														gprf_sel_read<=opcode[3:2];
														Mux_1_sel <= 3'd0;
														Mux_2_sel <= 2'd1;
														load_Reg_Y <= 1;
														load_Reg_Z<=1;

														nstate<=	NOT;
													end
												
												else if(opcode[7:4]==4'd5)
													begin
																Mux_1_sel <= 3'd5;
																Mux_2_sel <= 2'd1;
																load_Add_R <= 1;
																nstate<=cbr;
													end
													
												else if(opcode[7:4]==4'd6)
													begin
														if(alu_flags[0]==1)
															begin
																Mux_1_sel <= 3'd5;
																Mux_2_sel <= 2'd1;
																load_Add_R <= 1;
																nstate<=cbr;
															end
														else
															begin
																inc_PC<=1;
																nstate<=fetch1;
															end
													end
								
												else if(opcode[7:4]==4'd7)
													begin
																reg_sel<=opcode[1:0];
																Mux_1_sel <= 3'd5;
																Mux_2_sel <= 2'd1;
																load_Add_R <= 1;		
																nstate<=rdm;
													end
								
												else if(opcode[7:4]==4'd8)
													begin
																reg_sel<=opcode[1:0];
																Mux_1_sel <= 3'd5;
																Mux_2_sel <= 2'd1;
																load_Add_R <= 1;
																nstate<=ridm;
													end
																
												else if(opcode[7:4]==4'd9)
													begin
																reg_sel<=opcode[3:2];
																Mux_1_sel <= 3'd5;
																Mux_2_sel <= 2'd1;
																load_Add_R <= 1;
																nstate<=widm;
													end
												
												else if(opcode[7:4]==4'd10)
													begin
																gprf_sel_read<=opcode[3:2];
																Mux_1_sel <= 3'd0;
																Mux_2_sel <= 2'd1;
																load_Add_R <= 1;
																nstate<=rdr;
													end
													
												else if(opcode[7:4]==4'd11)
													begin
																gprf_sel_read<=opcode[3:2];
																Mux_1_sel <= 3'd0;
																Mux_2_sel <= 2'd1;
																load_Add_R <= 1;
																nstate<=ridr;
													end
													
												else
													nstate<=fetch1;	
											end
												
										 cbr:
											begin
												read<=1;
												Mux_2_sel<=2'd2;
												load_PC<=1;
												nstate<=fetch1;
											end
										
										 AND:
											begin
												gprf_sel_read<=opcode[1:0];
												Mux_1_sel <= 3'd0;
												alu_select<= 3'd3;
												Mux_2_sel <= 2'd0;
												if(opcode[1:0]==2'd0)
												begin
													 gprf_sel_write<=2'd0;
													 load_R0<=1;
												end
												else if(opcode[1:0]==2'd1)
												begin
													 gprf_sel_write<=2'd1;
													 load_R1<=1;
												end
												else if(opcode[1:0]==2'd2)
												begin
													 gprf_sel_write<=2'd2;
													 load_R2<=1;
												end
												else
												begin
													 gprf_sel_write<=2'd3;
													 load_R3<=1;
												end
												nstate<=fetch1;	
											
											end
											
										 NOT:
											begin
												alu_select<= 3'd4;
												Mux_2_sel <= 2'd0;
												if(opcode[1:0]==2'd0)
												begin
													 gprf_sel_write<=2'd0;
													 load_R0<=1;
												end
												else if(opcode[1:0]==2'd1)
												begin
													 gprf_sel_write<=2'd1;
													 load_R1<=1;
												end
												else if(opcode[1:0]==2'd2)
												begin
													 gprf_sel_write<=2'd2;
													 load_R2<=1;
												end
												else
												begin
													 gprf_sel_write<=2'd3;
													 load_R3<=1;
												end
												nstate<=fetch1;	
											end
										 	
										 rdm:
											begin
												read<=1;
												Mux_2_sel <= 2'd2;	
												if(reg_sel==2'd0)
												begin
													 gprf_sel_write<=2'd0;
													 load_R0<=1;
												end
												else if(reg_sel==2'd1)
												begin
													 gprf_sel_write<=2'd1;
													 load_R1<=1;
												end
												else if(reg_sel==2'd2)
												begin
													 gprf_sel_write<=2'd2;
													 load_R2<=1;
												end
												else
												begin
													 gprf_sel_write<=2'd3;
													 load_R3<=1;
												end
												nstate<=fetch1;	
											end
										
										 ridm:
											begin
												read<=1;
												Mux_2_sel<=2'd2;
												load_Add_R<=1;
												nstate<=ridm1;
											end
											
										
										ridm1:
											begin
												read<=1;
												Mux_2_sel <= 2'd2;
												if(reg_sel==2'd0)
												begin
													 gprf_sel_write<=2'd0;
													 load_R0<=1;
												end
												else if(reg_sel==2'd1)
												begin
													 gprf_sel_write<=2'd1;
													 load_R1<=1;
												end
												else if(reg_sel==2'd2)
												begin
													 gprf_sel_write<=2'd2;
													 load_R2<=1;
												end
												else
												begin
													 gprf_sel_write<=2'd3;
													 load_R3<=1;
												end
												nstate<=fetch1;	
											end
											
										widm:
											begin
												read<=1;
												Mux_2_sel<=2'd2;
												load_Add_R<=1;
												nstate<=widm1;
											end
										
										widm1:
											begin
												read<=1;
												Mux_2_sel <= 2'd2;						
												load_Add_R<=1;
												nstate<=widm2;
											end
										
										widm2:
											begin
												write<=1;
												gprf_sel_read<=reg_sel;
												Mux_1_sel<=3'd0;
												nstate<=fetch1;	
											end
											
										 rdr:
											begin
												read<=1;
												Mux_2_sel <= 2'd2;						
												gprf_sel_write<=opcode[1:0];
												if(opcode[1:0]==2'd0)
													 load_R0<=1;
												else if(opcode[1:0]==2'd1)
													 load_R1<=1;
												else if(opcode[1:0]==2'd2)
													 load_R2<=1;
												else
													 load_R3<=1;
												nstate<=fetch1;	
											end
											
										 ridr:
											begin
												read<=1;
												Mux_2_sel<=2'd2;
												load_Add_R<=1;
												nstate<=ridr1;
											end
										
										ridr1:
											begin
												read<=1;
												Mux_2_sel <= 2'd2;						
												gprf_sel_write<=opcode[1:0];
												if(opcode[1:0]==2'd0)
													 load_R0<=1;
												else if(opcode[1:0]==2'd1)
													 load_R1<=1;
												else if(opcode[1:0]==2'd2)
													 load_R2<=1;
												else
													 load_R3<=1;
												nstate<=fetch1;	
											end
											
									endcase
					end
	end
endmodule
