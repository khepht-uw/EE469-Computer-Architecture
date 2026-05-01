//Sign extender, done

module se (input logic [31:0] instruction,
			  output logic [63:0] se_dAddr,
			  output logic [63:0] se_condAddr,
			  output logic [63:0] se_brAddr,
			  output logic [63:0] ze_imm //Zero extend to get a positive number for immediate
			  );

	assign se_dAddr = {{55{instruction[20]}},  instruction[20:12]};		//64-9=55
	assign se_condAddr = {{45{instruction[23]}}, instruction[23:5]};		//64-19=45
	assign se_brArddr = {{38{instruction[25]}}, instruction[25:0]};	//64-26=38
	
	assign ze_imm = {52'b0, instruction[21:10]};
endmodule
