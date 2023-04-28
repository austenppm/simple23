module RegisterFile(
	input [2:0] Read1,Read2,WriteReg,
	input [15:0] WriteData,
	input clk,RegWrite,
	output [15:0] Data1,Data2,
	output [15:0] reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,reg_0);
	reg [15:0] RegFile [7:0];
	assign Data1 = RegFile [Read1];
	assign Data2 = RegFile [Read2];
	assign reg_0 = RegFile[0];
	assign reg_1 = RegFile[1];
	assign reg_2 = RegFile[2];
	assign reg_3 = RegFile[3];
	assign reg_4 = RegFile[4];
	assign reg_5 = RegFile[5];
	assign reg_6 = RegFile[6];
	assign reg_7 = RegFile[7];
	always @ (posedge clk) begin
		if(!RegWrite) begin
			RegFile [WriteReg] <= WriteData;
		end
	end
endmodule
