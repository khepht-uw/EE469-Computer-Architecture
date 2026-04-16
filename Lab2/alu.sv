//

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
	
	assign carrier[0] = cntrl[0];
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin : gen_slices
			alu_slice alus (.a(A[i]), .b(B[i]), .cin(carrier[i]), .control(cntrl[2:0]), .out(result[i]), .cout(carrier[i+1]));
		end
	endgenerate
	
	assign carry_out = carrier[64];
	
	//TODO: Flag logic, then update alustim file
	assign negative = result[63]; //If MSB is 0, negative 0, if it's 1, the number is negative and gets 1
	nor #50 isZero (zero, result, 64'b0);
	//Overflow
	xnor #50 of_init (sameSign, A[63], B[63]);
	xor #50 resChange (signChange
	xor #50 of (overflow, sameSign, result[63]);
endmodule
