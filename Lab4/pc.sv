//Program counter, done

module pc(input logic [63:0] next_pc,
			 input logic clk,
			 input logic reset,
			 output [63:0] current_pc
			 );
			 
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin: pc_bits
			D_FF dffs(.q(current_pc[i]), .d(next_pc[i]), .reset(reset), .clk(clk));
		end
	endgenerate
endmodule
