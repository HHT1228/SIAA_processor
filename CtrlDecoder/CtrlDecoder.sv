// Control Decoder
module CtrlDecoder (
	input [8:0]  instr,   // 9-bit instruction

	output logic 	regWrite,	// Write enable signal, write to R0
						regSet,		// Signal for write to general registers
//						reset,		// 
						LUT,			// LUT signal to regFile
						
//						memRead,   // Read from Data Memory
						memWrite,  // Write to Data Memory
						
						ctrlBranch,   // Signal for ctrlBranch address
						ALUSrc,	// Control the MUX to select between imm and opRegData
						memToReg,	// Control the MUX to select between dataMem and ALU output
						typeCode,
												
	output logic[3:0]	rOp,
	output logic[2:0]	iOp
  );    

//	logic      typeCode;
//	logic[3:0] rOp;
//	logic[2:0] iOp;
	
	// ALU signals
	assign typeCode = instr[8];     
	assign rOp    = instr[3:0];
	assign iOp    = instr[2:0];
	
	// General control signals
	always_comb begin
		// defaults
		regWrite = 'b0;
		regSet = 'b0;
		LUT = 'b0;	// EXTRA
		memWrite = 'b0;
		ctrlBranch = 'b0;
		ALUSrc = 'b0;	// EXTRA
		memToReg = 'b0;	//EXTRA
	
		if (typeCode) begin // I-type
			case (iOp)
				// ADDI
				3'b000: begin
					regWrite = 'b1;
					ALUSrc = 'b1;
				end
				// SUBI
				3'b001: begin
					regWrite = 'b1;
					ALUSrc = 'b1;
				end
				// ANDI
				3'b010: begin
					regWrite = 'b1;
					ALUSrc = 'b1;
				end
				// SLL
				3'b011: begin
					regWrite = 'b1;
					ALUSrc = 'b1;
				end
				// SRL
				3'b100: begin
					regWrite = 'b1;
					ALUSrc = 'b1;
				end
				// SETI
				3'b101: begin
					regWrite = 'b1;
					ALUSrc = 'b1;
				end
//				3'b110	default
				// LUTA
				3'b111: begin
					regWrite = 'b1;
					LUT = 'b1;
					ALUSrc = 'b1;
				end
			endcase
		end
		
		else if(!typeCode) begin
			case(rOp)
				// ADD
				4'b0000:
					regWrite = 'b1;
				// SUB
				4'b0001:
					regWrite = 'b1;
				// AND
				4'b0010:
					regWrite = 'b1;
				// OR
				4'b0011:
					regWrite = 'b1;
				// XOR
				4'b0100:
					regWrite = 'b1;
				// RXOR
				4'b0101:
					regWrite = 'b1;
				// SLR
				4'b0110:
					regWrite = 'b1;
				// SRR
				4'b0111:
					regWrite = 'b1;
				// LW
				4'b1000: begin
					regWrite = 'b1;
					memToReg = 'b1;
				end
				// SW
				4'b1001:
					memWrite = 'b1;
				// EQ
				4'b1010:
					regWrite = 'b1;
				// SLT
				4'b1011:
					regWrite = 'b1;
				// BR
				4'b1100: begin
					ctrlBranch = 'b1;
//					LUT = 'b1;
				end
				// J
				4'b1101: begin
					ctrlBranch = 'b1;
//					LUT = 'b1;
				end
				// SET
				4'b1110:
					regSet = 'b1;
				// LA
				4'b1111:
					regWrite = 'b1;
					
			endcase			
		end   
  end
endmodule
