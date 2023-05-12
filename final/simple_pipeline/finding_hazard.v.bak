module finding_hazard (
	input ID_EX_MemRead,
	input [2:0] ID_EX_RegisterRa,IF_ID_RegisterRa,IF_ID_RegisterRb,
	output [20:0] hazard_ctl,
	output pc_stop); // 0 means pc is stopping and 1 means pc is moving
	assign {hazard_ctl,pc_stop}  = (( ID_EX_MemRead == 1'b1) && ( ID_EX_RegisterRa == IF_ID_RegisterRa||IF_ID_RegisterRb)) ? 22'b00000000000000000000:
							  22'b1111111111111111111111;
							  
endmodule
	