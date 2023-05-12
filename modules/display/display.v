module display(
	input	pin,
	input [15:0] reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,reg_0,
	output [7:0] disp_1,disp_2,disp_3,disp_4,disp_5,disp_6,disp_7,disp_0,
	output selecter);
	wire [15:0] wire_reg1,wire_reg2,wire_reg3,wire_reg4,wire_reg5,wire_reg6,wire_reg7,wire_reg0;
	wire [7:0] disp_reg1_1,disp_reg2_1,disp_reg3_1,disp_reg4_1,disp_reg5_1,disp_reg6_1,disp_reg7_1,disp_reg0_1;
	assign wire_reg0 = reg_0;
	assign wire_reg1 = reg_1;
	assign wire_reg2 = reg_2;
	assign wire_reg3 = reg_3;
	assign wire_reg4 = reg_4;
	assign wire_reg5 = reg_5;
	assign wire_reg6 = reg_6;
	assign wire_reg7 = reg_7;

	number reg1(.data_sig(wire_reg1), .disp_out1(disp_reg1_1));
	number reg2(.data_sig(wire_reg2), .disp_out1(disp_reg2_1));
	number reg3(.data_sig(wire_reg3), .disp_out1(disp_reg3_1));
	number reg4(.data_sig(wire_reg4), .disp_out1(disp_reg4_1));
	number reg5(.data_sig(wire_reg5), .disp_out1(disp_reg5_1));
	number reg6(.data_sig(wire_reg6), .disp_out1(disp_reg6_1));
	number reg7(.data_sig(wire_reg7), .disp_out1(disp_reg7_1));
	number reg0(.data_sig(wire_reg0), .disp_out1(disp_reg0_1));
	assign disp_1 =disp_reg1_1;
	assign disp_2 =disp_reg2_1;
	assign disp_3 =disp_reg3_1;
	assign disp_4 =disp_reg4_1;
	assign disp_5 =disp_reg5_1;
	assign disp_6 =disp_reg6_1;
	assign disp_7 =disp_reg7_1;
	assign disp_0 =disp_reg0_1;
	assign selecter = pin;
endmodule


module SEVENSEG_LED (
	input [3:0] a,
	output [7:0] output_signal);
	assign output_signal = (a == 4'b0000) ? 8'b1111_1100:
									 (a == 4'b0001) ? 8'b0110_0000:
									 (a == 4'b0010) ? 8'b0010_1010:
									 (a == 4'b0011) ? 8'b1111_0010:
									 (a == 4'b0100) ? 8'b0110_0110:
									 (a == 4'b0101) ? 8'b0100_0110:
									 (a == 4'b0110) ? 8'b0100_1110:
									 (a == 4'b1000) ? 8'b1110_0000:
									 (a == 4'b1000) ? 8'b1111_1110:
									 (a == 4'b1001) ? 8'b1111_0110:
									 (a == 4'b1010) ? 8'b1110_1110:
									 (a == 4'b0100) ? 8'b0011_1110:
									 (a == 4'b1100) ? 8'b0001_1010:
									 (a == 4'b0010) ? 8'b1000_1010:
									 (a == 4'b1110) ? 8'b1001_1110:
									 8'b1000_1110;
								  
endmodule


module number(
	input [15:0] data_sig,
	output [7:0] disp_out1);
	wire [7:0] disp_wire1;
	wire [3:0] data_wire1;
	assign data_wire1 = data_sig [3:0];
	SEVENSEG_LED l1(.a(data_wire1[3:0]), .output_signal(disp_wire1[7:0]));
	assign disp_out1 =  disp_wire1;
	
endmodule
