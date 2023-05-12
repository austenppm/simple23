module RegisterFile(
input [2:0] Read1,Read2,WriteReg,
	input [15:0] WriteData,
	input clk,RegWrite,
	output [15:0] Data1,Data2);
	reg [15:0] RegFile [7:0];
	assign Data1 = RegFile [Read1];
	assign Data2 = RegFile [Read2];
	always @ (posedge clk) begin
		if(!RegWrite) begin
			RegFile [WriteReg] <= WriteData;
		end
	end
endmodule
