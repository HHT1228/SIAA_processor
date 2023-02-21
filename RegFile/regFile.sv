// cache memory/register file
// default address pointer width = 4, for 16 registers
module regFile #(parameter pw = 4)(
	// Signal inputs
	input clk,
			regWrite,	// Write enable signal
			regSet,		// Signal for write to general registers
			reset,
			LUTSet,         // Signal for LUT
	
	input[7:0]	writeData,	// Data to write to accumulator
					LUTaddr,		// Target address from LUT
	input[pw:0]	opRegAddr,	// Operand register pointer
	
	output logic[7:0] accData,		// Data read from r0
							opRegData	// Data read from operand reg
	);

	logic[7:0] registers[2**pw];    // 2-dim array  8 wide  16 deep

	// Combinational read
	assign accData = registers[0];
	assign opRegData = registers[opRegAddr];
	
	// Sequential write
	always_ff @(posedge clk) begin
		// LUT
		if (LUTsignal) begin
			registers[0] <= LUTaddr;
		end
		// Writeback to accumulator
		else if(regWrite) begin
			registers[0] <= writeData;
		end
		// Handle set instruction within register files
		else if(regSet) begin
			registers[opRegAddr] <= registers[0];
		end
		// Clear registers for reset signal
		else if(reset) begin
			for (int i = 0; i < 2**pw; i++)
				registers[i] <= 0;
		end
				
	end

endmodule
