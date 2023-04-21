module phasecounter(
			input clk,rst_n,
			output reg [4:0] p
			);
			reg [2:0] count;
			always @(posedge clk or negedge rst_n) begin
				if (!rst_n) begin
					count <= 0;
				end else begin
					count <= (count + 1) % 5;
					if (count==3'd4)
						p <= 5'b10000;
					else 
						p <= p >> 1;
				end
			end  		
endmodule