// program counter
module PC #(parameter D=8)(
	input reset,					// synchronous reset
			clk,
			branch,
  input       [D-1:0] target,	// how far/where to jump
  output logic[D-1:0] progCtr
);

	always_ff @(posedge clk) begin
		if(reset) begin
			progCtr <= '0;
		end
		else if(branch) begin
			progCtr <= target;
		end
		else begin
			progCtr <= progCtr + 'b1;
		end
	end

endmodule