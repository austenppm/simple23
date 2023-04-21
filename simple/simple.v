`include "ALU.v"
`include "RegisterFile.v"
`include "register.v"
`include "shifter.v"
`include "PC.v"
`include "phasecounter.v"

module simple(
		input [15:0] in,
		input clk,
		input rst_n,
		input exec,
		output [15:0] out
		);
		wire [15:0] IROut;
		wire [15:0] BROut;
		wire [15:0] AROut;
		wire [15:0] SZCVIn;
		wire [15:0] SZCVOut;
		wire [15:0] DRIn;
		wire [15:0] DROut;
		wire [15:0] MDRIn;
		wire [15:0] MDROut;
		reg [2:0] Rs;
		reg [2:0] Rd;
		wire [3:0] dshift;
		wire [7:0] d;
		wire [15:0] WriteData;
		wire RegWrite;
		wire [15:0] A;
		wire [15:0] B;
		wire [15:0] Data1;
		wire [15:0] Data2;
		wire [3:0] ALUctl;
		wire [15:0] ALUOut;
		wire [3:0] ALUcondout;
		wire [15:0] shifterIn;
		wire [15:0] shifterctl;
		wire [15:0] shifterOut;
		wire [3:0] shiftercondout;
		wire [15:0] Inst;
		wire [15:0] pcPlusOne;
		wire [15:0] pcIn;
		wire [4:0] clk2;
		register IR(.clk(clk2[3]),.rst_n(rst_n),.WriteData(Inst),.DataOut(IROut));
		register BR(.clk(clk2[2]),.rst_n(rst_n),.WriteData(Data2),.DataOut(BROut));
		register AR(.clk(clk2[2]),.rst_n(rst_n),.WriteData(Data1),.DataOut(AROut));
		register SZCV(.clk(clk2[1]),.rst_n(rst_n),.WriteData(SZCVIn),.DataOut(SZCVOut));
		register DR(.clk(clk2[1]),.rst_n(rst_n),.WriteData(DRIn),.DataOut(DROut));
		register MDR(.clk(clk2[0]),.rst_n(rst_n),.WriteData(MDRIn),.DataOut(MDROut));
		RegisterFile RF(.Read1(Rs),.Read2(Rd),.WriteReg(WriteReg),.WriteData(WriteData),.clk(clk2[0]),.RegWrite(RegWrite),.Data1(Data1),.Data2(Data2));
		ALU ALU(.ALUctl(ALUctl),.A(A),.B(B),.Out(ALUOut),.Outcond(ALUcondout));
		ctl ctl(.clk(clk),.rst(rst_n),.exec(),.inst(),.InstOut(Inst),.MemRead(),.MemWrite(),.RegRead(),.RegWrite(),.ALUSrc(),.MemtoReg(),);
		shifter #(.d(dshift)) sf(.A(shifterIn),.opcode(shifterctl),.Out(shifterOut),.Outcond(shiftercondout));
		PC pc(.clock(clk2[4]),.reset(),.branchFlag(),.ce(),.dr(WriteData),.pc(),.pcPlusOne(pcPlusOne));
		phasecounter a0(.clk(clk),.rst_n(rst_n),.p(clk2));
		assign Rs = IROut[13:11];
		assign Rd = IROut[10:8];
		assign dshift = IROut[3:0];
		assign d = IROut[7:0];
		always @(posedge clk or negedge rst_n) begin
			if (ALUSrc1)
				A <= pcPlusOne;
			else
				A <= BROut;
			if (d[7]==1'b0)
				d <= {8'b00000000,d};
			else
				d <= {8'b11111111,d};
			if (!ALUSrc2) begin
				B <= AROut;
				DRIn <= shifterOut;
			end else begin
				B <= d;
				DRIn <= ALUOut;
			end
			if (Input)
				MDRIn <= 0;//外部入力
			else
				MDRIn <= 0;
			if (MemtoReg)
				WriteData <= MDROut;
			else
				WriteData <= DROut;
			if (a)
				pcIn <= WriteData;
			else
				pcIn <= pcPlusOne;
		end
endmodule
		