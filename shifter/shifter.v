module shifter (
		input [15:0] A,
		input [3:0] opcode,
		input [3:0] d,
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
					case (d)
						1: C[0] <= C[16];
						2: C[1:0] <= C[18:16];
						3: C[2:0] <= C[19:16];
						4: C[3:0] <= C[20:16];
						5: C[4:0] <= C[21:16];
						6: C[5:0] <= C[22:16];
						7: C[6:0] <= C[23:16];
						8: C[7:0] <= C[24:16];
						9: C[8:0] <= C[25:16];
						10: C[9:0] <= C[26:16];
						11: C[10:0] <= C[27:16];
						12: C[11:0] <= C[28:16];
						13: C[12:0] <= C[29:16];
						14: C[13:0] <= C[30:16];
						15: C[14:0] <= C[31:16];
					endcase
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