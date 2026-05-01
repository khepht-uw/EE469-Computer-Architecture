//

`timescale 1ps/1ps
module alu_slice (input logic a,
						input logic b,
						input logic cin,
						input logic [2:0] control,
						output logic out,
						output logic cout
						);
						
	wire outAND, outOR, outXOR; //Logic gate outputs
	wire b_n; //NOT gate for b input
	wire outFA, outmuxb; //Full adder sum and mux output
	
	not #50 n0 (b_n, b);
	mux2_1 muxb (.out(outmuxb), .i0(b), .i1(b_n), .sel(control[0]));	//Control[0] is the subtract enable, rightmost bit
																							//When control[0]=1, it feeds NOT b, and in the FA...
	fullAdder FA (.A(a), .B(outmuxb), .cin(cin), .sum(outFA), .cout(cout)); //... cin would be connected to control[0], so we add 1,
																									//correctly subtracting using 2's complement (A + NOT B + 1)
	and #50 a100 (outAND, a, b);
	or #50 o101 (outOR, a, b);
	xor #50 x110 (outXOR, a, b);
	
	//000 = B, 010 = ADD, 011 = SUB, 100 = AND, 101 = OR, 110 = XOR
	brute_mux8_1 mux0 (.out(out),
					.i0(b), .i1(1'b0), .i2(outFA), .i3(outFA), .i4(outAND), .i5(outOR), .i6(outXOR), .i7(1'b0),
					.sel(control[2:0])); //001 and 111 aren't assigned anything in alustim, tie to 0
endmodule
