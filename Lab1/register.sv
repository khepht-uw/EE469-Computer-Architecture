//

module register(output logic [31:0][63:0] q,
					input logic [63:0] d,
					input logic [31:0] w_en,
					input logic reset,
					input logic clk
					);
	
	genvar i;
	generate
		for (i = 0; i < 31; i++) begin : gen_regs
			dffx64 regs (.q(q[i]), .d(d), .en(w_en[i]), .reset(reset), .clk(clk));
		end
	endgenerate
	
	assign q[31] = 64'b0; //Hardcode register 31 to be 0's
endmodule


`timescale 1ps/1ps
module register_testbench();

	logic [31:0][63:0] q;
	logic [63:0] d;
	logic [31:0] w_en;
	logic reset, clk;
	
	register dut (.q(q), .d(d), .w_en(w_en), .reset(reset), .clk(clk));
	
	// Clock generation
	initial begin
		clk = 0;
		forever #50 clk = ~clk;  // 100ps period
	end
	
	initial begin
		// Reset everything
		reset = 1; w_en = 0; d = 64'h0; #100;
		reset = 0; #100;
		
		// Write to register 0
		d = 64'hAAAA_AAAA_AAAA_AAAA;
		w_en = 32'b00000000000000000000000000000001; #100;
		
		// Write to register 1
		d = 64'hBBBB_BBBB_BBBB_BBBB;
		w_en = 32'b00000000000000000000000000000010; #100;
		
		// Write to register 5
		d = 64'hCCCC_CCCC_CCCC_CCCC;
		w_en = 32'b00000000000000000000000000100000; #100;
		
		// Try writing to register 31 (should stay 0)
		d = 64'hFFFF_FFFF_FFFF_FFFF;
		w_en = 32'b10000000000000000000000000000000; #100;
		
		// Turn off writes
		w_en = 0; #200;
	end
endmodule
