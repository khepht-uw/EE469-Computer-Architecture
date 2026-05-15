//

module regfile(output logic [63:0] ReadData1,
					output logic [63:0] ReadData2,
					input  logic [63:0] WriteData,
					input  logic [4:0]  ReadRegister1,
					input  logic [4:0]  ReadRegister2,
					input  logic [4:0]  WriteRegister,
					input  logic  RegWrite,
					input  logic  clk,
					input logic reset //Add back from prev labs
					);

   wire [31:0] write_enables;
   wire [31:0][63:0] reg_outputs;

   e_decoder5_32 dec(.out(write_enables), .in(WriteRegister), .en(RegWrite));

   register reg_array (.q(reg_outputs), .d(WriteData), .w_en(write_enables), .reset(reset), .clk(clk));
	
	mux64x32_1 muxA (.out(ReadData1), .in(reg_outputs), .sel(ReadRegister1));
	mux64x32_1 muxB (.out(ReadData2), .in(reg_outputs), .sel(ReadRegister2));
 
endmodule
