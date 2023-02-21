// combinational -- no clock
// sample -- change as desired
module alu(
	input signed[7:0]	acc, opReg,	// Register inputs
	input[4:0]	imm,			// Immediate input
	input			typeCode,	// Type code (0 for R, 1 for I)
	input[3:0]	rOp,			// R-type funct code
	input[2:0]	iOp,			//	I-type funct code
	input			scIn,       // Shift_carry in
	output logic signed[7:0] rslt,		// ALU operation results
	output logic 		scOut,		// shift_carry out
							zero,		// NOR (output)
							branch	// Conditional branch flag
);

always_comb begin 
	rslt = 'b0;            
	scOut = 'b0;    
	zero = !rslt;
	branch = 0;

	// R-type instructions (typeCode == 0)
	if(!typeCode)begin
		case(rOp)
			// ADD
			4'b0000:
				{scOut,rslt} = acc + opReg + scIn;
			// SUB
			4'b0001:
				{scOut,rslt} = acc - opReg + scIn;
			// AND
			4'b0010:
				rslt = acc & opReg;
			// OR
			4'b0011:
				rslt = acc | opReg;
			// XOR
			4'b0100:
				rslt = acc ^ opReg;
			// RXOR
			4'b0101:
				rslt = ^(opReg);
			// SLR
			4'b0110:
				rslt = acc << opReg;
			// SRR
			4'b0111:
				rslt = acc >> opReg;
			// LW
			4'b1000:
				rslt = opReg;
			// SW
			4'b1001:
				rslt = opReg;
			// EQ
			4'b1010:
				if(acc == opReg)
					rslt = 1;
				else
					rslt = 0;
			// SLT
			4'b1011:
				if(acc < opReg)
					rslt = 1;
				else
					rslt = 0;
			// BR
			4'b1100:
				if(acc == 1)
					branch = 1;
				else
					branch = 0;
			// J
			4'b1101:
				branch = 1;
			// SET
			4'b1110:
				rslt = acc;
			// LA
			4'b1111:
				rslt = opReg;
			default:
				rslt = 'b0;
			endcase
	end
	
	// I-type instruction (typeCode == 1)
	else if(typeCode)begin
		case(iOp)
			// ADDI
			3'b000:
				{scOut,rslt} = acc + {3'b000, imm} + scIn;
			// SUBI
			3'b001:
				{scOut,rslt} = acc - {3'b000, imm} + scIn;
			// ANDI
			3'b010:
				rslt = acc & {3'b000, imm};
			// SLL
			3'b011:
				rslt = acc << imm;
			// SRL
			3'b100:
				rslt = acc >> imm;
			// SETI
			3'b101:
				rslt = imm;
			// LUTA
			3'b111:
				rslt = imm;
		default:
			rslt = 'b0;
		endcase
	end
end
   
endmodule