`timescale 1ps/1ps

module cpu (
	input logic clk,
   input logic reset
	);

	//PC Wires
	logic [31:0] instruction;
	logic [63:0] PC_current, PC_next, PC_add4, branch_target;

	//Control wires
	logic Reg2Loc, RegWrite;
	logic ALUSrc, FlagWrite, ImmSrc;
	logic Branch, UncondBranch;
	logic MemWrite, MemtoReg, MemRead;
	logic [2:0] ALUOp;
	
	//Register file wires
	logic [4:0]  reg_read1, reg_read2, reg_write;
   logic [63:0] reg_data1, reg_data2, reg_writedata;
	
	//Sign extender wires
	logic [63:0] se_dAddr, se_condAddr, se_brAddr, ze_imm;
	logic [63:0] br_imm_selected; // mux between condAddr and brAddr
	logic [63:0] br_shifted;      // after << 2
	logic [63:0] muxImmtoALU; //IF we decide to use a mux to choose between Daddr9 or IMM from ADDI instruction
	
	//ALU wires
	logic [63:0] alu_b, alu_result;
	logic zero, carryout, overflow, negative;
	
	//Flag register wires
	logic flag_zero, flag_carryout, flag_overflow, flag_negative;
	
	//Data memory wires
	logic [63:0] mem_out;
	
	//Branch logic wires
	logic cbz_taken, blt_taken, BrTaken;
   logic neg_xor_ovf; //For B.LT
	
	
	//TOP MODULES (PC)
	pc program_counter(
		.next_pc(PC_next),
		.clk(clk),
		.reset(reset),
		.current_pc(PC_current)
		);
		
	instructmem instr_mem( 
		.address(PC_current),
		.instruction(instruction),
		.clk(clk)
		);
		
	se sign_extend(
		.instruction(instruction),
		.se_dAddr(se_dAddr),
      .se_condAddr(se_condAddr),
      .se_brAddr(se_brAddr),
      .ze_imm(ze_imm)
		);
		
		
	mux2_1_64b uncon_br(
		.out(),
		.i0(),
		.i1(),
		.sel()
		);
	
	mux2_1_64b br_taken(
		.out(),
		.i0(),
		.i1(),
		.sel()
		);
	
	
	//BOTTOM MODULES (MEMORY AND REGFILE)
	
endmodule


