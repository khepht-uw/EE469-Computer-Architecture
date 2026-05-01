//

`timescale 1ps/1ps
module alu (input logic [63:0] A,
				input logic [63:0] B,
				input logic [2:0] cntrl,
				output logic [63:0] result,
				output logic negative,
				output logic zero,
				output logic overflow,
				output logic carry_out
				);
	
	wire [64:0] carrier; //65 total wires, [0-63] for ripple through cin/cout, [64] for final carry_out
	wire sameSign, signChange;
	wire [15:0] orLvl1;
	wire [3:0] orLvl2;
	
	assign carrier[0] = cntrl[0];
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin : gen_slices
			alu_slice alus (.a(A[i]), .b(B[i]), .cin(carrier[i]), .control(cntrl[2:0]), .out(result[i]), .cout(carrier[i+1]));
		end
	endgenerate
	
	assign carry_out = carrier[64];
	
	assign negative = result[63]; //If MSB is 0, negative 0, if it's 1, the number is negative and gets 1
	
	genvar j, k;
	generate
		for (j = 0; j < 16; j++) begin : zeros_lvl1
			or #50 orTree1 (orLvl1[j], result[j*4], result[j*4 + 1], result[j*4 + 2], result[j*4 + 3]);
		end
	endgenerate
	generate
		for (k = 0; k < 4; k++) begin: zeros_lvl2
			or #50 orTree2 (orLvl2[k], orLvl1[k*4], orLvl1[k*4 + 1], orLvl1[k*4 + 2], orLvl1[k*4 + 3]);
		end
	endgenerate
	nor #50 get_zero (zero, orLvl2[0], orLvl2[1], orLvl2[2], orLvl2[3]);
	
	//Overflow
	xor #50 get_overflow (overflow, carrier[63], carrier[64]); //Checks if the line going into MSB is different from what goes out
endmodule
