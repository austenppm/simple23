module chattercounter(
	input clock,
	input switch,
	output reg ispressed );

	reg [3:0] count;

	initial begin
		count = 4'b0000;
	end

	// count switch pressed time
	always @(posedge clock) begin
		if ( !switch ) begin // if switch is pressed
			count <= count + 1;
		end
		else begin
			count <= 4'b0000;
		end
	end

	// if switch is pressed for long
	always @(posedge clock) begin
		if (count == 4'b0011) begin
			ispressed <= 1;
		end

		if (count == 0) begin
			ispressed <= 0;
		end
	end

endmodule