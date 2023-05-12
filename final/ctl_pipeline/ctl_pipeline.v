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
//	wire MemRead_wire,MemWrite_wire,wireWrite_wire,ALUSrc1_wire,ALUSrc2_wire,Memtowire_wire,Output_wire,Input_wire,ALUorShifter_wire,Halt_wire,BranchCond_wire,AS_BC_wire;
//	wire [3:0] opcode_wire;
//	wire [2:0] brch_wire;
//	wire [2:0] wire_dst_wire;
	assign inst_wire = inst;
	assign twobit = inst[15:14];
	assign opcode_wire = inst[7:4];
	assign brch_wire = inst[13:11];
	
	
	assign RegWrite = (( twobit == 2'b11 && opcode_wire != 4'b0111 && opcode_wire != 4'b1101 && opcode_wire != 4'b1110 && opcode_wire != 4'b1111 && opcode_wire != 4'b0101) || (twobit == 2'b00 ) || (twobit == 2'b10 && brch_wire == 3'b000)) ? 1'b1:
							1'b0;
//	if (( twobit == 2'b11 && opcode_wire != 4'b0111 && opcode_wire != 4'b1101 && opcode_wire != 4'b1110 && opcode_wire != 4'b1111 && opcode_wire != 4'b0101) || (twobit == 2'b00 ) || (twobit == 2'b10 && brch_wire == 3'b000)) begin
//				wireWrite_wire <= 1'b1;
//			end else begin
//				wireWrite_wire <= 1'b0;
//			end
	assign MemWrite = (twobit == 2'b01 ) ? 1'b1:
							1'b0;
//			if(twobit == 2'b01 ) begin
//				MemWrite_wire <= 1'b1;
//			end else begin
//				MemWrite_wire <= 1'b0;
//			end
	assign MemRead = (twobit == 2'b00 )? 1'b1:
							1'b0;
//			if (twobit == 2'b00 ) begin
//				MemRead_wire <= 1'b1;
//			end else begin
//				MemRead_wire <= 1'b0;
//			end
	assign MemtoReg = ((twobit == 2'b11 && opcode_wire == 4'b1100) || (twobit == 2'b00)) ? 1'b1:
							1'b0;
//			if ((twobit == 2'b11 && opcode_wire == 4'b1100) || (twobit == 2'b00))begin//1101 ->1100 modified
//				Memtowire_wire <= 1'b1;
//			end else begin
//				Memtowire_wire <= 1'b0;
//			end
	assign ALUSrc1 =  ( twobit == 2'b10 && brch_wire != 3'b000) ?1'b1:
							1'b0;
//			if ( twobit == 2'b10 && brch_wire != 3'b000) begin //3'b00 ->3'b000 modified
//				ALUSrc1_wire <= 1'b1;
//			end else begin
//				ALUSrc1_wire <= 1'b0;
//			end
	assign ALUSrc2 = (twobit ==2'b11 && (opcode_wire == 4'b0000 ||opcode_wire == 4'b0001 ||opcode_wire == 4'b0010 ||opcode_wire == 4'b0011 ||opcode_wire == 4'b0100 ||opcode_wire == 4'b0101 ||opcode_wire == 4'b0110)) ? 1'b0:
							1'b1;
//			if(twobit ==2'b11 && (opcode_wire == 4'b0000 ||opcode_wire == 4'b0001 ||opcode_wire == 4'b0010 ||opcode_wire == 4'b0011 ||opcode_wire == 4'b0100 ||opcode_wire == 4'b0101 ||opcode_wire == 4'b0110)) begin
//				ALUSrc2_wire <= 1'b0;
//			end else begin
//				ALUSrc2_wire <= 1'b1;
//			end
	assign Output = (twobit == 2'b11 && opcode_wire == 4'b1101) ? 1'b1:
						  1'b0;
//			if(twobit == 2'b11 && opcode_wire == 4'b1101) begin
//				Output_wire <= 1'b1;
//			end else begin
//				Output_wire <= 1'b0;
//			end
	assign Input = (twobit == 2'b11 && opcode_wire == 4'b1100) ? 1'b1:
						1'b0;
//			if(twobit == 2'b11 && opcode_wire == 4'b1100) begin
//				Input_wire <= 1'b1;
//			end else begin
//				Input_wire <= 1'b0;
//			end
	assign opcode = ( twobit == 2'b11 ) ? opcode_wire:
						 (twobit == 2'b10 && brch_wire == 3'b000)? 4'b0110:
						 4'b0000;
//			if( twobit == 2'b11 )begin // && opcode_2wire != 4'b0111 && opcode_wire != 4'b1101 && opcode_wire != 4'b1110 && opcode_wire != 4'b1111) || (twobit == 2'b11) && (opcode_wire == 4'b1100 || opcode_wire == 4'b1101) -> x
//				opcode_wire <= opcode_wire;
//			end else if(twobit == 2'b10 && brch_wire == 3'b000) begin
//				opcode_wire <= 4'b0110;
//			end else begin
//				opcode_wire <= 4'b0000;
//			end
	assign Branch = (twobit == 2'b10 && brch_wire == 3'b111) ? inst[10:8]:
					  (twobit == 2'b10 && brch_wire == 3'b100) ? brch_wire:
					  3'b111;
//			if(twobit == 2'b10 && brch_wire == 3'b111) begin
//				brch_wire <= inst[10:8];
//				BranchCond_wire <=1'b1;
//			end else if(twobit == 2'b10 && brch_wire == 3'b100) begin
//				brch_wire <= brch_wire;
//				BranchCond_wire <=1'b1;
//			end else begin
//				brch_wire <= 3'b111;
//				BranchCond_wire <=1'b0;
//			end
	assign RegDst = (twobit == 2'b00 ) ? inst[13:11]:
						 inst[10:8];
//			if(twobit == 2'b00 ) begin
//				wire_dst_wire <= inst[13:11];
//			end else  begin
//				wire_dst_wire <= inst[10:8];
//			end
	assign ALUorShifter = (twobit ==2'b11 && (opcode_wire == 4'b1000 ||opcode_wire == 4'b1001 ||opcode_wire == 4'b1010 ||opcode_wire == 4'b1011 )) ? 1'b1:
								 1'b0;
//			if(twobit ==2'b11 && (opcode_wire == 4'b1000 ||opcode_wire == 4'b1001 ||opcode_wire == 4'b1010 ||opcode_wire == 4'b1011 )) begin
//				ALUorShifter_wire <= 1'b1;
//			end else begin
//				ALUorShifter_wire <= 1'b0;
//			end
	assign Halt = (twobit == 2'b11 && opcode_wire == 4'b1111) ? 1'b1:
						1'b0;
//			if(twobit == 2'b11 && opcode_wire == 4'b1111) begin
//				Halt_wire <= 1'b1;
//			end else begin
//				Halt_wire <= 1'b0;
//			end
	assign AS_BC = (twobit == 2'b11  && opcode_wire != 4'b0111 && opcode_wire != 4'b1101 && opcode_wire != 4'b1110 && opcode_wire != 4'b1111 && opcode_wire != 4'b1100) ? 1'b1:
						1'b0;
//			if(twobit == 2'b11  && opcode_wire != 4'b0111 && opcode_wire != 4'b1101 && opcode_wire != 4'b1110 && opcode_wire != 4'b1111 && opcode_wire != 4'b1100) begin
//				AS_BC_wire <= 1'b1;
//			end else begin
//				AS_BC_wire <= 1'b0;
//			end
	
endmodule
