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

module mux8_1 (output logic out,
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
	
	mux4_1 a0 (.out(outA), .i00(i0), .i01(i1), .i10(i2), .i11(i3), .sel0(sel[0]), .sel1(sel[1]));
	mux4_1 a1 (.out(outB), .i00(i4), .i01(i5), .i10(i6), .i11(i7), .sel0(sel[0]), .sel1(sel[1]));
	
	mux2_1 b (.out(out), .i0(outA), .i1(outB), .sel(sel[2]));
endmodule


`timescale 1ps/1ps
module mux2_1_testbench();

	logic i0, i1, sel;
	logic out;
	logic out0, out1, nSel;

	mux2_1 dut (.out, .i0, .i1, .sel);

	initial begin
		sel=0; i0=0; i1=0; #150;
		sel=0; i0=0; i1=1; #150;
		sel=0; i0=1; i1=0; #150;
		sel=0; i0=1; i1=1; #150;
		sel=1; i0=0; i1=0; #150;
		sel=1; i0=0; i1=1; #150;
		sel=1; i0=1; i1=0; #150;
		sel=1; i0=1; i1=1; #150;
	end
endmodule
