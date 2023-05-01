module counter100000000 (
    input clock,
	 output reg [14:0] count);

	 initial begin
		count = 0;
	end

	 always @(posedge clock)
		begin
			if (count == 14'd9999)
				begin
					count <= 14'd0000;
				end
			else
				begin
					count <= count + 1;
				end
		end
endmodule