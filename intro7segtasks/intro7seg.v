module intro7seg(
	input [3:0] number,
	output [7:0] signal,
	output [3:0] selector
);

function [7:0] display;
input [3:0] a;
begin
    case(a)
      4'h0: display = 8'b11000000;
      4'h1: display = 8'b11111001;
      4'h2: display = 8'b10100100;
      4'h3: display = 8'b10110000;
      4'h4: display = 8'b10011001;
      4'h5: display = 8'b10010010;
      4'h6: display = 8'b10000010;
      4'h7: display = 8'b11111000;
      4'h8: display = 8'b10000000;
      4'h9: display = 8'b10010000;
      4'hA: display = 8'b10001000;
      4'hB: display = 8'b10000011;
      4'hC: display = 8'b11000110;
      4'hD: display = 8'b10100001;
      4'hE: display = 8'b10000110;
      4'hF: display = 8'b10001110;
      default: display = 8'b11111111;
    endcase
  end
 endfunction
		assign signal = display (number);
		assign selector = 4'b0000;
endmodule