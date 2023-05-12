module shifter #(
		parameter d = 4
		)
		(
		input [15:0] A,
		input [3:0] opcode,
		output [15:0] Out,
		output [3:0] Outcond
		);
		reg [31:0] C;
		reg [3:0] cond;
		always @(A,d,opcode) begin
			case (opcode)
				8: C <= A << d;
				9: begin
						C <= A << d;
					if (d!=3'b0)
						C[d-1:0] <= C[16+d:16];
					end
				10: C <= A >> d;
				11: C <= A >>> d;
			endcase
			if (d==0 || opcode ==3'd9) 
				cond[1] <= 1'b0;
			else 
				cond[1] <= C[16];
			if(C==16'b0)
				cond[2] <= 1'b1;
			else
				cond[2] <= 1'b0;
			cond[0] <= 1'b0;
			cond[3] <= C[15];
		end
		assign Out = C[15:0];
		assign Outcond = cond;
endmodule