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
   mux2_1 ovf_mux (.out(ovf_d), .i0(overflow), .i1(of_in), .sel(en));
   mux2_1 cry_mux (.out(cry_d), .i0(carryout), .i1(co_in), .sel(en));
	 
	D_FF ff_neg (.q(negative), .d(neg_d), .clk(clk), .reset(reset));
	D_FF ff_zer (.q(zero), .d(zero_d), .clk(clk), .reset(reset));
	D_FF ff_of (.q(overflow), .d(ovf_d), .clk(clk), .reset(reset));
	D_FF ff_co (.q(carryout), .d(cry_d), .clk(clk), .reset(reset));
	
endmodule		