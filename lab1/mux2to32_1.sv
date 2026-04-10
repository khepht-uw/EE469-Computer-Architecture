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


module mux4_1 (output logic out,
					input logic [3:0] in,
					input logic [1:0] sel
					);

	wire outA, outB;
	
	mux2_1 a0 (.out(outA), .i0(in[0]), .i1(in[1]), .sel(sel[0]));
	mux2_1 a1 (.out(outB), .i0(in[2]), .i1(in[3]), .sel(sel[0]));
	
	mux2_1 b (.out(out), .i0(outA), .i1(outB), .sel(sel[1]));
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


module mux2_1_testbench();
`timescale 1ps/1ps

	logic i0, i1, sel;
	logic out;
	logic out0, out1, nSel;

	mux2_1 dut (.out, .i0, .i1, .sel);

	initial begin
		sel=0; i0=0; i1=0; #200;
		sel=0; i0=0; i1=1; #200;
		sel=0; i0=1; i1=0; #200;
		sel=0; i0=1; i1=1; #200;
		sel=1; i0=0; i1=0; #200;
		sel=1; i0=0; i1=1; #200;
		sel=1; i0=1; i1=0; #200;
		sel=1; i0=1; i1=1; #200;
	end
endmodule
