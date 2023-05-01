//module ctl(
//	input clk,rst_n,
//	input [15:0] inst,
//	output reg MemRead,MemWrite,RegWrite,ALUSrc1,ALUSrc2,MemtoReg,Output,Input,ALUorShifter,Halt,
//	output reg [3:0] opcode,
//	output reg [2:0] RegDst,
//	output reg [2:0] Branch);
//	reg [1:0] twobit;
//	reg [3:0] opcode_reg;
//	reg [15:0] inst_reg;
//	reg [2:0] brch_reg;
//	always @ (posedge clk or negedge rst_n) begin
//		if(!rst_n) begin
//			inst_reg <= 16'b0000000000000000;
//		end else begin
//			inst_reg <= inst;
//			twobit <= inst[15:14];
//			opcode_reg <= inst[7:4];
//			brch_reg <= inst[13:11];
//			if (( twobit == 2'b11 && opcode_reg != 4'b0111 && opcode_reg != 4'b1101 && opcode_reg != 4'b1110 && opcode_reg != 4'b1111) || (twobit == 2'b00 ) || (twobit == 2'b10 && brch_reg == 3'b000)) begin
//				RegWrite <= 1'b1;
//			end else begin
//				RegWrite <= 1'b0;
//			end
//			if(twobit == 2'b01 ) begin
//				MemWrite <= 1'b1;
//			end else begin
//				MemWrite <= 1'b0;
//			end
//			if (twobit == 2'b00 ) begin
//				MemRead <= 1'b1;
//			end else begin
//				MemRead <= 1'b0;
//			end
//			if ((twobit == 2'b11 && opcode_reg == 4'b1100) || (twobit == 2'b00))begin//1101 ->1100 modified
//				MemtoReg <= 1'b1;
//			end else begin
//				MemtoReg <= 1'b0;
//			end
//			if ( twobit == 2'b10 && brch_reg != 3'b000) begin //3'b00 ->3'b000 modified
//				ALUSrc1 <= 1'b1;
//			end else begin
//				ALUSrc1 <= 1'b0;
//			end
//			if(twobit ==2'b11 && (opcode_reg == 4'b0000 ||opcode_reg == 4'b0001 ||opcode_reg == 4'b0010 ||opcode_reg == 4'b0011 ||opcode_reg == 4'b0100 ||opcode_reg == 4'b0101 ||opcode_reg == 4'b0110)) begin
//				ALUSrc2 <= 1'b0;
//			end else begin
//				ALUSrc2 <= 1'b1;
//			end
//			if(twobit == 2'b11 && opcode_reg == 4'b1101) begin
//				Output <= 1'b1;
//			end else begin
//				Output <= 1'b0;
//			end
//			if(twobit == 2'b11 && opcode_reg == 4'b1100) begin
//				Input <= 1'b1;
//			end else begin
//				Input <= 1'b0;
//			end
//			if( twobit == 2'b11 )begin // && opcode_2reg != 4'b0111 && opcode_reg != 4'b1101 && opcode_reg != 4'b1110 && opcode_reg != 4'b1111) || (twobit == 2'b11) && (opcode_reg == 4'b1100 || opcode_reg == 4'b1101) -> x
//				opcode <= opcode_reg;
//			end else if(twobit == 2'b10 && brch_reg == 3'b000) begin
//				opcode <= 4'b0110;
//			end else begin
//				opcode <= 4'b0000;
//			end
//			if(twobit == 2'b10 && brch_reg == 3'b111) begin
//				Branch <= inst[10:8];
//			end else if(twobit == 2'b10 && brch_reg == 3'b100) begin
//				Branch <= brch_reg;
//			end else begin
//				Branch <= 3'b111;
//			end
//			if(twobit == 2'b00 ) begin
//				RegDst <= inst[13:11];
//			end else  begin
//				RegDst <= inst[10:8];
//			end
//			if(twobit ==2'b11 && (opcode_reg == 4'b1000 ||opcode_reg == 4'b1001 ||opcode_reg == 4'b1010 ||opcode_reg == 4'b1011 )) begin
//				ALUorShifter <= 1'b1;
//			end else begin
//				ALUorShifter <= 1'b0;
//			end
//			if(twobit == 2'b11 && opcode_reg == 4'b1111) begin
//				Halt <= 1'b0;
//			end else begin
//				Halt <= 1'b1;
//			end
//			
//		end
//	end
//endmodule
module ctl(
	input clk,rst_n,
	input [15:0] inst,
	output  MemRead,MemWrite,RegWrite,ALUSrc1,ALUSrc2,MemtoReg,Output,Input,ALUorShifter,Halt,BranchCond,AS_BC,
	output  [3:0] opcode,
	output  [2:0] RegDst,
	output  [2:0] Branch);
	wire [1:0] twobit;
	wire [3:0] opcode_reg;
	wire [15:0] inst_reg;
	wire [2:0] brch_reg;
	reg MemRead_wire,MemWrite_wire,RegWrite_wire,ALUSrc1_wire,ALUSrc2_wire,MemtoReg_wire,Output_wire,Input_wire,ALUorShifter_wire,Halt_wire,BranchCond_wire,AS_BC_wire;
	reg [3:0] opcode_wire;
	reg [2:0] brch_wire;
	reg [2:0] reg_dst_wire;
	assign inst_reg = inst;
	assign twobit = inst[15:14];
	assign opcode_reg = inst[7:4];
	assign brch_reg = inst[13:11];
	always @ (posedge clk ) begin
		if(clk) begin
			if (( twobit == 2'b11 && opcode_reg != 4'b0111 && opcode_reg != 4'b1101 && opcode_reg != 4'b1110 && opcode_reg != 4'b1111 && opcode_reg != 4'b0101) || (twobit == 2'b00 ) || (twobit == 2'b10 && brch_reg == 3'b000)) begin
				RegWrite_wire <= 1'b1;
			end else begin
				RegWrite_wire <= 1'b0;
			end
			if(twobit == 2'b01 ) begin
				MemWrite_wire <= 1'b1;
			end else begin
				MemWrite_wire <= 1'b0;
			end
			if (twobit == 2'b00 ) begin
				MemRead_wire <= 1'b1;
			end else begin
				MemRead_wire <= 1'b0;
			end
			if ((twobit == 2'b11 && opcode_reg == 4'b1100) || (twobit == 2'b00))begin//1101 ->1100 modified
				MemtoReg_wire <= 1'b1;
			end else begin
				MemtoReg_wire <= 1'b0;
			end
			if ( twobit == 2'b10 && brch_reg != 3'b000) begin //3'b00 ->3'b000 modified
				ALUSrc1_wire <= 1'b1;
			end else begin
				ALUSrc1_wire <= 1'b0;
			end
			if(twobit ==2'b11 && (opcode_reg == 4'b0000 ||opcode_reg == 4'b0001 ||opcode_reg == 4'b0010 ||opcode_reg == 4'b0011 ||opcode_reg == 4'b0100 ||opcode_reg == 4'b0101 ||opcode_reg == 4'b0110)) begin
				ALUSrc2_wire <= 1'b0;
			end else begin
				ALUSrc2_wire <= 1'b1;
			end
			if(twobit == 2'b11 && opcode_reg == 4'b1101) begin
				Output_wire <= 1'b1;
			end else begin
				Output_wire <= 1'b0;
			end
			if(twobit == 2'b11 && opcode_reg == 4'b1100) begin
				Input_wire <= 1'b1;
			end else begin
				Input_wire <= 1'b0;
			end
			if( twobit == 2'b11 )begin // && opcode_2reg != 4'b0111 && opcode_reg != 4'b1101 && opcode_reg != 4'b1110 && opcode_reg != 4'b1111) || (twobit == 2'b11) && (opcode_reg == 4'b1100 || opcode_reg == 4'b1101) -> x
				opcode_wire <= opcode_reg;
			end else if(twobit == 2'b10 && brch_reg == 3'b000) begin
				opcode_wire <= 4'b0110;
			end else begin
				opcode_wire <= 4'b0000;
			end
			if(twobit == 2'b10 && brch_reg == 3'b111) begin
				brch_wire <= inst[10:8];
				BranchCond_wire <=1'b1;
			end else if(twobit == 2'b10 && brch_reg == 3'b100) begin
				brch_wire <= brch_reg;
				BranchCond_wire <=1'b1;
			end else begin
				brch_wire <= 3'b111;
				BranchCond_wire <=1'b0;
			end
			if(twobit == 2'b00 ) begin
				reg_dst_wire <= inst[13:11];
			end else  begin
				reg_dst_wire <= inst[10:8];
			end
			if(twobit ==2'b11 && (opcode_reg == 4'b1000 ||opcode_reg == 4'b1001 ||opcode_reg == 4'b1010 ||opcode_reg == 4'b1011 )) begin
				ALUorShifter_wire <= 1'b1;
			end else begin
				ALUorShifter_wire <= 1'b0;
			end
			if(twobit == 2'b11 && opcode_reg == 4'b1111) begin
				Halt_wire <= 1'b0;
			end else begin
				Halt_wire <= 1'b1;
			end
			if(twobit == 2'b11  && opcode_reg != 4'b0111 && opcode_reg != 4'b1101 && opcode_reg != 4'b1110 && opcode_reg != 4'b1111 && opcode_reg != 4'b1100) begin
				AS_BC_wire <= 1'b1;
			end else begin
				AS_BC_wire <= 1'b0;
			end
		end
	end
	assign MemRead = MemRead_wire;
	assign MemWrite = MemWrite_wire;
	assign RegWrite = RegWrite_wire;
	assign ALUSrc1 = ALUSrc1_wire;
	assign ALUSrc2 = ALUSrc2_wire;
	assign MemtoReg = MemtoReg_wire;
	assign Output = Output_wire;
	assign Input = Input_wire;
	assign ALUorShifter = ALUorShifter_wire;
	assign Halt = Halt_wire;
	assign opcode = opcode_wire;
	assign Branch = brch_wire;
	assign RegDst = reg_dst_wire;
	assign BranchCond = BranchCond_wire;
	assign AS_BC = AS_BC_wire;
endmodule