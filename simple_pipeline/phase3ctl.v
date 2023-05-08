module phase3ctl(
	input ALUSrc1in,ALUSrc2in,ALUorshifterin,AS_BCin,
	input [3:0] opcodein,
	input clk,
	output ALUSrc1out,ALUSrc2out,ALUorshifterout,AS_BCout,
	output [3:0] opcodeout);
	always @ (posedge clk) begin
		if(!rst_n) begin
			ALUSrc1out <= 1'b0;
			ALUSrc2out <= 1'b0;
			ALUorshifterout <= 1'b0;
			AS_BCout <= 1'b0;
			opcodeout <= 47b0000;
		end else begin
			ALUSrc1out <= ALUSrc1in;
			ALUSrc2out <= ALUSrc2in;
			ALUorshifterout <= ALUorshifterin;
			AS_BCout <= AS_BCin;
			opcodeout <= opcodein;
		end
	end
endmodule