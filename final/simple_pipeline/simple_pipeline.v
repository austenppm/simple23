`include "ALU.v"
`include "RegisterFile.v"
`include "register.v"
`include "register2.v"
`include "shifter.v"
`include "PC.v"
`include "phasecounter.v"
`include "phase3ctl.v"
`include "phase4ctl.v"
`include "phase5ctl.v"
`include "ctl.v"
`include "branch.v"
`include "RemoveChattering.v"
`include "counta2.v"
`include "counta3.v"
`include "segLED.v"
`include "divider.v"
`include "display.v"
`include "forwardingunit.v"

module simple_pipeline(
		input [15:0] in,//input
		input clkin,
		input clk20,
		input rst_n,
		input exec,
		output [7:0] out2,
		output [3:0] sel2,
		output [7:0] out3,
		output [3:0] sel3,
		output ce1out,
		output ce2out,
		output ceout,
		output [7:0] disp_1,disp_2,disp_3,disp_4,disp_5,disp_6,disp_7,disp_8,
		output [8:0] sl_out2
		);
		reg [31:0] count;
		wire [0:0] clk;
		wire [3:0] clkout;
		wire [15:0] IROut,BROut,AROut,AR2In,AR2Out,SZCVIn,SZCVOut,DRIn,DROut,MDRIn,MDROut,MDR2Out,out;
		wire [2:0] Rs,Rd;
		wire [3:0] dshift,dshiftout;
		wire [7:0] d;
		wire [15:0] exdin,exdout,exdout2;
		wire [15:0] WriteData;
		wire MemRead,MemWrite,RegWrite,ALUSrc1,ALUSrc2,MemtoReg,Output,Input,ALUorshifter,ce_1,ce_2,ce1,ce2,brch_sig;
		wire [15:0] A_wire,B_wire,Data1,Data2,ALUOut,shifterIn,shifterOut;
		wire [3:0] ALUcondout,shiftercondout;
		wire [15:0] Inst,Inst_wire1,Inst_wire2;
		wire [15:0] pc,pcPlusOne,PC1Out,PC2Out,PCIn;
		wire [2:0] Branch;
		wire [15:0] reg_0,reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,reg_8,reg_9,reg_10,reg_11,reg_12,reg_13,reg_14,reg_15;
		wire [15:0] address;
		wire [2:0] RegDst_wire;
		wire [3:0] opcode_wire,opcode_wire1,opcode_wire2;
		wire brch_sig_wire;
		wire [7:0] ctlcheck;
		wire [15:0] SZCV10;
		wire [15:0] MemData,MemWriteData;
		wire x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16;
		wire [3:0] y0;
		wire [2:0] z0,z1,z2,z3,z4,z5,z6,z7,z8;
		wire MemReadout,MemWriteout,RegWriteout,ALUSrc1out,ALUSrc2out,MemtoRegout,Outputout,Inputout,ALUorshifterout,AS_BCout,SLIout;
		wire [3:0] opcodeout;
		wire [2:0] RegDstout,Branchout;
		wire hazard;
		wire [1:0] ForwardA,ForwardB;
		register IR(.clk(clk),.rst_n(rst_n),.WriteData(Inst_wire1&{16{hazard}}),.DataOut(IROut));
		register PC1(.clk(clk),.rst_n(rst_n),.WriteData(pcPlusOne),.DataOut(PC1Out));
		register BR(.clk(clk),.rst_n(rst_n),.WriteData(Data2),.DataOut(BROut));
		register AR(.clk(clk),.rst_n(rst_n),.WriteData(Data1),.DataOut(AROut));
		register PC2(.clk(clk),.rst_n(rst_n),.WriteData(PC1Out),.DataOut(PC2Out));
		register AR2(.clk(clk),.rst_n(rst_n),.WriteData(AR2In),.DataOut(AR2Out));
		register CR(.clk(clk),.rst_n(rst_n),.WriteData(exdin),.DataOut(exdout));
		register2 CR2(.clk(clk),.rst_n(rst_n),.WriteData(dshift),.DataOut(dshiftout));
		register CR3(.clk(clk),.rst_n(rst_n),.WriteData({{12{d[7]}},d[7:4]}),.DataOut(exdout2));
		register SZCV(.clk(clk),.rst_n(rst_n),.WriteData(SZCVIn),.DataOut(SZCVOut));
		register DR(.clk(clk),.rst_n(rst_n),.WriteData(DRIn),.DataOut(DROut));
		register MDR(.clk(clk),.rst_n(rst_n),.WriteData(MDRIn),.DataOut(MDROut));
		register MDR2(.clk(clk),.rst_n(rst_n),.WriteData(DROut),.DataOut(MDR2Out));
		RegisterFile RF(.Read1(Rs),.Read2(Rd),.WriteReg(RegDstout),.WriteData(WriteData),.clk(~clk),.rst_n(rst_n),.RegWrite(RegWriteout),.Data1(Data1),.Data2(Data2),
							 .reg_1(reg_1),.reg_2(reg_2),.reg_3(reg_3),.reg_4(reg_4),.reg_5(reg_5),.reg_6(reg_6),.reg_7(reg_7),.reg_0(reg_0));
		ALU ALU(.ALUctl(opcodeout),.A(A_wire),.B(B_wire),.Out(ALUOut),.Outcond(ALUcondout));
		ctl ctl(.inst(Inst_wire2),.MemRead(MemRead),.MemWrite(MemWrite),.RegWrite(RegWrite),.ALUSrc1(ALUSrc1),.ALUSrc2(ALUSrc2),.MemtoReg(MemtoReg),.ALUorShifter(ALUorshifter),.Halt(ce1),
				  .Output(Output),.Input(Input),.opcode(opcode_wire),.RegDst(RegDst_wire),.Branch(Branch),.AS_BC(AS_BC),.SLI(SLI));
		finding_hazard fh(.ID_EX_MemRead(x14),.ID_EX_Input(x5),.ID_EX_RegisterRa(z2),.IF_ID_RegisterRa(Inst_wire1[13:11]),.IF_ID_RegisterRb(Inst_wire1[10:8]),.hazard_ctl(hazard));
		forwardingunit fd(.EX_MEM_RegWrite(x13),.MEM_WB_RegWrite(RegWriteout),.EX_MEM_RegDst(z4),.MEM_WB_RegDst(RegDstout),.ID_EX_RegisterRa(z7),.ID_EX_RegisterRb(z8),.ForwardA(ForwardA),.ForwardB(ForwardB));
		shifter sf(.A(shifterIn),.opcode(opcodeout),.d(dshiftout),.Out(shifterOut),.Outcond(shiftercondout));
		PC PC(.clock(clk),.reset(rst_n),.branchFlag(brch_sig_wire),.ce(ce_1),.dr(DROut),.pc(pc),.pcPlusOne(pcPlusOne));
		phase3ctl p3IFID(.ALUSrc1in(ALUSrc1&hazard),.ALUSrc2in(ALUSrc2&hazard),.ALUorshifterin(ALUorshifter&hazard),.AS_BCin(AS_BC&hazard&(~brch_sig_wire)),.MemReadin(MemRead&hazard),.SLIin(SLI),.Rain(Inst_wire1[13:11]&{3{hazard}}),.Rbin(Inst_wire1[10:8]&{3{hazard}}),.opcodein(opcode_wire&{4{hazard}}),
							.clk(clk),.rst_n(rst_n),.ALUSrc1out(x0),.ALUSrc2out(x1),.ALUorshifterout(x2),.AS_BCout(x3),.MemReadout(x14),.SLIout(x16),.Raout(z5),.Rbout(z6),.opcodeout(y0));
		phase4ctl p4IFID(.MemWritein(MemWrite&hazard&(~brch_sig_wire)), .Inputin(Input&hazard),.Branchin(Branch|{3{brch_sig_wire}}),.clk(clk),.rst_n(rst_n),.MemWriteout(x4), .Inputout(x5),.Branchout(z0));
		phase5ctl p5IFID(.MemtoRegin(MemtoReg&hazard),.RegWritein(RegWrite&hazard&(~brch_sig_wire)),.RegDstin(RegDst_wire&{3{hazard}}),.clk(clk),.rst_n(rst_n),.MemtoRegout(x8),.RegWriteout(x9),.RegDstout(z2));
		phase3ctl p3IDEX(.ALUSrc1in(x0),.ALUSrc2in(x1),.ALUorshifterin(x2),.AS_BCin(x3&(~brch_sig_wire)),.MemReadin(x14),.SLIin(x16),.Rain(z5),.Rbin(z6),.opcodein(y0),
							.clk(clk),.rst_n(rst_n),.ALUSrc1out(ALUSrc1out),.ALUSrc2out(ALUSrc2out),.ALUorshifterout(ALUorshifterout),.AS_BCout(AS_BCout),.MemReadout(x15),.SLIout(SLIout),.Raout(z7),.Rbout(z8),.opcodeout(opcodeout));
		phase4ctl p4IDEX(.MemWritein(x4&(~brch_sig_wire)), .Inputin(x5),.Branchin(z0|{3{brch_sig_wire}}),.clk(clk),.rst_n(rst_n),.MemWriteout(x6), .Inputout(x7),.Branchout(z1));
		phase5ctl p5IDEX(.MemtoRegin(x8),.RegWritein(x9&(~brch_sig_wire)),.RegDstin(z2),.clk(clk),.rst_n(rst_n),.MemtoRegout(x10),.RegWriteout(x11),.RegDstout(z3));
		phase4ctl p4EXMEM(.MemWritein(x6&(~brch_sig_wire)), .Inputin(x7),.Branchin(z1|{3{brch_sig_wire}}),.clk(clk),.rst_n(rst_n),.MemWriteout(MemWriteout), .Inputout(Inputout),.Branchout(Branchout));
		phase5ctl p5EXMEM(.MemtoRegin(x10),.RegWritein(x11&(~brch_sig_wire)),.RegDstin(z3),.clk(clk),.rst_n(rst_n),.MemtoRegout(x12),.RegWriteout(x13),.RegDstout(z4));
		phase5ctl p5MEMWB(.MemtoRegin(x12),.RegWritein(x13),.RegDstin(z4),.clk(clk),.rst_n(rst_n),.MemtoRegout(MemtoRegout),.RegWriteout(RegWriteout),.RegDstout(RegDstout));
		branch br(.cond(SZCVOut),.brch(Branchout),.brch_sig(brch_sig_wire));
		ram ram1(.address(pc),.clock(~clk),.data(0),.wren(1'b0),.q(Inst));
		ram ram2(.address(DROut),.clock(~clk),.data(AR2Out),.wren(MemWriteout),.q(MemData));
		pll pll(.areset(0),.inclk0(clkin),.c0(clkout));
		RemoveChattering rc(.clk(clk20),.botton(exec),.rst_n(rst_n),.signal(ce2));
		counta2 c2(.rst_n(rst_n), .clk(clk20),.data(pc),.out2(out2),.sel2(sel2));
		counta3 c3(.rst_n(rst_n), .clk(clk20),.data(Inst),.out2(out3),.sel2(sel3));
		display ds(.sl_clk(clk20),.rst(rst_n),
						.reg_0(reg_0),.reg_1(reg_1),.reg_2(reg_2),.reg_3(reg_3),.reg_4(reg_4),.reg_5(reg_5),.reg_6(reg_6),.reg_7(reg_7),
						.reg_8(reg_8),.reg_9(reg_9),.reg_10(reg_10),.reg_11(reg_11),.reg_12(reg_12),.reg_13(reg_13),.reg_14(reg_14),.reg_15(reg_15),
						.ctl(ctlcheck),
						.disp_1(disp_1),.disp_2(disp_2),.disp_3(disp_3),.disp_4(disp_4),.disp_5(disp_5),.disp_6(disp_6),.disp_7(disp_7),.disp_8(disp_8),.sl_out(sl_out2));
		assign Rs = IROut[13:11];
		assign Rd = IROut[10:8];
		assign dshift = IROut[3:0];
		assign d = IROut[7:0];
		assign A_wire = (ALUSrc1out==1'b1) ? PC2Out:
						    (ForwardB==2'b01 && ALUSrc1out==1'b0) ? DROut:
							 (ForwardB==2'b10 && ALUSrc1out==1'b0) ? WriteData:
					  BROut;
		assign shifterIn = (ALUSrc1out==1'b1) ? PC2Out:
								 (SLIout==1'b1) ? exdout2:
								 (ForwardB==2'b01 && ALUSrc1out==1'b0) ? DROut:
								 (ForwardB==2'b10 && ALUSrc1out==1'b0) ? WriteData:
					  BROut;
		assign B_wire = (ALUSrc2out==1'b1) ? exdout:
							 (ForwardA==2'b01 && ALUSrc2out==1'b0) ? DROut:
							 (ForwardA==2'b10 && ALUSrc2out==1'b0) ? WriteData:
					  AROut;
		assign AR2In = (ForwardA==2'b01) ? DROut:
							(ForwardA==2'b10) ? WriteData:
							AROut;
		assign out = (ForwardA==2'b01 && ALUSrc2out==1'b0) ? DROut:
						 (ForwardA==2'b10 && ALUSrc2out==1'b0) ? WriteData:
					  AROut;
			assign DRIn = (ALUorshifterout==1'b0) ? ALUOut:
						  shifterOut;
		assign SZCVIn = (ALUorshifterout==1'b0 && AS_BCout==1'b1) ? ALUcondout:
							 (ALUorshifterout==1'b1 && AS_BCout==1'b1) ? shiftercondout:
					  SZCVOut;
		assign MDRIn = (Inputout==1'b1) ? in:
					  MemData;
		assign WriteData = (MemtoRegout==1'b1) ? MDROut:
					  MDR2Out;
//		assign address = (hazard==1'b0) ? pc - 1:
//						     pc;
		assign exdin = {{8{d[7]}},d};
		assign opcode_wire1 = opcode_wire;
		assign opcode_wire2 = opcode_wire;
		assign Inst_wire1 = Inst;
		assign Inst_wire2 = Inst;
		assign PCIn = WriteData;
		assign ce_1 = !ce1 && ce2 && hazard;
		assign ce_2 = !ce1 && ce2;
		assign clk = clkout;
//		assign clk = clkin;
//		&& !ce1 && ce2;
		
		//デバッグ用アサイン
		assign ctlcheck = {hazard,MemtoRegout,brch_sig_wire,RegWriteout,MemWriteout,MemReadout,ALUSrc2out,ALUSrc1out};
		assign SZCV10[15:12] = (SZCVOut / 6) % 2;
		assign SZCV10[11:8] = (SZCVOut / 4) % 2;
		assign SZCV10[7:4] = (SZCVOut / 2) % 2;
		assign SZCV10[3:0] = SZCVOut % 2;
		assign pcout = pc;
		assign ceout = ce_1;
		assign ce1out = ce1;
		assign ce2out = ce2;
		assign reg_8 = IROut;
		assign reg_9 = DROut;
		assign reg_10 = opcodeout;
		assign reg_11 = MDROut;
		assign reg_12 = shifterIn;
		assign reg_13 = dshiftout;
		assign reg_14 = count[31:16];
		assign reg_15 = count[15:0];
		always@(posedge clk or negedge rst_n) begin
			if(!rst_n) begin
				count <= 32'b00000000000000000000000000000000;
			end else begin
				if (ce_2 == 1'b1) begin
					count <= count + 1;
				end else begin
					count <= count;
				end
			end
		end
endmodule