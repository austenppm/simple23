module branch(
	input [3:0] cond,
	input [2:0] brch,
	output brch_sig);
	wire s,z,c,v;
	assign s = cond[3];
	assign z = cond[2];
	assign c = cond[1];
	assign v = cond[0];
	assign brch_sig = (((brch == 3'b100))||((brch == 3'b000 && z == 1'b1 ))||((brch == 3'b001 && s ^ v == 1'b1 )) || (brch == 3'b010 && (z == 1'b1 || s ^ v == 1'b1)) || (( brch == 3'b011 && z == 1'b0))) ? 1'b1:
							1'b0;
endmodule
	