module RemoveChattering (
	input clk, botton, rst_n,
	output reg signal);
	wire clk_10Hz;
	reg botton_reg;
	reg [7:0] remove_chat;
	wire rst_n1,rst_n2,rst_n3;
	divider b2(.clk(clk),.hz(30'd10),.rst_n(rst_n),.outclk(clk_10Hz));
	assign rst_n1 = rst_n;
	assign rst_n2 = rst_n;
	assign rst_n3 = rst_n;
	always @ (posedge clk_10Hz or negedge rst_n2) begin
		if(!rst_n2) begin
			botton_reg <= 1'b0;
		end else begin
			botton_reg <= !botton;
		end
	end
	always @(posedge botton_reg or negedge rst_n3) begin
		if(!rst_n3) begin
			signal <= 1'b0;
		end else begin
			signal <= signal +1;
		end
	end
endmodule
