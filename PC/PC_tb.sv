module PC_tb ();
	logic         clk;
	logic         branch;
	logic         reset;
	logic [7:0]   target;
	
	logic [7:0]   progCtr;

	PC dut(.reset(reset),	.clk(clk), .branch(branch), .target(target),	.progCtr(progCtr));
	
	initial begin
		clk = 0;
		#2ns
		reset = 1;
		#10ns
		
		
		#2ns
		reset = 0;
		#100ps
		target = 45;
		branch = 1;
		#4ns
		
		branch = 0;
		#2ns
		target = 127;
		branch = 1;
		#10ns
		branch = 0;
		
		#10ns
		reset = 1;
		#2ns
		reset = 0;
		#10ns
		
		$stop;
		
	end

    always begin
        #1ns
        clk = ~clk;
    end

endmodule
