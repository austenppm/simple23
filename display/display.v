module display(
	input	sl_clk,rst,
	input [15:0] reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,reg_0,
	output [7:0] disp_1,disp_2,disp_3,disp_4,disp_5,disp_6,disp_7,disp_8,
	output [3:0] sl_out);
	wire [15:0] wire_reg1,wire_reg2,wire_reg3,wire_reg4,wire_reg5,wire_reg6,wire_reg7,wire_reg0;
	wire [7:0] disp_reg1_1,disp_reg1_2,disp_reg1_3,disp_reg1_4,disp_reg2_1,disp_reg2_2,disp_reg2_3,disp_reg2_4,disp_reg3_1,disp_reg3_2,disp_reg3_3,disp_reg3_4,disp_reg4_1,disp_reg4_2,disp_reg4_3,disp_reg4_4,disp_reg5_1,disp_reg5_2,disp_reg5_3,disp_reg5_4,disp_reg6_1,disp_reg6_2,disp_reg6_3,disp_reg6_4,disp_reg7_1,disp_reg7_2,disp_reg7_3,disp_reg7_4,disp_reg0_1,disp_reg0_2,disp_reg0_3,disp_reg0_4;
	wire sl_clk_wire,sl_rst_wire;
	wire [3:0] sl_wire;
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
	select_counter sl(.rst_n(sl_rst_wire), .clk(sl_clk_wire), .selecter(sl_wire));
	number reg1(.data_sig(wire_reg1), .disp_out1(disp_reg1_1), .disp_out2(disp_reg1_2), .disp_out3(disp_reg1_3), .disp_out4(disp_reg1_4));
	number reg2(.data_sig(wire_reg2), .disp_out1(disp_reg2_1), .disp_out2(disp_reg2_2), .disp_out3(disp_reg2_3), .disp_out4(disp_reg2_4));
	number reg3(.data_sig(wire_reg3), .disp_out1(disp_reg3_1), .disp_out2(disp_reg3_2), .disp_out3(disp_reg3_3), .disp_out4(disp_reg3_4));
	number reg4(.data_sig(wire_reg4), .disp_out1(disp_reg4_1), .disp_out2(disp_reg4_2), .disp_out3(disp_reg4_3), .disp_out4(disp_reg4_4));
	number reg5(.data_sig(wire_reg5), .disp_out1(disp_reg5_1), .disp_out2(disp_reg5_2), .disp_out3(disp_reg5_3), .disp_out4(disp_reg5_4));
	number reg6(.data_sig(wire_reg6), .disp_out1(disp_reg6_1), .disp_out2(disp_reg6_2), .disp_out3(disp_reg6_3), .disp_out4(disp_reg6_4));
	number reg7(.data_sig(wire_reg7), .disp_out1(disp_reg7_1), .disp_out2(disp_reg7_2), .disp_out3(disp_reg7_3), .disp_out4(disp_reg7_4));
	number reg0(.data_sig(wire_reg0), .disp_out1(disp_reg0_1), .disp_out2(disp_reg0_2), .disp_out3(disp_reg0_3), .disp_out4(disp_reg0_4));
	assign sl_out = sl_wire;
	assign disp_1 =(sl_wire == 4'b0111)? disp_reg0_4:
						(sl_wire == 4'b1011)? disp_reg2_4:
						(sl_wire == 4'b1101)? disp_reg4_4:
						disp_reg6_4;
	assign disp_2 =(sl_wire == 4'b0111)? disp_reg0_3:
						(sl_wire == 4'b1011)? disp_reg2_3:
						(sl_wire == 4'b1101)? disp_reg4_3:
						disp_reg6_3;
	assign disp_3 =(sl_wire == 4'b0111)? disp_reg0_2:
						(sl_wire == 4'b1011)? disp_reg2_2:
						(sl_wire == 4'b1101)? disp_reg4_2:
						disp_reg6_2;
	assign disp_4 =(sl_wire == 4'b0111)? disp_reg0_1:
						(sl_wire == 4'b1011)? disp_reg2_1:
						(sl_wire == 4'b1101)? disp_reg4_1:
						disp_reg6_1;
	assign disp_5 =(sl_wire == 4'b0111)? disp_reg1_4:
						(sl_wire == 4'b1011)? disp_reg3_4:
						(sl_wire == 4'b1101)? disp_reg5_4:
						disp_reg7_4;
	assign disp_6 =(sl_wire == 4'b0111)? disp_reg1_3:
						(sl_wire == 4'b1011)? disp_reg3_3:
						(sl_wire == 4'b1101)? disp_reg5_3:
						disp_reg7_3;
	assign disp_7 =(sl_wire == 4'b0111)? disp_reg1_2:
						(sl_wire == 4'b1011)? disp_reg3_2:
						(sl_wire == 4'b1101)? disp_reg5_2:
						disp_reg7_2;
	assign disp_8 =(sl_wire == 4'b0111)? disp_reg1_1:
						(sl_wire == 4'b1011)? disp_reg3_1:
						(sl_wire == 4'b1101)? disp_reg5_1:
						disp_reg7_1;
	
endmodule


module SEVENSEG_LED (
    input [3:0] input_signal,
    output [7:0] output_signal);
    assign output_signal = (input_signal == 4'b0000)?8'b11111100:
                                      (input_signal == 4'b0001)?8'b01100000:
                                      (input_signal == 4'b0010)?8'b11011010:
                                      (input_signal == 4'b0011)?8'b11110010:
                                      (input_signal == 4'b0100)?8'b01100110:
                                      (input_signal == 4'b0101)?8'b10110110:
                                      (input_signal == 4'b0110)?8'b10111110:
                                      (input_signal == 4'b0111)?8'b11100000:
                                      (input_signal == 4'b1000)?8'b11111110:
                                      (input_signal == 4'b1001)?8'b11110110:
                                      (input_signal == 4'b1010)?8'b11101110:
                                      (input_signal == 4'b1011)?8'b00111110:
                                      (input_signal == 4'b1100)?8'b10001110:
                                      (input_signal == 4'b1101)?8'b01111010:
                                      (input_signal == 4'b1110)?8'b10011110:
                                      (input_signal == 4'b1111)?8'b10001110:
                                      8'b10000000;

endmodule


module select_counter(
	input rst_n,clk,
	output reg [3:0] selecter);
	always @ (posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			selecter <= 4'b0000;
		end else begin
			selecter = ( selecter == 4'b1011)?4'b0111:
						  (selecter == 4'b1101)?4'b1011:
						  (selecter == 4'b1110)?4'b1101:
						  4'b1110;
			
		end
	end
endmodule


module number(
	input [15:0] data_sig,
	output [7:0] disp_out1,disp_out2,disp_out3,disp_out4);
	wire n_wire_clk,n_wire_rst;
	wire [7:0] disp_wire1,disp_wire2,disp_wire3,disp_wire4;
	wire [3:0] data_wire1,data_wire2,data_wire3,data_wire4;
	assign data_wire1 = data_sig [3:0];
	assign data_wire2 = data_sig [7:4];
	assign data_wire3 = data_sig [11:8];
	assign data_wire4 = data_sig [15:12];
	SEVENSEG_LED l1(.input_signal(data_wire1[3:0]), .output_signal(disp_wire1[7:0]));
	SEVENSEG_LED l2(.input_signal(data_wire2[3:0]), .output_signal(disp_wire2[7:0]));
	SEVENSEG_LED l3(.input_signal(data_wire3[3:0]), .output_signal(disp_wire3[7:0]));
	SEVENSEG_LED l4(.input_signal(data_wire4[3:0]), .output_signal(disp_wire4[7:0]));
	assign disp_out1 =  disp_wire1;
	assign disp_out2 =  disp_wire2;
	assign disp_out3 =  disp_wire3;
	assign disp_out4 =  disp_wire4;
	
endmodule
