module counta2(
			input rst_n, clk,
			input [15:0] data,
			output [7:0] out2,
			output [3:0] sel2
			);
			reg [3:0] t;
			reg [3:0] sel;
			reg [30:0] c;
			segLED a0(.a(c), .selin(sel),.out(out2),.sel(sel2));
			reg [25:0] count;
			always @(posedge clk or negedge rst_n) begin
				if (!rst_n)
					count <= 26'h0;
				else if (count == (26'd20_000_000 / 300))
					count <= 26'h0;
				else
					count <= count + 26'h1;
			end
			always @(posedge clk or negedge rst_n) begin
				if (!rst_n)
					t <= 4'd0000;
				else if (count == (26'd10_000_000 / 300)) begin
					t <= (t + 1) % 4;
				end else begin
					t <= t;
				end
			end
			always @(posedge clk or negedge rst_n) begin
				if (!rst_n) begin
					sel <= 4'd0000;
					c <= 0;
				end else begin
					sel <= (t == 4'b0000) ? 4'b1110:
							(t == 4'b0001) ? 4'b1101:
							(t == 4'b0010) ? 4'b1011:
							4'b0111;
					c <= (t == 4'b0000) ? data % 10:
						 (t == 4'b0001) ? (data/10) % 10:
						 (t == 4'b0010) ? (data/100) % 10:
						 (data/1000) % 10;
				end
			end
endmodule