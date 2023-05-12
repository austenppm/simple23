`include "segLED.v"
`include "divider.v"

module counta2(
			input rst_n, clk,
			input [15:0] data,
			output [7:0] out2,
			output [3:0] sel2
			);
			reg [3:0] t;
			reg [3:0] sel;
			wire clk_300Hz;
			wire clk_10Hz;
			reg [4:0] c;
			segLED a0(.a(c), .selin(sel),.out(out2),.sel(sel2));
			divider b1(.clk(clk),.hz(30'd300),.rst_n(rst_n),.outclk(clk_300Hz));
		always @ (posedge clk_300Hz or negedge rst_n) begin
			if (!rst_n) begin
				t <= 4'd0000;
			end else begin
				t <= (t + 1) % 4;
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