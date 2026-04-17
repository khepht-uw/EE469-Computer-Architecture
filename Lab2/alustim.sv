// Test bench for ALU
`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i, j;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_B operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001; //Test no flag regular operation
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
		// Wrap Around
		// Adding 1 to the max possible value. 
		// Mathematically: (2^64 - 1) + 1 = 2^64 (which is 0 in a 64-bit space)
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000000 && carry_out == 1 && zero == 1 && overflow == 0);
		// Note: Overflow is 0 because -1 + 1 = 0 is a valid signed operation.

		// Positive Overflow
		// Max Positive + 1. The result will "flip" to negative.
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h8000000000000000 && overflow == 1 && negative == 1 && carry_out == 0);
		// Note: Carry_out is 0 because no bit "fell off" the 64-bit end.

		// Negative Overflow
		// Most Negative + (-1). Adding two negatives results in a positive.
		A = 64'h8000000000000000; B = 64'hFFFFFFFFFFFFFFFF; 
		#(delay);
		assert(result == 64'h7FFFFFFFFFFFFFFF && overflow == 1 && negative == 0 && carry_out == 1);

		// Large Numbers, No Overflow 
		// Adding two numbers with MSB=1 that don't overflow the signed range.
		// (-2) + (-2) = -4
		A = 64'hFFFFFFFFFFFFFFFE; B = 64'hFFFFFFFFFFFFFFFE;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFC && negative == 1 && carry_out == 1 && overflow == 0);

		// Clean Positive addition
		// Using 0 as MSB to avoid negative interpretation.
		// 0111... + 0000...1
		A = 64'h7FFFFFFFFFFFFFFE; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h7FFFFFFFFFFFFFFF && negative == 0 && overflow == 0 && carry_out == 0);
		
		
		$display("%t testing subtraction", $time);
		cntrl = ALU_SUBTRACT; //In subtraction, carryout is always 1 if A >= B due to 2's complement
		A = 64'h0000000000000003; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 0);
		
		
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'h7FFFFFFFFFFFFFFF;
		#(delay);
		assert(result == 64'h0000000000000000 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);
		
		A = 64'h0000000000000001; B = 64'h0000000000000002;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFF && carry_out == 0 && overflow == 0 && negative == 1 && zero == 0);
	end
endmodule
