module clock_divider (
    input clock,
    output clk_div
);

    reg [8:0] clk_counter;
    reg clk_div_reg;

    always @(posedge clock) begin
        clk_counter <= clk_counter + 1;
        if (clk_counter == 9'd150) begin // Divide by 300
            clk_div_reg <= ~clk_div_reg;
            clk_counter <= 9'd0;
        end
    end

    assign clk_div = clk_div_reg;

endmodule
