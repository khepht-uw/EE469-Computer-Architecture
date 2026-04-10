//

module mux64x32_1 (output logic [63:0] out,
						input logic [31:0][63:0] in,
						input logic [4:0] sel
						);
						
	genvar i, j;
	generate
		for (i = 0; i < 64; i++) begin : gen_muxes 
			wire [31:0] temp; // 32-bit wire that holds column i
			for(j = 0; j < 32; j++) begin : gen_slice
				assign temp[j] = in[j][i]; // slice bit i at register j and wire it
			end
		mux32_1 m32 (.out(out[i]), .in(temp), .sel(sel));
		end
	endgenerate
endmodule
