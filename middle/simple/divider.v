module divider (
		input clk, rst_n,
		input [30:0] hz,
		output outclk
		);
		reg [25:0] count;
		reg c;
		always @(posedge clk or negedge rst_n) begin
			if (!rst_n)
				count <= 26'h0;
			else if (count == (26'd20_000_000 / hz))
				count <= 26'h0;
			else
				count <= count + 26'h1;
		end
		always @(posedge clk or negedge rst_n) begin
			if (!rst_n)
				c <= 1'b0;
			else if (count == (26'd10_000_000 / hz))
				c <= 1'b1;
			else if (count == (26'd20_000_000 / hz))
				c <= 1'b0;
			else
				c <= c;
		end
		assign outclk = c;
endmodule