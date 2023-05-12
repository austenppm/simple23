module RegisterFile(
	input [2:0] Read1,Read2,WriteReg,
	input [15:0] WriteData,
	input clk,rst_n,RegWrite,
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
	always @ (posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			RegFile [0] <= 16'd0;
			RegFile [1] <= 16'd0;
			RegFile [2] <= 16'd0;
			RegFile [3] <= 16'd0;
			RegFile [4] <= 16'd0;
			RegFile [5] <= 16'd0;
			RegFile [6] <= 16'd0;
			RegFile [7] <= 16'd0;
		end else begin
			if(RegWrite==1'b1) begin
				RegFile [WriteReg] <= WriteData;
			end else begin
				RegFile [0] <= RegFile [0];
				RegFile [1] <= RegFile [1];
				RegFile [2] <= RegFile [2];
				RegFile [3] <= RegFile [3];
				RegFile [4] <= RegFile [4];
				RegFile [5] <= RegFile [5];
				RegFile [6] <= RegFile [6];
				RegFile [7] <= RegFile [7];
			end
		end
	end
endmodule
