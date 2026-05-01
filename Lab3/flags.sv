//

module flags(
				 input logic clk, reset,
				 input logic en,
				 input logic neg_in, zero_in, of_in, co_in,
				 output logic negative, zero, overflow, carryout
				);
				
	// When en=0, feed current output back in (hold the value)
   // When en=1, take the new value from ALU
   logic neg_d, zero_d, ovf_d, cry_d;

   mux2_1 neg_mux (.out(neg_d), .i0(negative), .i1(neg_in), .sel(en));
   mux2_1 zer_mux (.out(zero_d), .i0(zero), .i1(zero_in), .sel(en));
   mux2_1 ovf_mux (.out(ovf_d), .i0(overflow), .i1(overflow_in), .sel(en));
   mux2_1 cry_mux (.out(cry_d), .i0(carry_out), .i1(carry_in), .sel(en));
	 
	D_FF neg (.q(negative), .d(neg_in), .clk(clk), .reset(reset));
	D_FF zero (.q(zero), .d(zero_in), .clk(clk), .reset(reset));
	D_FF of (.q(overflow), .d(of_in), .clk(clk), .reset(reset));
	D_FF co (.q(carryout), .d(of_in), .clk(clk), .reset(reset));
	
endmodule		