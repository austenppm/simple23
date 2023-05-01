module digit_selector (
    input clock,
    output reg [3:0] selector
);

    initial begin
        selector = 4'b0000;
    end

    always @(posedge clock) begin
        selector <= selector + 1;
    end

endmodule