//

`timescale 1ps/1ps
module fullAdder (input logic A,
						input logic B,
						input logic cin,
						output logic sum,
						output logic cout
						);
	//assign sum = A ^ B ^ cin; - Original logic, adjust to use actual gates
	//assign cout = A&B | cin & (A^B);		
	wire aXb, ab, a1out; //a XOR b, a AND b, 2nd AND out
	
	xor #50 x0 (aXb, A, B);
	and #50 a0 (ab, A, B);
	
	xor #50 x1 (sum, aXb, cin);
	and #50 a1 (a1out, aXb, cin);
	
	or #50 o2 (cout, a1out, ab);
endmodule


`timescale 1ps/1ps
module fullAdder_testbench();

    logic A, B, cin;
    logic sum, cout;

    fullAdder dut ( //Instantiate module
        .A(A),
        .B(B),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );


    initial begin
        // Case 0: 0+0+0 = 0
        A = 0; B = 0; cin = 0; #200;
        
        // Case 1: 1+0+0 = 1
        A = 1; B = 0; cin = 0; #200;
        
        // Case 2: 1+1+0 = 2 (Sum 0, Carry 1)
        A = 1; B = 1; cin = 0; #200;
        
        // Case 3: 1+1+1 = 3 (Sum 1, Carry 1)
        A = 1; B = 1; cin = 1; #200;

        $stop; 
    end
endmodule
