module forwardingunit (
	input EX_MEM_RegWrite,MEM_WB_RegWrite,
	input [2:0] EX_MEM_RegDst,MEM_WB_RegDst,ID_EX_RegisterRa,ID_EX_RegisterRb,
	output [1:0] ForwardA,ForwardB);
	assign ForWardA = ((EX_MEM_RegWrite == 1'b1) && (EX_MEM_RegDst == ID_EX_RegisterRa)) ? 2'b01:
							((MEM_WB_RegWrite == 1'b1) && ( MEM_WB_RegDst == ID_EX_RegisterRa))? 2'b10:
							2'b00;
							
	assign ForWardB = ((EX_MEM_RegWrite == 1'b1) && (EX_MEM_RegDst == ID_EX_RegisterRb)) ? 2'b01:
							((MEM_WB_RegWrite == 1'b1) && ( MEM_WB_RegDst == ID_EX_RegisterRb))? 2'b10:
							2'b00;
endmodule
