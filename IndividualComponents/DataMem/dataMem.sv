// 8-bit wide, 256-word (byte) deep memory array
module dataMem (
	input[7:0] writeData,
	input      clk,
	input      memWrite,	      // Write enable signal
	input[7:0] addr,		      // address pointer
	output logic[7:0] readData
	);

	logic[7:0] memory[256];       // 2-dim array  8 wide  256 deep

	// Combinational Read
	assign readData = memory[addr];

	// Sequential write -- occur on stores or pushes 
	always_ff @(posedge clk) begin
		if(memWrite) begin				  // wr_en usually = 0; = 1 		
			memory[addr] <= writeData;
		end
	end

endmodule