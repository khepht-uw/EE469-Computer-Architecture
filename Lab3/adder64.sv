//

//64 bit full adder

`timescale 1ps/1ps
module adder64(input logic [63:0] A,
					input logic [63:0] B,
					input logic cin,
					output logic [63:0] result;
					output logic cout
					);

    wire [64:0] carrier;
    assign carry[0] = cin;

    genvar i;
    generate
        for(i = 0; i < 64; i++) begin : adder_bits
            fullAdder fa(
                .A(A[i]),
                .B(B[i]),
                .cin(carrier[i]),
                .sum(result[i]),
                .cout(carrier[i+1])
            );
        end
    endgenerate

    assign cout = carrier[64];

endmodule
