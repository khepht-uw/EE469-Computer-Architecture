//

`timescale 1ps/1ps
module control(
					input logic [31:21] instruction,
					output logic Reg2Loc, UncondBranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, FlagWrite,
					output logic ImmSrc, BL, BRSel,
					output logic [2:0] ALUOp
					);
					
	always_comb begin
		Reg2Loc = 0;
      UncondBranch = 0;
      Branch = 0;
      MemRead = 0;
      MemtoReg = 0;
      ALUOp = 3'b000;
      MemWrite = 0;
      ALUSrc  = 0;
      RegWrite = 0;
      FlagWrite = 0;
		ImmSrc = 0;
		BL = 0;
		BRSel = 0;
		
		casez(instruction[31:21])
			//ADDS
			11'b10101011000: begin
				RegWrite  = 1;
				FlagWrite = 1;
				ALUOp     = 3'b010; // ADD
         end
			
			//ADDI
			11'b1001000100?: begin
				ALUSrc	= 1;      // use immediate not register
				RegWrite	= 1;
				ALUOp	= 3'b010; // ADD
				ImmSrc = 1;
         end
			
			//B 
			11'b000101?????: begin
				UncondBranch = 1;
				ALUOp        = 3'b000; // ALU unused, pass B
         end
			
			//B.LT : NEEDS WORK. If (flags.negative != flags.overflow) PC = PC + SignExtend(Imm19<<2)
			11'b01010100???: begin
				Branch = 1;
				ALUOp  = 3'b000;
         end
			
			//BL : NEEDS WORK. Handle in cpu, X30 = PC + 4 (instruction after this one), PC = PC + SignExtend(Imm26<<2)
			11'b100101?????: begin
				UncondBranch = 1;
				RegWrite = 1;  // writes PC+4 to X30
				BL = 1;
				ALUOp = 3'b000;
         end
		
			//BR 
			11'b11010110000: begin
				UncondBranch = 0;
				ALUOp = 3'b000;
				BRSel = 1;
         end
			
			//CBZ
			11'b10110100???: begin
				Reg2Loc = 1; //read Rd into ReadData2
				Branch  = 1;
				ALUOp   = 3'b000; // pass B through, zero flag = is Rd zero?
         end
			
			//LDUR
			11'b11111000010: begin
				ALUSrc = 1;      // use immediate for address
				MemRead = 1;
				MemtoReg = 1;      // write mem data to register
				RegWrite = 1;
				ALUOp	= 3'b010; // ADD for address calculation
				ImmSrc = 0;
         end
			
			//STUR
			11'b11111000000: begin
				Reg2Loc = 1;
				ALUSrc = 1;
				MemWrite = 1;
				ALUOp = 3'b010; // ADD for address calculation
				ImmSrc = 0;
         end
			
			//SUBS
			11'b11101011000: begin
				RegWrite = 1;
				FlagWrite = 1;
				ALUOp = 3'b011; // SUB
         end
			
			default: begin // all signals stay at defaults
				end

		endcase
	end		
endmodule


