module ALU(
		input [3:0] ALUctl,
		input [15:0] A,B,
		output [15:0] Out,
		output [3:0] Outcond
		);
		reg [16:0] C;
		reg [3:0] cond;
		always @(ALUctl,A,B) begin
			case (ALUctl)
				0: begin
						C <= A + B;
					if(A[15]==B[15] && A[15]!=C[15])
						cond[0] <= 1'b1;
					else
						cond[0] <= 1'b0;
					end
				1: begin
						C <= A - B;
					if(A[15]!=B[15] && A[15]!=C[15])
						cond[0] <= 1'b1;
					else
						cond[0] <= 1'b0;
					end
				2: C[15:0] <= A & B;
				3: C[15:0] <= A | B;
				4: C[15:0] <= A ^ B;
				5: begin
						C <= A - B;
					if(A[15]!=B[15] && A[15]!=C[15])
						cond[0] <= 1'b1;
					else
						cond[0] <= 1'b0;
					end
				6: begin 
						C[15:0] <= B;
						C[16] <= 1'b0;
					end
			endcase
			
			if(C==16'b0)
				cond[2] <= 1'b1;
			else
				cond[2] <= 1'b0;
			cond[3] <= C[15];
			cond[1] <= C[16];
		end
		assign Outcond = cond;
		assign Out = C[15:0];
endmodule