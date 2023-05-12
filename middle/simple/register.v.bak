module register(
	input [15:0] WriteData,
	input clk,rst_n,
	output reg [15:0] DataOut);
	reg [15:0] RegData;
	always @ (posedge clk) begin
		if(!rst_n) begin
			RegData <= 16'b0000000000000000;
		end else begin
			DataOut <= RegData;
			RegData <= WriteData;
		end
	end
endmodule

