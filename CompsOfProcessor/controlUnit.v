`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:42:42 05/07/2016 
// Design Name: 
// Module Name:    controlUnit 
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
module controlUnit(

				input rst,
				input clk,
				input [7:0]IR_out,
				input [7:0]flag_out,
				
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
				output reg [1:0]opcode,
				output reg [2:0]Mux_1_sel,
				output reg [1:0]Mux_2_sel,
				output reg read,
				output reg write,
				output reg push,
				output reg pop
				
				
			
				 );

parameter fetch1 = 5'd0;
parameter fetch2 = 5'd1;
parameter execute1 = 5'd2;

parameter rdfm1 = 5'd3;
parameter rdfm2 = 5'd4;

parameter ridfm1 = 5'd5;
parameter ridfm2 = 5'd6;

parameter uncond_branch= 5'd7;

parameter ridfr1 = 5'd8;

parameter widfm1 = 5'd9;
parameter widfm2 = 5'd10;

parameter conditional_branch=5'd11;

parameter func_call1 = 5'd12;
parameter func_call2 = 5'd13;
parameter func_call3 = 5'd14;
parameter func_call4 = 5'd15;
parameter func_call5 = 5'd16;

parameter func_return1 = 5'd17;
parameter func_return2 = 5'd18;
parameter func_return3 = 5'd19;
parameter func_return4 = 5'd20;

reg[4:0]pstate,nstate;

always@(posedge clk)
begin
	if(rst)
	begin
		pstate<=fetch1;
		end
	else
		pstate<=nstate;
end

always@(*)
begin

	if(rst)
	begin
	  load_R0=0;
	  load_R1=0;
	  load_R2=0;
	  load_R3=0;
	  inc_PC=0;
	  load_PC=0;
	  load_Add_R=0;
	  load_Reg_Y=0;
	  load_Reg_Z=0;
	  load_IR=0;
	  opcode=2'd3;
	  Mux_1_sel=0;
	  Mux_2_sel=0;
	  read=0;
	  write=0;
					
	end

	else
	begin

	  load_R0=0;
	  load_R1=0;
	  load_R2=0;
	  load_R3=0;
	  inc_PC=0;
	  load_PC=0;
	  load_Add_R=0;
	  load_Reg_Y=0;
	  load_Reg_Z=0;
	  load_IR=0;
	  opcode=2'd3;
	  Mux_1_sel=0;
	  Mux_2_sel=0;
	  read=0;
     write=0;
	  
		case(pstate)
		
		fetch1:
			begin
			  load_R0=0;
			  load_R1=0;
			  load_R2=0;
			  load_R3=0;
			  inc_PC=0;
			  load_PC=0;
			  load_Add_R=1;
			  load_Reg_Y=0;
			  load_Reg_Z=0;
			  load_IR=0;
			  opcode=2'd3;
			  Mux_1_sel=3'd4;
			  Mux_2_sel=2'd1;
			  read=0;
			  write=0;
				nstate<=fetch2;
				//Mux_1_sel = 3'd4; //from pc
				//Mux_1_sel = 3'd5;
				//Mux_2_sel = 2'd1;  //to bus2
				//load_Add_R = 1;
			end
		fetch2:
			begin
			  load_R0=0;
			  load_R1=0;
			  load_R2=0;
			  load_R3=0;
			  inc_PC=1;
			  load_PC=0;
			  load_Add_R=0;
			  load_Reg_Y=0;
			  load_Reg_Z=0;
			  load_IR=1;
			  opcode=2'd3;
			  Mux_1_sel=3'd4;
			  Mux_2_sel=2'd2;
			  read=1;
			  write=0;
			
				nstate<=execute1;

			end
		
		execute1:
			begin
				opcode=2'd3;
				
				if(IR_out[7:4]==4'b0000)		//add
				begin
					opcode=2'd0;
					nstate <= fetch1;
				end
				
				else if(IR_out[7:4]==4'b0001)  //subtract
				begin
					opcode=2'd1;
					nstate <= fetch1;
				end
				
				
				else if(IR_out[7:4]==4'b0010)  //multiply
				begin
					opcode=2'd2;
					nstate <= fetch1;
				end
				
				else if(IR_out[7:4]==4'b0011)  //read direct from memory
				begin
				
					opcode=2'd3;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				 
				  Mux_1_sel=3'd4;
				  Mux_2_sel=2'd1;
				  load_Add_R=1;
				  read=0;
	  
					 

					nstate<=rdfm1;  //Read direct from memory Cycle no:1
										
				end
				
				else if(IR_out[7:4]==4'b0100)  //read in-direct from memory
				begin 
				opcode=2'd3;
				 Mux_1_sel=3'd4;
				  Mux_2_sel=2'd1;
				    load_Add_R=1;
				 load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				 
				  read=0;
				  
					nstate<=ridfm1;  //Read in-direct from memory Cycle no:1
				end
				
				else if(IR_out[7:4]==4'b0101)  //unconditional branch
				begin
				opcode=2'd3;
					  Mux_1_sel=3'd4;
				  Mux_2_sel=2'd1;
				   load_Add_R=1;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0; 
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;  
				  read=0;	
					
//					Mux_1_sel = 3'd4;
//					Mux_2_sel = 2'd1;
//					load_Add_R = 1;
					
					nstate<=uncond_branch;
															
				end
				
				else if(IR_out[7:4]==4'b0110)  //read direct from register  (r0->r2)
				begin
				opcode=2'd3;
				 Mux_1_sel=3'd0;
				  Mux_2_sel=2'd1;
				  load_R2=1;
				   load_IR=1; 
				  load_Add_R=0;
				  load_R0=0;
				  load_R1=0;  
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0; 
				  load_Reg_Y=0;
				  load_Reg_Z=0; 
				  read=0;
				  nstate <=fetch1;
				end
				
				else if(IR_out[7:4]==4'b0111)  //read in-direct from register(r1->mem(address)->r3)
				begin
				 opcode=2'd3;
				 Mux_1_sel=3'd1;
				  Mux_2_sel=2'd1;
				   load_Add_R=1;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0; 
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;  
				  read=0;
				  nstate <= ridfr1;
				end
				
				else if(IR_out[7:4]==4'b1000)  //write in-direct from memory(getting 2nd byte)
				begin
				 opcode=2'd3;
				 Mux_1_sel=3'd4;
				  Mux_2_sel=2'd1;
				   load_Add_R=1;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0; 
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;  
				  read=0;
				  write=0;
				  nstate <= widfm1;
				end
				
				else if(IR_out[7:4]==4'b1001)  //CONDITIONAL BRANCH (getting 2nd byte or incrementing PC)
				begin
				 opcode=2'd3;
				 if(flag_out==1)
				 begin
				  Mux_1_sel=3'd4;
				  Mux_2_sel=2'd1;
				   load_Add_R=1;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0; 
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;  
				  read=0;
				  write=0;
				  nstate <= uncond_branch ;
				 end
				 else 
				 begin
				 inc_PC=1;
				 nstate <= fetch1;
				end
				end
				
				else if(IR_out[7:4]==4'b1010)  //FUNCTION CALL :: pc value saved in stack + address of branch operand stored in Add_R 
														 
				begin
				
				  
				  Mux_1_sel=3'd4;
				  push=1;
				  Mux_2_sel=2'd1;
				  load_Add_R=1;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;
					
					
	   nstate <= func_call1;
				 				
				end
				
				else if(IR_out[7:4]==4'b1011)  //FUNCTION RETURN //r3 returned
				begin
				
				  pop=1;
				  Mux_2_sel=2'd2;
				  load_R3=1;
				  push=0;
				  Mux_1_sel=3'd7;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Add_R=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;

					nstate <= func_return1;									
				end
				
				else
				begin	
					nstate<= fetch1;	
				end

				
			end
				
				
			rdfm1: //Read Direct From memory = write second byte to register
			begin
			read=1;
			Mux_2_sel=2'd2;
			  load_R0=1;
			   load_IR=1;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Add_R=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				 
				  
				  Mux_1_sel=0;
				  
				  
	
				nstate<= rdfm2;	//Read direct from memory Cycle no:2
			end
			
			rdfm2:
			begin
			nstate<= fetch1;
			end
		
		ridfm1: //Read in-direct From memory = get second byte or address of operand
			begin
			read=1;
			Mux_2_sel=2'd2;
			load_Add_R=1;
			load_IR=1;
			  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0; 
				  load_Reg_Y=0;
				  load_Reg_Z=0;		  
				  Mux_1_sel=0;
				  
				nstate<= ridfm2;	//Read in-direct From memory Cycle no:2
			end
		
		ridfm2: //Read in-direct From memory = write operand to register
			begin
			read=1;
			Mux_2_sel=2'd2;
			  load_R1=1;
			   load_IR=1;
				  load_R0=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Add_R=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;  
				  Mux_1_sel=0;
				nstate<= fetch1;	//Read in-direct From memory Cycle no:2
			end
		
		
	
	
		uncond_branch:// Get 2nd byte and load in PC :UNCOND
			begin
			 read=1;
			  Mux_2_sel=2'd2;
			  load_PC=1;
			  	load_IR=1;
			  load_R0=0;
			  load_R1=0;
			  load_R2=0;
			  load_R3=0;
			  inc_PC=0;
			  load_Add_R=0;
			  load_Reg_Y=0;
			  load_Reg_Z=0;
			  opcode=2'd3;
			  Mux_1_sel=0;
				
				nstate<=fetch1;
			end

	
	
			
					ridfr1:// read in-direct from register cycle no:2  (mem(operand)->r3)
					begin
			read=1; 
			Mux_2_sel=2'd2;
			load_R3=1;
			 load_IR=1;
			Mux_1_sel=3'd7;
			load_Add_R=0;
			 load_R2=0;
			  load_PC=0;	
			  load_R0=0;
			  load_R1=0;
			  inc_PC=0;
			  load_Reg_Y=0;
			  load_Reg_Z=0;
			  opcode=2'd3;
			  		
				nstate<=fetch1;
			end
			
			widfm1:// write in-direct from memory cycle no:2  (mem(address) ie:-address on which to write ->addr_reg)
					begin
			read=1; 
			Mux_2_sel=2'd2;
			load_Add_R=1;
			load_R3=0;
			 load_IR=0;
			Mux_1_sel=3'd7;
			 load_R2=0;
			  load_PC=0;	
			  load_R0=0;
			  load_R1=0;
			  inc_PC=0;
			  load_Reg_Y=0;
			  load_Reg_Z=0;
			  opcode=2'd3;
			  	write=0;	
				nstate<=widfm2;
			end
			
						widfm2://write in-direct from memory cycle no:3(address on which to write in address line of mem+data from r0 to data line of mem)	
					begin
					Mux_1_sel=3'd0;
					write=1;
			read=0; 
			Mux_2_sel=2'd3;
			load_Add_R=0;
			load_R3=0;
			 load_IR=0;
			 load_R2=0;
			  load_PC=0;	
			  load_R0=0;
			  load_R1=0;
			  inc_PC=0;
			  load_Reg_Y=0;
			  load_Reg_Z=0;
			  opcode=2'd3;
			  
				nstate<=fetch1;
			end
			
        conditional_branch:// Get 2nd byte and load in PC :CONDITIONAL
			begin
			 read=1;
			  Mux_2_sel=2'd2;
			  load_PC=1;
			  	load_IR=1;
			  load_R0=0;
			  load_R1=0;
			  load_R2=0;
			  load_R3=0;
			  inc_PC=0;
			  load_Add_R=0;
			  load_Reg_Y=0;
			  load_Reg_Z=0;
			  opcode=2'd3;
			  Mux_1_sel=0;
				
				nstate<=fetch1;
			end			

			
			
		
		
		func_call1: // ro
			begin
				
				 
				  Mux_1_sel=3'd0;
				  push=1;
				  Mux_2_sel=2'd3;
				  load_Add_R=0;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;
		
				
				nstate<=func_call2;
			end
			
			func_call2:  //  r1
			begin
						  
				  Mux_1_sel=3'd1;
				  push=1;
				  Mux_2_sel=2'd3;
				  load_Add_R=0;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;

				nstate<=func_call3;
			end
			
			func_call3:  // r2
			begin
						  
				  Mux_1_sel=3'd2;
				  push=1;
				  Mux_2_sel=2'd3;
				  load_Add_R=0;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;

				nstate<=func_call4;
			
			end
			
			func_call4: // r3
			begin
						  
				  Mux_1_sel=3'd3;
				  push=1;
				  Mux_2_sel=2'd3;
				  load_Add_R=0;
				  load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;

				nstate<=func_call5;
			
			end
		
		func_call5: // Branch to address
			begin
			read=1;
			Mux_2_sel=2'd2;
			load_PC=1;
				load_R0=0;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_Add_R=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  Mux_1_sel=3'd7;	  
				  write=0;
						push=0;
	
				nstate<= fetch1 ;
			end
		
		func_return1: // r2 returned
		
		begin
				
				  pop=1;
				  Mux_2_sel=2'd2;
				  load_R2=1;
				  push=0;
				  Mux_1_sel=3'd7;
				  load_R0=0;
				  load_R1=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Add_R=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;

					nstate <= func_return2;									
				end

		func_return2: // r1 returned
		
		begin
				
				  pop=1;
				  Mux_2_sel=2'd2;
				  load_R1=1;
				  push=0;
				  Mux_1_sel=3'd7;
				  load_R0=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Add_R=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;

					nstate <= func_return3;									
				end
		
		func_return3: // r0 returned
		
		begin
				
				  pop=1;
				  Mux_2_sel=2'd2;
				  load_R0=1;
				  push=0;
				  Mux_1_sel=3'd7;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_PC=0;
				  load_Add_R=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;

					nstate <= func_return4;									
				end
		
		func_return4: // pc returned
		
		begin
				
				  pop=1;
				  Mux_2_sel=2'd2;
				   load_PC=1;
				  load_R0=0;
				  push=0;
				  Mux_1_sel=3'd7;
				  load_R1=0;
				  load_R2=0;
				  load_R3=0;
				  inc_PC=0;
				  load_Add_R=0;
				  load_Reg_Y=0;
				  load_Reg_Z=0;
				  load_IR=0;
				  opcode=2'd3;
				  read=0;
				  write=0;

					nstate <= fetch1;									
				end
		
		endcase
	end

end

endmodule
