module ctl(
	input clk,rst_n,
	input [15:0] inst,
	output reg MemRead,MemWrite,RegWrite,ALUSrc1,ALUSrc2,MemtoReg,Output,Input,
	output reg [3:0] opcode,
	output reg [2:0] RegDst,
	output reg [2:0] Branch);
	reg [1:0] twobit;
	reg [3:0] opcode_reg;
	reg [15:0] inst_reg;
	reg [2:0] brch_reg;
	always @ (posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			inst_reg <= 16'b0000000000000000;
		end else begin
			inst_reg <= inst;
			twobit <= inst[15:14];
			opcode_reg <= inst[7:4];
			brch_reg <= inst[13:11];
			if (( twobit == 2'b11 && opcode != 4'b0111 && opcode != 4'b1101 && opcode != 4'b1110 && opcode != 4'b1111) || (twobit == 2'b00 ) || (twobit == 2'b10 && brch_reg == 3'b000)) begin
				RegWrite <= 1'b1;
			end else begin
				RegWrite <= 1'b0;
			end
			if(twobit == 2'b01 ) begin
				MemWrite <= 1'b1;
			end else begin
				MemWrite <= 1'b0;
			end
			if (twobit == 2'b00 ) begin
				MemRead <= 1'b1;
			end else begin
				MemRead <= 1'b0;
			end
			if ((twobit == 2'b11 && opcode_reg == 4'b1110) || (twobit == 2'b00))begin
				MemtoReg <= 1'b1;
			end else begin
				MemtoReg <= 1'b0;
			end
			if ( twobit == 2'b10 && brch_reg != 3'b00) begin
				ALUSrc1 <= 1'b1;
			end else begin
				ALUSrc1 <= 1'b0;
			end
			if(twobit ==2'b11 && (opcode_reg == 4'b0000 ||opcode_reg == 4'b0001 ||opcode_reg == 4'b0010 ||opcode_reg == 4'b0011 ||opcode_reg == 4'b0100 ||opcode_reg == 4'b0101 ||opcode_reg == 4'b0110)) begin
				ALUSrc2 <= 1'b0;
			end else begin
				ALUSrc2 <= 1'b1;
			end
			if(twobit == 2'b11 && opcode_reg == 4'b1101) begin
				Output <= 1'b1;
			end else begin
				Output <= 1'b0;
			end
			if(twobit == 2'b11 && opcode_reg == 4'b1100) begin
				Input <= 1'b1;
			end else begin
				Input <= 1'b0;
			end
		end
	end
endmodule
