// ALU test bench
module alu_tb ();
	logic signed[7:0]	accIn;
	logic signed[7:0]	opIn;
	logic[4:0]	immIn;
	logic			typeCode;
	logic[3:0]	rOp;
	logic[2:0]	iOp;
	logic			scIn;
	
	logic signed[7:0]	out;
	logic			scOut;
	logic			zero;
	logic			branchFlag;
	
	// Instantiate ALU module
	alu alu_mod(.acc(accIn), .opReg(opIn), .imm(immIn), .typeCode(typeCode), 
			.rOp(rOp), .iOp(iOp), .scIn(scIn), .rslt(out),
			.scOut(scOut), .zero(zero), .branch(branchFlag));
	// TODO: add J test
	
	initial begin
		// R-type instructions
		$display("R-type operation testing:");
		typeCode = 0;
		
		// ADD
		rOp = 4'b0000;		
		accIn = 44;	//8'b0010_1100
		opIn = 45;	//8'b0010_1101
		scIn = 0;
		#1000ps
		$display("44 + 45 = %d, 89 expected", out);
		
		// SUB
		rOp = 4'b0001;		
		accIn = 45;
		opIn = 44;
		scIn = 0;
		#1000ps
		$display("45 - 44 = %d, 1 expected", out);
		
		//	AND
		rOp = 4'b0010;
		accIn = 8'b00101100;
		opIn =  8'b00101101;
		#1000ps
		$display("00101100 AND 00101101 = %b, 00101100 expected", out);
		
		//	OR
		rOp = 4'b0011;
		accIn = 8'b00101100;
		opIn =  8'b00101101;
		#1000ps
		$display("00101100 OR 00101101 = %b, 00101101 expected", out);
		
		// XOR
		rOp = 4'b0100;
		accIn = 8'b00101100;
		opIn =  8'b00101101;
		#1000ps
		$display("00101100 XOR 00101101 = %b, 00000001 expected", out);
		
		// RXOR
		rOp = 4'b0101;
		opIn =  8'b00101101;
		#1000ps
		$display("^(00101101) = %b, 00000000 expected", out);
		
		//	SLR
		rOp = 4'b0110;
		accIn = 8'b00101100;
		opIn =  2;
		#1000ps
		$display("00101100 << 2 = %b, 10110000 expected", out);
		
		//	SRR
		rOp = 4'b0111;
		accIn = 8'b00101100;
		opIn =  2;
		#1000ps
		$display("00101100 >> 2 = %b, 00001011 expected", out);
		
		//	LW, Using value in the opReg for address, no change expected
		rOp = 4'b1000;
		accIn = 44;
		opIn =  127;
		#1000ps
		$display("Using value in the opReg for address: %d, 127 expected", out);
		
		// SW, Using value in the opReg for address, no change expected
		rOp = 4'b1001;
		accIn = 44;
		opIn =  127;
		#1000ps
		$display("Using value in the opReg for address: %d, 127 expected", out);
		
		// EQ, True
		rOp = 4'b1010;
		accIn = 44;
		opIn =  44;
		#1000ps
		$display("44 == 44: %b, 1 expected", out);
		
		// EQ, False
		rOp = 4'b1010;
		accIn = 0;
		opIn =  127;
		#1000ps
		$display("0 == 127: %b, 0 expected", out);
		
		//	SLT, True
		rOp = 4'b1011;
		accIn = 44;
		opIn =  45;
		#1000ps
		$display("44 < 45: %b, 1 expected", out);
		
		//	SLT, False
		rOp = 4'b1011;
		accIn = 44;
		opIn =  32;
		#1000ps
		$display("44 < 32: %b, 0 expected", out);
		
		//	SLT, False edge
		rOp = 4'b1011;
		accIn = 44;
		opIn =  44;
		#1000ps
		$display("Edge case 44 < 44: %b, 0 expected", out);
		
		//	BR, True
		rOp = 4'b1100;
		accIn = 1;
		#1000ps
		$display("ACC = 1, branch flag: %b, 1 expected", branchFlag);
		
		// BR, False
		rOp = 4'b1100;
		accIn = 0;
		#1000ps
		$display("ACC = 0, branch flag: %b, 0 expected", branchFlag);
		
		// J
		rOp = 4'b1101;
		accIn = 44;
		opIn = 27;
		#1000ps
		$display("Unconditional jump, branch flag: %b, 1 expected", branchFlag);

		// SET
		rOp = 4'b1110;
		accIn = 44;
		#1000ps
		$display("Set ACC value to reg, output: %d, 44 expected", out);
		
		//	LA
		rOp = 4'b1111;
		opIn = 45;
		#1000ps
		$display("Load opReg value to ACC, output: %d, 45 expected", out);
		#1000ps
		
		//	I-type operations
		$display("\n");
		$display("I-type operations testing:");
		typeCode = 1;
		
		// ADDI
		iOp = 3'b000;		
		accIn = 44;	//8'b0010_1100
		immIn = 31;	//5'b11111
		scIn = 0;
		#1000ps
		$display("44 + 31 = %d, 75 expected", out);
		
		// SUBI
		iOp = 3'b001;		
		accIn = 32;	//8'b0010_0000
		immIn = 31;	//5'b11111
		scIn = 0;
		#1000ps
		$display("32 - 31 = %d, 1 expected", out);
		
		// ANDI
		iOp = 3'b010;
		accIn = 8'b00101100;
		immIn =    5'b01101;
		#1000ps
		$display("00101100 AND {000, 01101} = %b, 00001100 expected", out);
		
		//	SLL
		iOp = 3'b011;
		accIn = 8'b00101100;
		immIn =  2;
		#1000ps
		$display("00101100 << 2 = %b, 10110000 expected", out);
		
		// SRL
		iOp = 3'b100;
		accIn = 8'b00101100;
		immIn =  2;
		#1000ps
		$display("00101100 >> 2 = %b, 00001011 expected", out);
		
		//	SETI and LUTA
		iOp = 3'b101;
		immIn = 25;
		#1000ps
		$display("Set immediate input to acc, output: %d, 25 expected", out);
				
	end

endmodule
