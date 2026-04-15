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
	assign carrier[0] = cntrl[0];
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin : gen_slices
			alu_slice alus (.a(A[i]), .b(B[i]), .cin(carrier[i]), .control(cntrl[2:0]), .out(result[i]), .cout(carrier[i+1]));
		end
	endgenerate
	
	assign carry_out = carrier[64];
	
	//TODO: Flag logic, then update alustim file
	
endmodule
