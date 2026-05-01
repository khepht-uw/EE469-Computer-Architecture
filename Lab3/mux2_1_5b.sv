module mux2_1_5b (output logic [4:0] out,
						input  logic [4:0] i0,
						input  logic [4:0] i1,
						input  logic sel
						);
    genvar i;
    generate
        for(i = 0; i < 5; i++) begin : mux_bits
            mux2_1 m (.out(out[i]),
							.i0(i0[i]),
							.i1(i1[i]),
							.sel(sel)
							);
        end
    endgenerate
endmodule
