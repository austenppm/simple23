`include "ALU.v"
`include "RegisterFile.v"
`include "register.v"
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
		input clk,
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
		wire [15:0] IROut,BROut,AROut,SZCVIn,SZCVOut,DRIn,DROut,MDRIn,MDROut;
		wire [2:0] Rs,Rd;
		wire [3:0] dshift;
		wire [7:0] d;
		wire [15:0] exdin,exdout;
		wire [15:0] WriteData;
		wire MemRead,MemWrite,RegWrite,ALUSrc1,ALUSrc2,MemtoReg,Output,Input,ALUorshifter,ce_1,ce1,ce2,brch_sig;
		wire [15:0] A_wire,B_wire,Data1,Data2,ALUOut,shifterIn,shifterOut;
		wire [3:0] ALUcondout,shiftercondout;
		wire [15:0] Inst,Inst_wire1,Inst_wire2;
		wire [15:0] pc,pcPlusOne,PCIn;
		wire [2:0] Branch;
		wire [15:0] reg_0,reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,reg_8,reg_9,reg_10,reg_11,reg_12,reg_13,reg_14,reg_15;
		wire [15:0] address;
		wire [2:0] RegDst_wire;
		wire [3:0] opcode_wire,opcode_wire1,opcode_wire2;
		wire brch_sig_wire;
		wire [7:0] ctlcheck;
		wire [15:0] SZCV10;
		wire [15:0] MemData;
		wire x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15;
		wire [3:0] y0;
		wire [2:0] z0,z1,z2,z3,z4,z5,z6,z7,z8;
		wire MemReadout,MemWriteout,RegWriteout,ALUSrc1out,ALUSrc2out,MemtoRegout,Outputout,Inputout,ALUorshifterout,AS_BCout;
		wire [3:0] opcodeout;
		wire [2:0] RegDstout,Branchout;
		wire hazard;
		register IR(.clk(clk),.rst_n(rst_n),.WriteData(Inst_wire1&{16{hazard}}),.DataOut(IROut));
		register BR(.clk(clk),.rst_n(rst_n),.WriteData(Data2),.DataOut(BROut));
		register AR(.clk(clk),.rst_n(rst_n),.WriteData(Data1),.DataOut(AROut));
		register CR(.clk(clk),.rst_n(rst_n),.WriteData(exdin),.DataOut(exdout));
		register SZCV(.clk(clk),.rst_n(rst_n),.WriteData(SZCVIn),.DataOut(SZCVOut));
		register DR(.clk(clk),.rst_n(rst_n),.WriteData(DRIn),.DataOut(DROut));
		register MDR(.clk(clk),.rst_n(rst_n),.WriteData(MDRIn),.DataOut(MDROut));
		RegisterFile RF(.Read1(Rs),.Read2(Rd),.WriteReg(RegDst_wire),.WriteData(WriteData),.clk(clk20),.rst_n(rst_n),.RegWrite(RegWriteout),.Data1(Data1),.Data2(Data2),
							 .reg_1(reg_1),.reg_2(reg_2),.reg_3(reg_3),.reg_4(reg_4),.reg_5(reg_5),.reg_6(reg_6),.reg_7(reg_7),.reg_0(reg_0));
		ALU ALU(.ALUctl(opcodeout),.A(A_wire),.B(B_wire),.Out(ALUOut),.Outcond(ALUcondout));
		ctl ctl(.inst(Inst_wire2),.MemRead(MemRead),.MemWrite(MemWrite),.RegWrite(RegWrite),.ALUSrc1(ALUSrc1),.ALUSrc2(ALUSrc2),.MemtoReg(MemtoReg),.ALUorShifter(ALUorshifter),.Halt(ce1),
				  .Output(Output),.Input(Input),.opcode(opcode_wire),.RegDst(RegDst_wire),.Branch(Branch),.AS_BC(AS_BC));
		finding_hazard fh(.ID_EX_MemRead(x14),.ID_EX_RegisterRa(z2),.IF_ID_RegisterRa(Inst_wire1[13:11]),.IF_ID_RegisterRb(Inst_wire1[10:8]),.hazard_ctl(hazard));
		forwardingunit fd(.EX_MEM_RegWrite(x13),.MEM_WB_RegWrite(RegWriteout),.EX_MEM_RegDst(z4),.MEM_WB_RegDst(RegDstout),.ID_EX_RegisterRa(z7),.ID_EX_RegisterRb(z8),.ForwardA(ForwardA),.ForwardB(ForwardB));
		shifter sf(.A(shifterIn),.opcode(opcodeout),.d(dshift),.Out(shifterOut),.Outcond(shiftercondout));
		PC PC(.clock(clk),.reset(rst_n),.branchFlag(brch_sig_wire),.ce(ce_1),.dr(PCIn),.pc(pc),.pcPlusOne(pcPlusOne));
		phase3ctl p3IFID(.ALUSrc1in(ALUSrc1&hazard),.ALUSrc2in(ALUSrc2&hazard),.ALUorshifterin(ALUorshifter&hazard),.AS_BCin(AS_BC&hazard),.MemReadin(MemRead&hazard),.Rain(IROut[13:11]&{3{hazard}}),.Rbin(IROut[10:8]&{3{hazard}}),.opcodein(opcode_wire&{4{hazard}}),
							.clk(clk),.rst_n(rst_n),.ALUSrc1out(x0),.ALUSrc2out(x1),.ALUorshifterout(x2),.AS_BCout(x3),.MemReadout(x14),.Raout(z5),.Rbout(z6),.opcodeout(y0));
		phase4ctl p4IFID(.MemWritein(MemWrite&hazard), .Inputin(Input&hazard),.Branchin(Branch&{3{hazard}}),.clk(clk),.rst_n(rst_n),.MemWriteout(x4), .Inputout(x5),.Branchout(z0));
		phase5ctl p5IFID(.MemtoRegin(MemtoReg&hazard),.RegWritein(RegWrite&hazard),.RegDstin(RegDst_wire&{3{hazard}}),.clk(clk),.rst_n(rst_n),.MemtoRegout(x8),.RegWriteout(x9),.RegDstout(z2));
		phase3ctl p3IDEX(.ALUSrc1in(x0),.ALUSrc2in(x1),.ALUorshifterin(x2),.AS_BCin(x3),.MemReadin(x14),.Rain(z5),.Rbin(z6),.opcodein(y0),
							.clk(clk),.rst_n(rst_n),.ALUSrc1out(ALUSrc1out),.ALUSrc2out(ALUSrc2out),.ALUorshifterout(ALUorshifterout),.AS_BCout(AS_BCout),.MemReadout(x15),.Raout(z7),.Rbout(z8),.opcodeout(opcodeout));
		phase4ctl p4IDEX(.MemWritein(x4), .Inputin(x5),.Branchin(z0),.clk(clk),.rst_n(rst_n),.MemWriteout(x6), .Inputout(x7),.Branchout(z1));
		phase5ctl p5IDEX(.MemtoRegin(x8),.RegWritein(x9),.RegDstin(z2),.clk(clk),.rst_n(rst_n),.MemtoRegout(x10),.RegWriteout(x11),.RegDstout(z3));
		phase4ctl p4EXMEM(.MemWritein(x6), .Inputin(x7),.Branchin(z1),.clk(clk),.rst_n(rst_n),.MemWriteout(MemWriteout), .Inputout(Inputout),.Branchout(Branchout));
		phase5ctl p5EXMEM(.MemtoRegin(x10),.RegWritein(x11),.RegDstin(z3),.clk(clk),.rst_n(rst_n),.MemtoRegout(x12),.RegWriteout(x13),.RegDstout(z4));
		phase5ctl p5MEMWB(.MemtoRegin(x12),.RegWritein(x13),.RegDstin(z4),.clk(clk),.rst_n(rst_n),.MemtoRegout(MemtoRegout),.RegWriteout(RegWriteout),.RegDstout(RegDstout));
		branch br(.cond(SZCVOut),.brch(Branch),.brch_sig(brch_sig_wire));
		ram ram1(.address(pc),.clock(clk20),.data(0),.wren(1'b0),.q(Inst));
		ram ram2(.address(DROut),.clock(clk20),.data(AROut),.wren(MemWriteout),.q(MemData));
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
		assign A_wire = (ALUSrc1out==1'b1 && ForwardB==2'b00) ? pcPlusOne:
						    (ForwardB==2'b01 && ALUSrc1out==1'b0) ? DRIn:
							 (ForwardB==2'b10 && ALUSrc1out==1'b0) ? WriteData:
					  BROut;
		assign shifterIn = (ALUSrc1out==1'b1) ? pcPlusOne:
					  BROut;
		assign B_wire = (ALUSrc2out==1'b1 && ForwardA==2'b00) ? exdout:
							 (ForwardA==2'b01 && ALUSrc2out==1'b0) ? DRIn:
							 (ForwardA==2'b10 && ALUSrc2out==1'b0) ? WriteData:
					  AROut;
		assign out = AROut;
		assign DRIn = (ALUorshifterout==1'b0) ? ALUOut:
					  shifterOut;
		assign SZCVIn = (ALUorshifterout==1'b0 && AS_BCout==1'b1) ? ALUcondout:
							 (ALUorshifterout==1'b1 && AS_BCout==1'b1) ? shiftercondout:
					  SZCVOut;
		assign MDRIn = (Inputout==1'b1) ? in:
					  MemData;
		assign WriteData = (MemtoRegout==1'b1) ? MDROut:
					  DROut;
//		assign address = (hazard==1'b0) ? pc - 1:
//						     pc;
		assign exdin = {{8{d[7]}},d};
		assign opcode_wire1 = opcode_wire;
		assign opcode_wire2 = opcode_wire;
		assign Inst_wire1 = Inst;
		assign Inst_wire2 = Inst;
		assign PCIn = WriteData;
		assign ce_1 = !ce1 && ce2 && hazard;
		
		//デバッグ用アサイン
		assign ctlcheck = {hazard,MemtoRegout,Inputout,RegWriteout,MemWriteout,MemReadout,ALUSrc2out,ALUSrc1out};
		assign SZCV10[15:12] = (SZCVOut / 6) % 2;
		assign SZCV10[11:8] = (SZCVOut / 4) % 2;
		assign SZCV10[7:4] = (SZCVOut / 2) % 2;
		assign SZCV10[3:0] = SZCVOut % 2;
		assign pcout = pc;
		assign ceout = ce_1;
		assign ce1out = ce1;
		assign ce2out = ce2;
		assign reg_8 = MemData;
		assign reg_9 = DROut;
		assign reg_10 = ForwardA;
		assign reg_11 = WriteData;
		assign reg_12 = exdout;
		assign reg_13 = ALUOut;
		assign reg_14 = B_wire;
		assign reg_15 = AROut;
endmodule