module phase3ctl(
	input ALUSrc1in,ALUSrc2in,ALUorshifterin,AS_BCin,MemReadin,
	input [2:0] Rain,Rbin,
	input [3:0] opcodein,
	input clk,rst_n,
	output reg ALUSrc1out,ALUSrc2out,ALUorshifterout,AS_BCout,MemReadout,
	output reg Raout,Rbout,
	output reg [3:0] opcodeout);
	always @ (posedge clk) begin
		if(!rst_n) begin
			ALUSrc1out <= 1'b0;
			ALUSrc2out <= 1'b0;
			ALUorshifterout <= 1'b0;
			AS_BCout <= 1'b0;
			opcodeout <= 4'b0000;
			MemReadout <= 1'b0;
			Raout <= 3'b000;
			Rbout <= 3'b000;
		end else begin
			ALUSrc1out <= ALUSrc1in;
			ALUSrc2out <= ALUSrc2in;
			ALUorshifterout <= ALUorshifterin;
			AS_BCout <= AS_BCin;
			opcodeout <= opcodein;
			MemReadout <= MemReadin;
			Raout <= Rain;
			Rbout <= Rbin;
		end
	end
endmodule