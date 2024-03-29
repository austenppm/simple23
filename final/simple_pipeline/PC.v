module PC(input clock,reset,branchFlag,ce,//changeEnable
			input [15:0] dr,
			output reg [15:0] pc,pcPlusOne);

	reg [15:0] p2_master,p2_slave,p3_master,p3_slave,p4_master,p4_slave,p5;
	reg pcStoped;

	always @(*)begin
		pcPlusOne <= pc + 1;
	end
	
	always @(posedge clock or negedge reset) begin 
		if(!reset)begin
			pc <= 0;
		end else begin
			if(branchFlag == 1'b1) begin
				pc <= dr;
			end else begin
				if(ce == 1'b1) begin
					pc <= pc+1;
				end
			end
		end
	end
	
endmodule