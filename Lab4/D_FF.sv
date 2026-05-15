//

module D_FF (q, d, reset, clk);
	output reg q;
	input d, reset, clk;
	
	always_ff @(posedge clk or posedge reset)
	if (reset)
		q <= 0; // On reset, set to 0
	else
		q <= d; // Otherwise out = d
endmodule


module dffx64 (output logic [63:0] q, //One instantiation outputs 64 bits-
					input logic [63:0] d,  //-and receives 64 bits
					input logic en,
					input logic reset,
					input logic clk
					);
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin : gen_dffs
			logic mux_out;
			mux2_1 m0 (.out(mux_out), .i0(q[i]), .i1(d[i]), .sel(en));	//If en is off, feed current output (q) into d so it doesn't change
			D_FF dffs (.q(q[i]), .d(mux_out), .reset(reset), .clk(clk));
		end
	endgenerate
endmodule
