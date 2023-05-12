module finding_hazard (
	input ID_EX_MemRead,
	input [2:0] ID_EX_RegisterRa,IF_ID_RegisterRa,IF_ID_RegisterRb,
	output hazard_ctl
	); 
	assign hazard_ctl = (( ID_EX_MemRead == 1'b1) && ( ID_EX_RegisterRa == IF_ID_RegisterRa||IF_ID_RegisterRb)) ? 1'b0:
							  1'b1;
							  
endmodule
	