module convertdecimal(
	input [13:0] binary,
	output [3:0] num1,
	output [3:0] num2,
	output [3:0] num3,
	output [3:0] num4	);

	assign num1 = binary%10;
	assign num2 = ((binary - num1)/ 10) % 10;
	assign num3 = ((binary - num1 - num2 * 10)/ 100) % 10;
	assign num4 = ((binary - num1 - num2 * 10 - num3 * 100)/ 1000) % 10;


endmodule