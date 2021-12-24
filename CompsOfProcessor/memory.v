`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:40:02 05/07/2016 
// Design Name: 
// Module Name:    memory 
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
module memory(
				input rst,
				input read,
				input write,
				input push,
				input pop,
				input [7:0]sp,
				input [7:0]data_in,
				input [7:0]address,
				output reg [7:0]out
    );

reg [7:0]mem[23:0];
reg [7:0]stack[7:0];
always@(read,write,push,pop,data_in,address,sp)
begin

	if(rst==1)
		begin
	mem[0] = 8'b0000_00_01; // add //1
			
	mem[1] = 8'b0001_00_10; // sub //17
			
	mem[2] = 8'b0010_00_01; // multipy //33
			
			mem[3] = 8'b0011_01_00; //read direct from memory //52
			mem[4] = 8'b00000011;	//2nd byte of rdfm :: mem->r0
			
        mem[5] = 8'b0100_01_10;  //read indirect from memory ::mem value=70
			mem[6] = 8'b00000111;  //2nd byte of ridfm specifying the address of operand
			mem[7] = 8'b00000101; //operand :: mem->(r1)
			
			mem[8] = 8'b0101_01_01;	//unconditonal branch :: mem value=85
			mem[9] = 8'b00001100; //2nd byte of unconditional branch BRANCHING TO MEM[12]
		
			mem[10] = 8'b0110_00_10; //read direct from register(r0->r2) :: mem value=98
		
			mem[11] = 8'b0111_11_10; //read in-direct from register(r3->mem(address)->r2) ::mem value=126
			
			mem[12] = 8'b1000_00_00; //write in-direct from memory(r0->mem(address specifed in 2nd byte)) :: mem value=128
			mem[13] = 8'b00001110; // 2nd byte specifing the address
			mem[14] = 8'b00000000; //write here
			
		mem[15] = 8'b1001_0000; // CONDItional Branch :: mem value=144
		mem[16] = 8'b00010001; // 2nd byte :: branches to mem[9]
		
		mem[17] = 8'b1010_0000; //FUNCTION CALL  ::  mem value=160
		mem[18] = 8'b00010011;  //Branch to mem[19]
		
		mem[19] = 8'b1011_0000; //FUNCTION RETURN  :: mem value=176
		end	

	else if(read==1)
	begin
		out = mem[address];
	end
	
	else if(write==1)
	begin
		mem[address] = data_in;
   end
   else if(push)	
	begin	
		stack[sp] = data_in;	
	end
	else if(pop)	
	begin	
		out = stack[sp];
	end
	
	else
		out = out;

end

endmodule

