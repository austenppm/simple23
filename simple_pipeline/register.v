module register(
	input [15:0] WriteData,
	input clk,rst_n,
	output reg [15:0] DataOut);
	always @ (posedge clk) begin
		if(!rst_n) begin
			DataOut <= 16'b0000000000000000;
		end else begin
			DataOut <= WriteData;
		end
	end
endmodule

