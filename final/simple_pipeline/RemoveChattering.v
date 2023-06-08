module RemoveChattering (
	input clk, botton, rst_n,
	output reg signal);
	reg botton_reg1;
	reg botton_reg2;
	reg [50:0] count;
	always @(posedge clk or negedge rst_n) begin
			if (!rst_n)
				count <= 26'd0;
			else if (count == 26'd2_000_000)
				count <= 26'd0;
			else
				count <= count + 26'd1;
	end
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			botton_reg1 <= 1'b0;
			botton_reg2 <= 1'b0;
			signal <= 1'b0;
		end else if (count == 26'd1_000_000) begin
			botton_reg1 <= botton_reg2;
			botton_reg2 <= !botton;
			if (botton_reg1 == 1'b0 && botton_reg2 == 1'b1) begin
				signal <= !signal;
			end
		end else begin
			botton_reg1 <= botton_reg1;
			botton_reg2 <= botton_reg2;
			signal <= signal;
		end
	end
endmodule
