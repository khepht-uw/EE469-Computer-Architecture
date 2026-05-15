//
`timescale 1ps/1ps
module mux2_1 (output logic out,
					input logic i0,
					input logic i1, //Use two clear logical inputs for ease of use in outside modules
					input logic sel
					);
	
	wire out0, out1, nSel;
	
	not #50 nGate (nSel, sel); 			//assign out = (i1 & sel) | (i0 & ~sel);
	and #50 a0 (out0, i0, nSel);
	and #50 a1 (out1, i1, sel);
	
	or #50 oGate (out, out0, out1);
	
endmodule

module brute_mux4_1 (output logic out,
					input logic i00,
					input logic i01,
					input logic i10,
					input logic i11,
					input logic sel0,
					input logic sel1
					);
			
	wire outA, outB;
	
	mux2_1 a0 (.out(outA), .i0(i00), .i1(i01), .sel(sel0));
	mux2_1 a1 (.out(outB), .i0(i10), .i1(i11), .sel(sel0));
	
	mux2_1 b (.out(out), .i0(outA), .i1(outB), .sel(sel1));
endmodule

module mux4_1 (output logic out,
					input logic [3:0] in,
					input logic [1:0] sel
					);

	wire outA, outB;
	
	mux2_1 a0 (.out(outA), .i0(in[0]), .i1(in[1]), .sel(sel[0]));
	mux2_1 a1 (.out(outB), .i0(in[2]), .i1(in[3]), .sel(sel[0]));
	
	mux2_1 b (.out(out), .i0(outA), .i1(outB), .sel(sel[1]));
endmodule

module brute_mux8_1 (output logic out,
					input logic i0,
					input logic i1,
					input logic i2,
					input logic i3,
					input logic i4,
					input logic i5,
					input logic i6,
					input logic i7,
					input logic [2:0] sel
					);
					
	wire outA, outB;
	
	brute_mux4_1 a0 (.out(outA), .i00(i0), .i01(i1), .i10(i2), .i11(i3), .sel0(sel[0]), .sel1(sel[1]));
	brute_mux4_1 a1 (.out(outB), .i00(i4), .i01(i5), .i10(i6), .i11(i7), .sel0(sel[0]), .sel1(sel[1]));
	
	mux2_1 b (.out(out), .i0(outA), .i1(outB), .sel(sel[2]));
endmodule

module mux8_1 (output logic out,
					input logic [7:0] in,
					input logic [2:0] sel
					);
					
	wire outA, outB;
	
	mux4_1 a0 (.out(outA), .in(in[3:0]), .sel(sel[1:0]));
	mux4_1 a1 (.out(outB), .in(in[7:4]), .sel(sel[1:0]));
	
	mux2_1 b (.out(out), .i0(outA), .i1(outB), .sel(sel[2]));
endmodule
	
	
module mux16_1 (output logic out,
					input logic [15:0] in,
					input logic [3:0] sel
					);
					
	wire outA, outB;
	
	mux8_1 a0 (.out(outA), .in(in[7:0]), .sel(sel[2:0]));
	mux8_1 a1 (.out(outB), .in(in[15:8]), .sel(sel[2:0]));
	
	mux2_1 b (.out(out), .i0(outA), .i1(outB), .sel(sel[3]));
endmodule


module mux32_1 (output logic out,
					input logic [31:0] in,
					input logic [4:0] sel
					);

	wire outA, outB;
	
	mux16_1 a0 (.out(outA), .in(in[15:0]), .sel(sel[3:0]));
	mux16_1 a1 (.out(outB), .in(in[31:16]), .sel(sel[3:0]));
	
	mux2_1 b (.out(out), .i0(outA), .i1(outB), .sel(sel[4]));
endmodule


`timescale 1ps/1ps
module mux32_1_testbench();

	logic out;
	logic [31:0] in;
	logic [4:0] sel;

	mux32_1 dut (.out(out), .in(in), .sel(sel));

	integer i;

	initial begin
		// Set a known, easy pattern
		in = 32'b10101010101010101010101010101010;

		// Try all select values
		for (i = 0; i < 32; i++) begin
			sel = i;
			#150;
		end

		// Change pattern to test again
		in = 32'b01010101010101010101010101010101;

		for (i = 0; i < 32; i++) begin
			sel = i;
			#150;
		end
	end

endmodule
