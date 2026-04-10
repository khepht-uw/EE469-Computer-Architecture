//

module regfile (output logic [63:0] ReadData1,
					output logic [63:0] ReadData2,
					input  logic [63:0] WriteData,
					input  logic [4:0]  ReadRegister1,
					input  logic [4:0]  ReadRegister2,
					input  logic [4:0]  WriteRegister,
					input  logic  RegWrite,
					input  logic  clk,
					input  logic  reset
					);

    wire [31:0] write_enables;
    wire [31:0][63:0] reg_outputs;

    wire [31:0] mux_inputs1 [63:0];
    wire [31:0] mux_inputs2 [63:0];

    e_decoder5_32 dec(.out(write_enables), .in(WriteRegister), .en(RegWrite));

    register reg_array (.q(reg_outputs), .d(WriteData), .w_en(write_enables), .reset(reset), .clk(clk));
							  
	genvar i, j;
   generate
		for (i = 0; i < 64; i++) begin : read_bits
			for (j = 0; j < 32; j = j + 1) begin : get_reg
				assign mux_inputs1[i][j] = reg_outputs[j][i];
            assign mux_inputs2[i][j] = reg_outputs[j][i];
			end
		end
		for (i = 0; i < 64; i++) begin : gen_muxes
			mux32_1 muxA (.out(ReadData1[i]), .in(mux_inputs1[i]), .sel(ReadRegister1));
			mux32_1 muxB (.out(ReadData2[i]), .in(mux_inputs2[i]), .sel(ReadRegister2));
		end
   endgenerate
endmodule
