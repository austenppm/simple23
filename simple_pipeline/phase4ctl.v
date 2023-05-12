module phase4ctl(
	input MemWritein, Inputin,
	input [2:0] Branchin,
	input clk,rst_n,
	output reg MemWriteout, Inputout,
	output reg [2:0] Branchout);
	always @ (posedge clk) begin
		if(!rst_n) begin
			MemWriteout <= 1'b0;
			Inputout <= 1'b0;
			Branchout <= 3'b000;
		end else begin
			MemWriteout <= MemWritein;
			Inputout <= Inputin;
			Branchout <= Branchin;
		end
	end
endmodule