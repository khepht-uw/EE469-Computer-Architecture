//

module register(output logic [31:0][63:0] q,
					input logic [63:0] d,
					input logic [31:0] w_en,
					input logic reset,
					input logic clk
					);
	
	genvar i;
	generate
		for (i = 0; i < 31; i++) begin : gen_regs
			dffx64 regs (.q(q[i]), .d(d), .en(w_en[i]), .reset(reset), .clk(clk));
		end
	endgenerate
	
	assign q[31] = 64'b0; //Hardcode register 31 to be 0's
endmodule
