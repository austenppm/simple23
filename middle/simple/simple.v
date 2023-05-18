`include "ALU.v"
`include "RegisterFile.v"
`include "register.v"
`include "shifter.v"
`include "PC.v"
`include "phasecounter.v"
`include "ctl.v"
`include "branch.v"
`include "RemoveChattering.v"
`include "counta2.v"
`include "counta3.v"
`include "segLED.v"
`include "divider.v"
`include "display.v"

module simple(
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
		output [4:0] clk2out,
		output [7:0] disp_1,disp_2,disp_3,disp_4,disp_5,disp_6,disp_7,disp_8,
		output [8:0] sl_out2
		);
		wire [15:0] IROut,BROut,AROut,SZCVIn,SZCVOut,DRIn,DROut,MDRIn,MDROut;
		wire [2:0] Rs,Rd;
		wire [3:0] dshift;
		wire [7:0] d;
		wire [15:0] exd;
		wire [15:0] WriteData;
		wire MemRead,MemWrite,RegWrite,ALUSrc1,ALUSrc2,MemtoReg,Output,Input,ALUorshifter,ce_1,ce_2,ce1,ce2,brch_sig;
		wire [15:0] A_wire,B_wire,Data1,Data2,ALUOut,shifterIn,shifterOut;
		wire [3:0] ALUcondout,shiftercondout;
		wire [15:0] Inst,Inst_wire1,Inst_wire2;
		wire [15:0] pc,pcPlusOne,PCIn;
		wire [4:0] clk2;
		wire [2:0] Branch;
		wire [15:0] reg_0,reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,reg_8,reg_9,reg_10,reg_11,reg_12,reg_13,reg_14,reg_15;
		wire [15:0] address;
		wire [2:0] RegDst_wire;
		wire [3:0] opcode_wire,opcode_wire1,opcode_wire2;
		wire brch_sig_wire;
		wire [7:0] ctlcheck;
		wire [15:0] SZCV10;
		register IR(.clk(clk2[3]),.rst_n(rst_n),.WriteData(Inst_wire1),.DataOut(IROut));
		register BR(.clk(clk2[2]),.rst_n(rst_n),.WriteData(Data2),.DataOut(BROut));
		register AR(.clk(clk2[2]),.rst_n(rst_n),.WriteData(Data1),.DataOut(AROut));
		register SZCV(.clk(clk2[1]),.rst_n(rst_n),.WriteData(SZCVIn),.DataOut(SZCVOut));
		register DR(.clk(clk2[1]),.rst_n(rst_n),.WriteData(DRIn),.DataOut(DROut));
		register MDR(.clk(clk2[0]),.rst_n(rst_n),.WriteData(MDRIn),.DataOut(MDROut));
		RegisterFile RF(.Read1(Rs),.Read2(Rd),.WriteReg(RegDst_wire),.WriteData(WriteData),.clk(clk2[0]),.RegWrite(RegWrite&&clk2[0]),.Data1(Data1),.Data2(Data2),
							 .reg_1(reg_1),.reg_2(reg_2),.reg_3(reg_3),.reg_4(reg_4),.reg_5(reg_5),.reg_6(reg_6),.reg_7(reg_7),.reg_0(reg_0));
		ALU ALU(.ALUctl(opcode_wire1),.A(A_wire),.B(B_wire),.Out(ALUOut),.Outcond(ALUcondout));
		ctl ctl(.clk(clk2[3]),.rst_n(rst_n),.inst(Inst_wire2),.MemRead(MemRead),.MemWrite(MemWrite),.RegWrite(RegWrite),.ALUSrc1(ALUSrc1),.ALUSrc2(ALUSrc2),.MemtoReg(MemtoReg),.ALUorShifter(ALUorshifter),.Halt(ce1),
				  .Output(Output),.Input(Input),.opcode(opcode_wire),.RegDst(RegDst_wire),.Branch(Branch),.BranchCond(BC),.AS_BC(AS_BC));
		shifter sf(.A(shifterIn),.opcode(opcode_wire2),.d(dshift),.Out(shifterOut),.Outcond(shiftercondout));
		PC PC(.clock(clk2[4]),.reset(rst_n),.branchFlag(brch_sig_wire),.ce(ce_1),.dr(PCIn),.pc(pc),.pcPlusOne(pcPlusOne));
		phasecounter a0(.clk(clk),.rst_n(rst_n),.ce(ce_2),.p(clk2));
		branch br(.cond(SZCVOut),.brch(Branch),.brch_sig(brch_sig_wire));
		ram ram(.address(address),.clock(clk20),.data(AROut),.wren(MemWrite&&clk2[0]),.q(Inst));
		RemoveChattering rc(.clk(clk20),.botton(exec),.rst_n(rst_n),.signal(ce2));
		counta2 c2(.rst_n(rst_n), .clk(clk20),.data(pc),.out2(out2),.sel2(sel2));
		counta3 c3(.rst_n(rst_n), .clk(clk20),.data(out),.out2(out3),.sel2(sel3));
		display ds(.sl_clk(clk20),.rst(rst_n),
						.reg_0(reg_0),.reg_1(reg_1),.reg_2(reg_2),.reg_3(reg_3),.reg_4(reg_4),.reg_5(reg_5),.reg_6(reg_6),.reg_7(reg_7),
						.reg_8(reg_8),.reg_9(reg_9),.reg_10(reg_10),.reg_11(reg_11),.reg_12(reg_12),.reg_13(reg_13),.reg_14(reg_14),.reg_15(reg_15),
						.ctl(ctlcheck),
						.disp_1(disp_1),.disp_2(disp_2),.disp_3(disp_3),.disp_4(disp_4),.disp_5(disp_5),.disp_6(disp_6),.disp_7(disp_7),.disp_8(disp_8),.sl_out(sl_out2));
		assign Rs = IROut[13:11];
		assign Rd = IROut[10:8];
		assign dshift = IROut[3:0];
		assign d = IROut[7:0];
		//BRを消すか否か-----------------------------
//		assign A_wire = (ALUSrc1==1'b1) ? pcPlusOne:
//					  BROut;
		assign A_wire = (ALUSrc1==1'b1) ? pcPlusOne:
					  Data2;
		//------------------------------------------
		assign shifterIn = (ALUSrc1==1'b1) ? pcPlusOne:
					  BROut;
		assign B_wire = (ALUSrc2==1'b1) ? exd:
					  AROut;
		assign out = AROut;
		assign DRIn = (ALUorshifter==1'b0) ? ALUOut:
					  shifterOut;
		assign SZCVIn = (ALUorshifter==1'b0 && AS_BC==1'b1) ? ALUcondout:
							 (ALUorshifter==1'b1 && AS_BC==1'b1) ? shiftercondout:
					  SZCVOut;
		assign MDRIn = (Input==1'b1) ? in:
					  Inst;
		assign WriteData = (MemtoReg==1'b1) ? MDROut:
					  DROut;
		assign exd = {{8{d[7]}},d};
		//DRを消すか否か----------------------------------------------------------------------------
//		assign address = ((MemRead==1'b1||MemWrite==1'b1)&&(clk2[1]==1'b1||clk2[0]==1'b1)) ? DROut:
//								pc;
		assign address = ((MemRead==1'b1||MemWrite==1'b1)&&(clk2[1]==1'b1||clk2[0]==1'b1)) ? DRIn:
								pc;
		//-----------------------------------------------------------------------------------------
		assign opcode_wire1 = opcode_wire;
		assign opcode_wire2 = opcode_wire;
		assign Inst_wire1 = Inst;
		assign Inst_wire2 = Inst;
		assign PCIn = WriteData;
		assign ce_1 = !ce1 && ce2;
		assign ce_2 = !ce1 && ce2;
		
		//デバッグ用アサイン
		assign ctlcheck = {AS_BC,MemtoReg,Branch,RegWrite,MemWrite,MemRead,ALUSrc2,ALUSrc1};
		assign SZCV10[15:12] = (SZCVOut / 6) % 2;
		assign SZCV10[11:8] = (SZCVOut / 4) % 2;
		assign SZCV10[7:4] = (SZCVOut / 2) % 2;
		assign SZCV10[3:0] = SZCVOut % 2;
		assign pcout = pc;
		assign ceout = ce_1;
		assign ce1out = ce1;
		assign ce2out = ce2;
		assign clk2out = clk2;
		assign reg_8 = address;
		assign reg_9 = DROut;
		assign reg_10 = SZCV10;
		assign reg_11 = WriteData;
		assign reg_12 = exd;
		assign reg_13 = ALUOut;
		assign reg_14 = BROut;
		assign reg_15 = AROut;
endmodule
		