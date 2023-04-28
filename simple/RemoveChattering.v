module RemoveChattering (
	input clk, botton, rst_n,
	output reg signal);
	reg ten_hz_clk;
	reg botton_reg;
	reg [7:0] remove_chat;
	wire rst_n1,rst_n2,rst_n3;
	assign rst_n1 = rst_n;
	assign rst_n2 = rst_n;
	assign rst_n3 = rst_n;
	always @(posedge clk or negedge rst_n1) begin
		if(!rst_n1) begin
			remove_chat <= 7'd0000000;
			ten_hz_clk <= 1'b0;
		end else begin
			remove_chat <= remove_chat +1;
			if(remove_chat ==7'd2000000) begin
				ten_hz_clk <= ten_hz_clk +1;
				remove_chat <= 7'd0000000;
			end else begin
				ten_hz_clk <= ten_hz_clk;
			end
		end
	end
	always @ (posedge ten_hz_clk or negedge rst_n2) begin
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
