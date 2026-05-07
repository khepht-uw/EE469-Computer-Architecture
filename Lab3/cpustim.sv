//

`timescale 1ps/1ps
module cpustim();

    logic clk, reset;
    
    // Instantiate CPU
    cpu dut(
        .clk(clk),
        .reset(reset)
    );
    
    // Clock: 10000ps period (long enough for worst-case propagation)
    initial clk = 0;
	 initial $display("Benchmark loaded");
    always #50000 clk = ~clk;
    
    initial begin
		 reset = 1;
		 @(posedge clk);
		 @(negedge clk);
		 reset = 0;
		 repeat(100) @(posedge clk);	
		 $stop;  // forces simulation to stop no matter what
	end

endmodule
