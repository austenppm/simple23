module register2(
	input [3:0] WriteData,
	input clk,rst_n,
	output reg [3:0] DataOut);
	always @ (posedge clk) begin
		if(!rst_n) begin
			DataOut <= 4'b0000;
		end else begin
			DataOut <= WriteData;
		end
	end
endmodule

