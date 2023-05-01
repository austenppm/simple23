module display(
	input	sl_clk,rst,
	input [15:0] reg_0,reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,
	output reg [7:0] disp_1,disp_2,disp_3,disp_4,disp_5,disp_6,disp_7,disp_8,
	output [3:0] sl_out);
	wire [15:0] wire_reg0,wire_reg1,wire_reg2,wire_reg3,wire_reg4,wire_reg5,wire_reg6,wire_reg7;
	wire [7:0] disp_reg1_1,disp_reg1_2,disp_reg1_3,disp_reg1_4,disp_reg2_1,disp_reg2_2,disp_reg2_3,disp_reg2_4,disp_reg3_1,disp_reg3_2,disp_reg3_3,disp_reg3_4,disp_reg4_1,disp_reg4_2,disp_reg4_3,disp_reg4_4,disp_reg5_1,disp_reg5_2,disp_reg5_3,disp_reg5_4,disp_reg6_1,disp_reg6_2,disp_reg6_3,disp_reg6_4,disp_reg7_1,disp_reg7_2,disp_reg7_3,disp_reg7_4,disp_reg0_1,disp_reg0_2,disp_reg0_3,disp_reg0_4;
	wire sl_clk_wire,sl_rst_wire;
//	wire [3:0] sl_wire;
	wire clk_300Hz;
	reg [3:0] t;
	reg [3:0] sel;
	assign wire_reg0 = reg_0;
	assign wire_reg1 = reg_1;
	assign wire_reg2 = reg_2;
	assign wire_reg3 = reg_3;
	assign wire_reg4 = reg_4;
	assign wire_reg5 = reg_5;
	assign wire_reg6 = reg_6;
	assign wire_reg7 = reg_7;
	assign sl_clk_wire = sl_clk;
	assign sl_rst_wire = rst;
//	select_counter sl(.rst_n(sl_rst_wire), .clk(sl_clk_wire), .selecter(sl_wire));
	divider b1(.clk(sl_clk_wire),.hz(30'd300),.rst_n(sl_rst_wire),.outclk(clk_300Hz));
	number reg0(.data_sig(wire_reg0), .disp_out1(disp_reg0_1), .disp_out2(disp_reg0_2), .disp_out3(disp_reg0_3), .disp_out4(disp_reg0_4));
	number reg1(.data_sig(wire_reg1), .disp_out1(disp_reg1_1), .disp_out2(disp_reg1_2), .disp_out3(disp_reg1_3), .disp_out4(disp_reg1_4));
	number reg2(.data_sig(wire_reg2), .disp_out1(disp_reg2_1), .disp_out2(disp_reg2_2), .disp_out3(disp_reg2_3), .disp_out4(disp_reg2_4));
	number reg3(.data_sig(wire_reg3), .disp_out1(disp_reg3_1), .disp_out2(disp_reg3_2), .disp_out3(disp_reg3_3), .disp_out4(disp_reg3_4));
	number reg4(.data_sig(wire_reg4), .disp_out1(disp_reg4_1), .disp_out2(disp_reg4_2), .disp_out3(disp_reg4_3), .disp_out4(disp_reg4_4));
	number reg5(.data_sig(wire_reg5), .disp_out1(disp_reg5_1), .disp_out2(disp_reg5_2), .disp_out3(disp_reg5_3), .disp_out4(disp_reg5_4));
	number reg6(.data_sig(wire_reg6), .disp_out1(disp_reg6_1), .disp_out2(disp_reg6_2), .disp_out3(disp_reg6_3), .disp_out4(disp_reg6_4));
	number reg7(.data_sig(wire_reg7), .disp_out1(disp_reg7_1), .disp_out2(disp_reg7_2), .disp_out3(disp_reg7_3), .disp_out4(disp_reg7_4));
	assign sl_out = sel;
	always @ (posedge clk_300Hz or negedge sl_rst_wire) begin
			if (!sl_rst_wire) begin
				t <= 4'd0000;
			end else begin
				t <= (t + 1) % 16;
				sel[3] <= (t == 2) ? 1:
							 (t == 4) ? 0:
							 sel[3];
				sel[2] <= (t == 6) ? 1:
							 (t == 8) ? 0:
							 sel[2];
				sel[1] <= (t == 10) ? 1:
							 (t == 12) ? 0:
							 sel[1];
				sel[0] <= (t == 14) ? 1:
							 (t == 0) ? 0:
							 sel[0];
				disp_1 <=(t == 1)? disp_reg0_4:
						(t == 5)? disp_reg2_4:
						(t == 9)? disp_reg4_4:
						(t == 13)? disp_reg6_4:
						disp_1;
				disp_2 <=(t == 1)? disp_reg0_3:
						(t == 5)? disp_reg2_3:
						(t == 9)? disp_reg4_3:
						(t == 13)? disp_reg6_3:
						disp_2;
				disp_3 <=(t == 1)? disp_reg0_2:
						(t == 5)? disp_reg2_2:
						(t == 9)? disp_reg4_2:
						(t == 13)? disp_reg6_2:
						disp_3;
				disp_4 <=(t == 1)? disp_reg0_1:
						(t == 5)? disp_reg2_1:
						(t == 9)? disp_reg4_1:
						(t == 13)? disp_reg6_1:
						disp_4;
				disp_5 <=(t == 1)? disp_reg1_4:
						(t == 5)? disp_reg3_4:
						(t == 9)? disp_reg5_4:
						(t == 13)? disp_reg7_4:
						disp_5;
				disp_6 <=(t == 1)? disp_reg1_3:
						(t == 5)? disp_reg3_3:
						(t == 9)? disp_reg5_3:
						(t == 13)? disp_reg7_3:
						disp_6;
				disp_7 <=(t == 1)? disp_reg1_2:
						(t == 5)? disp_reg3_2:
						(t == 9)? disp_reg5_2:
						(t == 13)? disp_reg7_2:
						disp_7;
				disp_8 <=(t == 1)? disp_reg1_1:
						(t == 5)? disp_reg3_1:
						(t == 9)? disp_reg5_1:
						(t == 13)? disp_reg7_1:
						disp_8;
			end
		end
//	assign disp_1 =(sl_wire == 4'b1000)? disp_reg0_4:
//						(sl_wire == 4'b0100)? disp_reg2_4:
//						(sl_wire == 4'b0010)? disp_reg4_4:
//						disp_reg6_4;
//	assign disp_2 =(sl_wire == 4'b1000)? disp_reg0_3:
//						(sl_wire == 4'b0100)? disp_reg2_3:
//						(sl_wire == 4'b0010)? disp_reg4_3:
//						disp_reg6_3;
//	assign disp_3 =(sl_wire == 4'b1000)? disp_reg0_2:
//						(sl_wire == 4'b0100)? disp_reg2_2:
//						(sl_wire == 4'b0010)? disp_reg4_2:
//						disp_reg6_2;
//	assign disp_4 =(sl_wire == 4'b1000)? disp_reg0_1:
//						(sl_wire == 4'b0100)? disp_reg2_1:
//						(sl_wire == 4'b0010)? disp_reg4_1:
//						disp_reg6_1;
//	assign disp_5 =(sl_wire == 4'b1000)? disp_reg1_4:
//						(sl_wire == 4'b0100)? disp_reg3_4:
//						(sl_wire == 4'b0010)? disp_reg5_4:
//						disp_reg7_4;
//	assign disp_6 =(sl_wire == 4'b1000)? disp_reg1_3:
//						(sl_wire == 4'b0100)? disp_reg3_3:
//						(sl_wire == 4'b0010)? disp_reg5_3:
//						disp_reg7_3;
//	assign disp_7 =(sl_wire == 4'b1000)? disp_reg1_2:
//						(sl_wire == 4'b0100)? disp_reg3_2:
//						(sl_wire == 4'b0010)? disp_reg5_2:
//						disp_reg7_2;
//	assign disp_8 =(sl_wire == 4'b1000)? disp_reg1_1:
//						(sl_wire == 4'b0100)? disp_reg3_1:
//						(sl_wire == 4'b0010)? disp_reg5_1:
//						disp_reg7_1;
	
endmodule


module SEVENSEG_LED (
	input [3:0] a,
	output [7:0] output_signal);
	assign output_signal = (a == 4'b0000) ? 8'b1111_1100:
									 (a == 4'b0001) ? 8'b0110_0000:
									 (a == 4'b0010) ? 8'b1101_1010:
									 (a == 4'b0011) ? 8'b1111_0010:
									 (a == 4'b0100) ? 8'b0110_0110:
									 (a == 4'b0101) ? 8'b1011_0110:
									 (a == 4'b0110) ? 8'b1011_1110:
									 (a == 4'b0111) ? 8'b1110_0000:
									 (a == 4'b1000) ? 8'b1111_1110:
									 (a == 4'b1001) ? 8'b1111_0110:
									 (a == 4'b1010) ? 8'b1110_1110:
									 (a == 4'b1011) ? 8'b0011_1110:
									 (a == 4'b1100) ? 8'b0001_1010:
									 (a == 4'b1101) ? 8'b0111_1010:
									 (a == 4'b1110) ? 8'b1001_1110:
									 8'b1000_1110;
								  
endmodule


//module select_counter(
//	input rst_n,clk,
//	output reg [3:0] selecter);
//	wire clk_300Hz;
//	divider b1(.clk(clk),.hz(30'd300),.rst_n(rst_n),.outclk(clk_300Hz));
//	always @ (posedge clk_300Hz or negedge rst_n) begin
//		if(!rst_n) begin
//			selecter <= 4'b0000;
//		end else begin
//			selecter = (selecter == 4'b0100)?4'b1000:
//						  (selecter == 4'b0010)?4'b0100:
//						  (selecter == 4'b0001)?4'b0010:
//						  4'b0001;
//		end
//	end
//	
//endmodule


module number( //16ビットの値を入力として四ケタずつの値（１６進数）を返す
	input [15:0] data_sig,
	output [7:0] disp_out1,disp_out2,disp_out3,disp_out4);
	wire n_wire_clk,n_wire_rst;
	wire [7:0] disp_wire1,disp_wire2,disp_wire3,disp_wire4;
	wire [3:0] data_wire1,data_wire2,data_wire3,data_wire4;
	assign data_wire1 = data_sig [3:0]; //___O
	assign data_wire2 = data_sig [7:4]; //__O_
	assign data_wire3 = data_sig [11:8]; //_O__
	assign data_wire4 = data_sig [15:12]; //O___
	SEVENSEG_LED l1(.a(data_wire1), .output_signal(disp_wire1));
	SEVENSEG_LED l2(.a(data_wire2), .output_signal(disp_wire2));
	SEVENSEG_LED l3(.a(data_wire3), .output_signal(disp_wire3));
	SEVENSEG_LED l4(.a(data_wire4), .output_signal(disp_wire4));
	assign disp_out1 =  disp_wire1;
	assign disp_out2 =  disp_wire2;
	assign disp_out3 =  disp_wire3;
	assign disp_out4 =  disp_wire4;
	
endmodule


//module display(
//	input [15:0] reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,reg_0,
//	output [7:0] disp_1,disp_2,disp_3,disp_4,disp_5,disp_6,disp_7,disp_8,
//	output selecter);
//	wire [15:0] wire_reg1,wire_reg2,wire_reg3,wire_reg4,wire_reg5,wire_reg6,wire_reg7,wire_reg0;
//	wire [7:0] disp_reg1_1,disp_reg2_1,disp_reg3_1,disp_reg4_1,disp_reg5_1,disp_reg6_1,disp_reg7_1,disp_reg0_1;
//	assign wire_reg0 = reg_0;
//	assign wire_reg1 = reg_1;
//	assign wire_reg2 = reg_2;
//	assign wire_reg3 = reg_3;
//	assign wire_reg4 = reg_4;
//	assign wire_reg5 = reg_5;
//	assign wire_reg6 = reg_6;
//	assign wire_reg7 = reg_7;
//
//	number reg1(.data_sig(wire_reg1), .disp_out1(disp_reg1_1));
//	number reg2(.data_sig(wire_reg2), .disp_out1(disp_reg2_1));
//	number reg3(.data_sig(wire_reg3), .disp_out1(disp_reg3_1));
//	number reg4(.data_sig(wire_reg4), .disp_out1(disp_reg4_1));
//	number reg5(.data_sig(wire_reg5), .disp_out1(disp_reg5_1));
//	number reg6(.data_sig(wire_reg6), .disp_out1(disp_reg6_1));
//	number reg7(.data_sig(wire_reg7), .disp_out1(disp_reg7_1));
//	number reg0(.data_sig(wire_reg0), .disp_out1(disp_reg0_1));
//	assign disp_1 =disp_reg1_1;
//	assign disp_2 =disp_reg2_1;
//	assign disp_3 =disp_reg3_1;
//	assign disp_4 =disp_reg4_1;
//	assign disp_5 =disp_reg5_1;
//	assign disp_6 =disp_reg6_1;
//	assign disp_7 =disp_reg7_1;
//	assign disp_8 =disp_reg0_1;
//	assign selecter = 1'b1;
//endmodule
//
//
//module SEVENSEG_LED (
//	input [3:0] a,
//	output [7:0] output_signal);
////	assign output_signal = (a == 4'b0000) ? 8'b1111_1100:
////									 (a == 4'b0001) ? 8'b0110_0000:
////									 (a == 4'b0010) ? 8'b0010_1010:
////									 (a == 4'b0011) ? 8'b1111_0010:
////									 (a == 4'b0100) ? 8'b0110_0110:
////									 (a == 4'b0101) ? 8'b0100_0110:
////									 (a == 4'b0110) ? 8'b0100_1110:
////									 (a == 4'b1000) ? 8'b1110_0000:
////									 (a == 4'b1000) ? 8'b1111_1110:
////									 (a == 4'b1001) ? 8'b1111_0110:
////									 (a == 4'b1010) ? 8'b1110_1110:
////									 (a == 4'b0100) ? 8'b0011_1110:
////									 (a == 4'b1100) ? 8'b0001_1010:
////									 (a == 4'b0010) ? 8'b1000_1010:
////									 (a == 4'b1110) ? 8'b1001_1110:
////									 8'b1000_1110;
//	assign output_signal = (a == 4'b0000) ? 8'b1111_1100:
//									 (a == 4'b0001) ? 8'b0110_0000:
//									 (a == 4'b0010) ? 8'b1101_1010:
//									 (a == 4'b0011) ? 8'b1111_0010:
//									 (a == 4'b0100) ? 8'b0110_0110:
//									 (a == 4'b0101) ? 8'b1011_0110:
//									 (a == 4'b0110) ? 8'b1011_1110:
//									 (a == 4'b0111) ? 8'b1110_0000:
//									 (a == 4'b1000) ? 8'b1111_1110:
//									 (a == 4'b1001) ? 8'b1111_0110:
//									 (a == 4'b1010) ? 8'b1110_1110:
//									 (a == 4'b1011) ? 8'b0011_1110:
//									 (a == 4'b1100) ? 8'b0001_1010:
//									 (a == 4'b1101) ? 8'b0111_1010:
//									 (a == 4'b1110) ? 8'b1001_1110:
//									 8'b1000_1110;
//endmodule
//
//
//module number(
//	input [15:0] data_sig,
//	output [7:0] disp_out1);
//	wire [7:0] disp_wire1;
//	wire [3:0] data_wire1;
//	assign data_wire1 = data_sig [3:0];
//	SEVENSEG_LED l1(.a(data_wire1[3:0]), .output_signal(disp_wire1[7:0]));
//	assign disp_out1 =  disp_wire1;
//	
//endmodule