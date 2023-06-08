module ALU(
		input [3:0] ALUctl,
		input [15:0] A,B,
		output [15:0] Out,
		output [3:0] Outcond
		);
		wire [16:0] C;
		wire [3:0] cond;
		assign C[16:0] = (ALUctl == 4'b0000) ? A + B:
							  (ALUctl == 4'b0001) ? A - B:
							  (ALUctl == 4'b0010) ? {1'b0,A & B}:
							  (ALUctl == 4'b0011) ? {1'b0,A | B}:
							  (ALUctl == 4'b0100) ? {1'b0,A ^ B}:
							  (ALUctl == 4'b0101) ? A - B:
							  {1'b0,B};
		assign cond[3] = C[15];
		assign cond[2] = (C[15:0]==16'b0) ? 1'b1:
							   1'b0;
		assign cond[1] = C[16];
		assign cond[0] = (ALUctl == 4'b0000) ? (A[15] ~^ B[15]) & (A[15] ^ C[15]):
							  (ALUctl == 4'b0001) ? (A[15] ^ B[15]) & (A[15] ^ C[15]):
							  (ALUctl == 4'b0010) ? 1'b0:
							  (ALUctl == 4'b0011) ? 1'b0:
							  (ALUctl == 4'b0100) ? 1'b0:
							  (ALUctl == 4'b0101) ? (A[15] ^ B[15]) & (A[15] ^ C[15]):
							  1'b0;
		assign Outcond = cond;
		assign Out = C[15:0];
endmodule