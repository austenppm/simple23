module digitdisplay(
	input [3:0] number,
	output [7:0] signal, 
	output [3:0] selector );

	function [7:0] display;
        input [3:0] a;
        begin
            case (a)
                0: display = 8'b11111100;
                1: display = 8'b01100000;
                2: display = 8'b11011010;
                3: display = 8'b11110010;
                4: display = 8'b01100110;
                5: display = 8'b10110110;
                6: display = 8'b10111110;
                7: display = 8'b11100000;
                8: display = 8'b11111110;
                9: display = 8'b11110110;
                10: display = 8'b11101110;
                11: display = 8'b00111110;
                12: display = 8'b00011010;
                13: display = 8'b01111010;
					 14: display = 8'b10011110;
                15: display = 8'b10001110;
                default: display = 8'b00111001;
            endcase
        end
    endfunction

	 assign signal = display(number);
	 assign selector = 4'b0000;

endmodule