`timescale 1ps/1ps

module cpu (
	input logic clk,
   input logic reset
	);

	//WIRES
	//PC Wires
	logic [31:0] instruction;
	logic [63:0] PC_current, PC_next, PC_add4, branch_target;
	logic [63:0] PC_after_branch; // intermediate wire between the BrTaken and BranchReg

	//Control wires
	logic Reg2Loc, RegWrite;
	logic ALUSrc, FlagWrite, ImmSrc;
	logic Branch, UncondBranch, BL, BRSel;
	logic MemWrite, MemtoReg, MemRead;
	logic [2:0] ALUOp;
	
	//Register file wires
	logic [4:0]  reg_read1, reg_read2, reg_write;
   logic [63:0] reg_data1, reg_data2, reg_writedata;
	
	//Sign extender wires
	logic [63:0] se_dAddr, se_condAddr, se_brAddr, ze_imm;
	logic [63:0] br_imm_selected; // mux of condAddr and brAddr
	logic [63:0] br_shifted;      // after << 2
	logic [63:0] muxImmtoALU; //For mux to choose between Daddr9 or IMM from ADDI instruction
	
	//ALU wires
	logic [63:0] alu_b, alu_result;
	logic zero, carryout, overflow, negative;
	
	//Flag register wires
	logic flag_zero, flag_carryout, flag_overflow, flag_negative;
	
	//Data memory wires
	logic [63:0] mem_out;
	logic [4:0] reg_write_addr; //For BL
	
	//Branch logic wires
	logic cbz_taken, blt_taken, BrTaken;
   logic neg_xor_ovf; //For B.LT
	logic [63:0] bl_writedata;
	
	
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
		.out(br_imm_selected),
		.i0(se_condAddr),
		.i1(se_brAddr),
		.sel(UncondBranch)
		);
		
	assign br_shifted = {br_imm_selected[61:0], 2'b00};//Shift left by 2 bits
	
		
	adder64 br_adder(
		.A(br_shifted),
		.B(PC_current),
		.cin(1'b0),
		.result(branch_target),
		.cout() //Unused
		);
		
	adder64 pc_plus4(
		.A(PC_current),
		.B(64'd4),
		.cin(1'b0),
		.result(PC_add4),
		.cout() //Unused
		);
	
	mux2_1_64b br_taken(
		.out(PC_after_branch),
		.i0(PC_add4),
		.i1(branch_target),
		.sel(BrTaken)
		);
		
	and #50 g_cbz(cbz_taken, Branch, zero);
	xor #50 g_xor(neg_xor_ovf, flag_negative, flag_overflow);
	and #50 g_blt(blt_taken, Branch, neg_xor_ovf);
	or #50 g_brt(BrTaken, UncondBranch, cbz_taken, blt_taken); //Branch if any of these are true
	
	
	//BOTTOM MODULES (MEMORY AND REGFILE)
	control cntrl(
		.instruction(instruction[31:21]),
		.Reg2Loc(Reg2Loc),
		.UncondBranch(UncondBranch),
		.Branch(Branch),
      .MemRead(MemRead),
      .MemtoReg(MemtoReg),
      .MemWrite(MemWrite),
      .ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
      .FlagWrite(FlagWrite),
      .ImmSrc(ImmSrc),
		.BL(BL),
		.BRSel(BRSel),
      .ALUOp(ALUOp)
		);
		
	mux2_1_5b reg2sel(
		.out(reg_read2),
		.i0(instruction[20:16]),
		.i1(instruction[4:0]),
		.sel(Reg2Loc)
		);
		
//	assign reg_read1 = instruction[9:5]; Replaced with the following:
	mux2_1_5b reg1_mux(
    .out(reg_read1),
    .i0(instruction[9:5]),  // normal: Rn
    .i1(instruction[4:0]),  // BR: Rd
    .sel(BRSel)
	);

	regfile rf(
		.ReadData1(reg_data1),
		.ReadData2(reg_data2),
		.WriteData(bl_writedata),
		.ReadRegister1(reg_read1),
		.ReadRegister2(reg_read2),
		.WriteRegister(reg_write_addr),
		.RegWrite(RegWrite),
		.clk(clk),
		.reset(reset)
		);
		
	// ImmSrc mux: selects between DAddr9 and Imm12
	mux2_1_64b imm_sel(
		.out(muxImmtoALU),
		.i0(se_dAddr),   // LDUR/STUR
		.i1(ze_imm),     // ADDI
		.sel(ImmSrc)
		);

	// ALUSrc mux: selects between register data and immediate
	mux2_1_64b alu_src(
		.out(alu_b),
		.i0(reg_data2),    // R-type
		.i1(muxImmtoALU),  // immediate
		.sel(ALUSrc)
		);
		
	alu main_alu(
		.A(reg_data1),
		.B(alu_b),
		.cntrl(ALUOp),
		.result(alu_result),
		.negative(negative),
		.zero(zero),
		.overflow(overflow),
		.carry_out(carryout)
	);
	
	flags flag_reg(
		.clk(clk),
		.reset(reset),
		.en(FlagWrite),
		.neg_in(negative),
		.zero_in(zero),
		.of_in(overflow),
		.co_in(carryout),
		.negative(flag_negative),
		.zero(flag_zero),
		.overflow(flag_overflow),
		.carryout(flag_carryout)
		);

	datamem data_memory(
		.address(alu_result),
		.write_enable(MemWrite),
		.read_enable(MemRead),
		.write_data(reg_data2),
		.clk(clk),
		.xfer_size(4'd8), // always 64-bit transfers
		.read_data(mem_out)
		);
		
	mux2_1_64b mem_mux(
		.out(reg_writedata),
		.i0(alu_result),
		.i1(mem_out),
		.sel(MemtoReg)
		);
		
	mux2_1_64b bl_mux(
		.out(bl_writedata), 
		.i0(reg_writedata),	// BL=0: normal writeback
		.i1(PC_add4),			// BL=1: return address
		.sel(BL)
		);
	
	mux2_1_64b br_sel(
		.out(PC_next),
      .i0(PC_after_branch),
      .i1(reg_data1), // Reg[Rd] — 64b ReadData1 from regfile
      .sel(BRSel)
      );

	mux2_1_5b bl_reg_mux(
		.out(reg_write_addr),
		.i0(instruction[4:0]),  // BL=0: normal Rd
		.i1(5'b11110),          // BL=1: X30
		.sel(BL)
		);

endmodule


