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
