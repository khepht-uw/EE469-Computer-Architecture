//

`timescale 1ps/1ps
module sixtyfournor (
    input  logic [63:0] in,
    output logic zero
);

    wire [31:0] or1;
    wire [15:0] or2;
    wire [7:0]  or3;
    wire [3:0]  or4;
    wire [1:0]  or5;
    wire or6;

    genvar i;

    // 64 bits
    generate
        for (i = 0; i < 32; i++) begin : level1
            or #50 o1(or1[i], in[2*i], in[2*i+1]);
        end
    endgenerate

    // 32
    generate
        for (i = 0; i < 16; i++) begin : level2
            or #50 o2(or2[i], or1[2*i], or1[2*i+1]);
        end
    endgenerate

    // 16
    generate
        for (i = 0; i < 8; i++) begin : level3
            or #50 o3(or3[i], or2[2*i], or2[2*i+1]);
        end
    endgenerate

    // 8
    generate
        for (i = 0; i < 4; i++) begin : level4
            or #50 o4(or4[i], or3[2*i], or3[2*i+1]);
        end
    endgenerate

    // 4
    generate
        for (i = 0; i < 2; i++) begin : level5
            or #50 o5(or5[i], or4[2*i], or4[2*i+1]);
        end
    endgenerate

    // 2
    or  #50 o6(or6, or5[0], or5[1]);
    not #50 n0(zero, or6);
endmodule
