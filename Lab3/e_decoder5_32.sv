//This file will contain the various enabled decoders, starting with a 2:4 decoder, then a 3:8, and lastly a 5:32.
`timescale 1ps/1ps
module e_decoder2_4 (output logic [3:0] out, 
							input logic [1:0] in,
							input logic en
							);
	
	wire [1:0] in_n;
	
	not #50 n0 (in_n[0], in[0]);
	not #50 n1 (in_n[1], in[1]);
	
	and #50 a0 (out[0], in_n[0], in_n[1], en);
	and #50 a1 (out[1], in[0], in_n[1], en);
	and #50 a2 (out[2], in_n[0], in[1], en);
	and #50 a3 (out[3], in[0], in[1], en);
endmodule


module e_decoder3_8 (output logic [7:0] out,
							input logic [2:0] in,
							input logic en
							);

	wire [2:0] in_n;
	
	not #50 n0 (in_n[0], in[0]);
	not #50 n1 (in_n[1], in[1]);
	not #50 n2 (in_n[2], in[2]);
	
	and #50 a0 (out[0], in_n[0], in_n[1], in_n[2], en);
	and #50 a1 (out[1], in[0], in_n[1], in_n[2], en);
	and #50 a2 (out[2], in_n[0], in[1], in_n[2], en);
	and #50 a3 (out[3], in[0], in[1], in_n[2], en);
	and #50 a4 (out[4], in_n[0], in_n[1], in[2], en);
	and #50 a5 (out[5], in[0], in_n[1], in[2], en);
	and #50 a6 (out[6], in_n[0], in[1], in[2], en);
	and #50 a7 (out[7], in[0], in[1], in[2], en);
endmodule


module e_decoder5_32 (output logic [31:0] out,
							input logic [4:0] in,
							input logic en
							);

	wire [3:0] aOut;
	
	e_decoder2_4 a0 (.out(aOut[3:0]), .in(in[4:3]), .en(en));
	
	e_decoder3_8 b0(.out(out[7:0]), .in(in[2:0]), .en(aOut[0]));
	e_decoder3_8 b1(.out(out[15:8]), .in(in[2:0]), .en(aOut[1]));
	e_decoder3_8 b2(.out(out[23:16]), .in(in[2:0]), .en(aOut[2]));
	e_decoder3_8 b3(.out(out[31:24]), .in(in[2:0]), .en(aOut[3]));
endmodule
	

`timescale 1ps/1ps
module e_decoder5_32_testbench();

	logic [31:0] out;
	logic [4:0] in;
	logic en;
	
	e_decoder5_32 dut (.out(out), .in(in), .en(en));
	
	initial begin
		en = 0; in = 5'b00000; #300; // Disabled cases (en = 0)
		en = 0; in = 5'b00100; #300;
		en = 0; in = 5'b11111; #300;
		
		en = 1; in = 5'b00000; #300; // Enabled cases (en = 0)
		en = 1; in = 5'b00001; #300;
		en = 1; in = 5'b00010; #300;
		en = 1; in = 5'b00100; #300;
		en = 1; in = 5'b01000; #300;
		en = 1; in = 5'b11111; #300;
		
	end
endmodule
		
	