module phase3ctl(
	input ALUSrc1in,ALUSrc2in,ALUorshifterin,AS_BCin,
	input [3:0] opcodein,
	input clk,
	output ALUSrc1out,ALUSrc2out,ALUorshifterout,AS_BCout,
	output [3:0] opcodeout);
	always @ (posedge clk) begin
		if(!rst_n) begin
			ALUSrc1in
			ALUSrc2in
			ALUorshifterin
			AS_BCin
			opcodein
		end else begin
			DataOut <= WriteData;
		end
	end
endmodule