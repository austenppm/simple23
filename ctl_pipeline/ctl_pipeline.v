module ctl_pipeline(
	input clk,rst_n,
	input [15:0] inst,
	output  MemRead,MemWrite,RegWrite,ALUSrc1,ALUSrc2,MemtoReg,Output,Input,ALUorShifter,Halt,AS_BC,
	output  [3:0] opcode,
	output  [2:0] RegDst,
	output  [2:0] Branch);
	wire [1:0] twobit;
	wire [3:0] opcode_wire;
	wire [15:0] inst_wire;
	wire [2:0] brch_wire;
	assign inst_wire = inst;
	assign twobit = inst[15:14];
	assign opcode_wire = inst[7:4];
	assign brch_wire = inst[13:11];
	
	
	assign RegWrite = (( twobit == 2'b11 && opcode_wire != 4'b0111 && opcode_wire != 4'b1101 && opcode_wire != 4'b1110 && opcode_wire != 4'b1111 && opcode_wire != 4'b0101) || (twobit == 2'b00 ) || (twobit == 2'b10 && (brch_wire == 3'b000 || brch_wire ==  3'b001||brch_wire == 3'b010))) ? 1'b1:
							1'b0;
	assign MemWrite = (twobit == 2'b01 ) ? 1'b1:
							1'b0;
	assign MemRead = (twobit == 2'b00 )? 1'b1:
							1'b0;
	assign MemtoReg = ((twobit == 2'b11 && opcode_wire == 4'b1100) || (twobit == 2'b00)) ? 1'b1:
							1'b0;
	assign ALUSrc1 =  ( twobit == 2'b10 && brch_wire != 3'b000) ?1'b1:
							1'b0;
	assign ALUSrc2 = (twobit ==2'b11 && (opcode_wire == 4'b0000 ||opcode_wire == 4'b0001 ||opcode_wire == 4'b0010 ||opcode_wire == 4'b0011 ||opcode_wire == 4'b0100 ||opcode_wire == 4'b0101 ||opcode_wire == 4'b0110)) ? 1'b0:
							1'b1;
	assign Output = (twobit == 2'b11 && opcode_wire == 4'b1101) ? 1'b1:
						  1'b0;
	assign Input = (twobit == 2'b11 && opcode_wire == 4'b1100) ? 1'b1:
						1'b0;
	assign opcode = ( twobit == 2'b11 ) ? opcode_wire:
						 (twobit == 2'b10 && brch_wire == 3'b000)? 4'b0110:
						 (twobit == 2'b10 && brch_wire == 3'b010)? 4'b0001:
						 (twobit == 2'b10 && brch_wire == 3'b011)? 4'b0101:
						 4'b0000;
	assign Branch = (twobit == 2'b10 && brch_wire == 3'b111) ? inst[10:8]:
					  (twobit == 2'b10 && brch_wire == 3'b100) ? brch_wire:
					  3'b111;
	assign RegDst = (twobit == 2'b00 ) ? inst[13:11]:
						 inst[10:8];
	assign ALUorShifter = (twobit ==2'b11 && (opcode_wire == 4'b1000 ||opcode_wire == 4'b1001 ||opcode_wire == 4'b1010 ||opcode_wire == 4'b1011 )) ? 1'b1:
								 1'b0;
	assign Halt = (twobit == 2'b11 && opcode_wire == 4'b1111) ? 1'b1:
						1'b0;
	assign AS_BC = ((twobit == 2'b11  && opcode_wire != 4'b0111 && opcode_wire != 4'b1101 && opcode_wire != 4'b1110 && opcode_wire != 4'b1111 && opcode_wire != 4'b1100) || (twobit == 2'b10 && brch_wire == 3'b011)) ? 1'b1:
						1'b0;
	
endmodule
