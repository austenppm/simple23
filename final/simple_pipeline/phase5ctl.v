module phase5ctl(
	input MemtoRegin,RegWritein,
	input [2:0] RegDstin,
	input clk,rst_n,
	output reg MemtoRegout, RegWriteout,
	output reg [2:0] RegDstout);
	always @ (posedge clk) begin
		if(!rst_n) begin
			MemtoRegout <= 1'b0;
			RegWriteout <= 1'b0;
			RegDstout <= 3'b000;
		end else begin
			MemtoRegout <= MemtoRegin;
			RegWriteout <= RegWritein;
			RegDstout <= RegDstin;
		end
	end
endmodule