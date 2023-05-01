module intro7seg3 (
    input clock,
	 input switch,
    output reg [7:0] signal_out,
    output reg [3:0] selector
);
    wire clk_div;
	 wire [31:0] signal;
    
    // Clock Divider
    clock_divider clk_div_inst (
        .clock(clock),
        .clk_div(clk_div)
    );

    wire [13:0] count;
    wire [3:0] n1, n2, n3, n4;
	 wire ispressed;
	reg enabled;
	
	initial begin
		enabled = 1'b1;
	end
    // Counter for selector
    reg [1:0] selector_counter;

    always @(posedge clock) begin
        selector_counter <= selector_counter + 1;
        case (selector_counter)
            2'b00: selector <= 4'b1110;
            2'b01: selector <= 4'b1101;
            2'b10: selector <= 4'b1011;
            2'b11: selector <= 4'b0111;
        endcase
    end
	 
	 always @ (posedge clock) begin
		case (selector_counter)
		      2'b00: signal_out <= signal[7:0];
            2'b01: signal_out <= signal[15:8];
            2'b10: signal_out <= signal[23:16];
            2'b11: signal_out <= signal[31:24];
        endcase
    end
		 

    // Counter
    counter100000000 counter_inst (
        .clock(clk_div & enabled),
        .count(count)
    );
// setup chatter avoidance
	chattercounter(.clock(clk_div), .switch(switch), .ispressed(ispressed));

    // Decimal converter
    convertdecimal decimal_inst (
        .binary(count),
        .num1(n1),
        .num2(n2),
        .num3(n3),
        .num4(n4)
    );

    digitdisplay dd1 (
        .number(n1),
        .signal(signal[7:0])
    );

    digitdisplay dd2 (
        .number(n2),
        .signal(signal[15:8])
    );

    digitdisplay dd3 (
        .number(n3),
        .signal(signal[23:16])
    );

    digitdisplay dd4 (
        .number(n4),
        .signal(signal[31:24])
    );
	 
   always @(negedge ispressed) begin
			enabled <= !enabled;
	end
endmodule
