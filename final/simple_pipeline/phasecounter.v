module phasecounter(
			input clk,rst_n,ce,
			output reg [4:0] p
			);
			always @(posedge clk or negedge rst_n) begin
				if (!rst_n) begin
					p <= 5'b10000;
				end else begin
					if (ce==1'b1) begin
						if (p==5'b00001)
							p <= 5'b10000;
						else 
							p <= p >> 1;
					end
				end
			end  		
endmodule