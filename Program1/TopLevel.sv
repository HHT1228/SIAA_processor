// sample top level design
module TopLevel #(parameter D = 12)(
	input clk, reset,
	output logic done
);
	/**
		Outputs from modules
	*/
	// PC output wires
	logic	[7:0]	PC;	// PC
	
	// instrROM output wires
	logic [8:0] instr;	// 9-bit instruction
	
	// RegFile output wires
	logic	[7:0] accData, opRegData;	// Value of acc and operand register
	
	// ALU output wires
	logic signed [7:0] result;	// Signed arithmetic result
	logic aluBranch, scOut;	// ALU branch signal and carry-out
	
	// DataMem output wires
	logic [7:0] readData;	// Data read from data mem
	
	// LUT output wires
	logic [7:0] LUTaddr;		// Address fetched from LUT
	
	// ALU control signals
	logic 		typeCode;
	logic[3:0]	rOp;
	logic[2:0]	iOp;
	
	// Other control signals
	logic 	regWrite,		// Write enable signal, write to R0
				regSet,			// Signal for write to general registers	// 
				LUTSet,			// LUT signal to regFile
				memWrite,  		// Write to Data Memory		
				ctrlBranch,   	// Signal for ctrlBranch address
//				ALUSrc,			// Control the MUX to select between imm and opRegData
				memToReg;		// Control the MUX to select between dataMem and ALU output
	
	// PC branch signal
	logic pcBranch;
//	assign pcBranch = (aluBranch & ctrlBranch);	// PCSrc signal
	
	// MUX outputs
	logic [7:0]	pcMUX, wbMUX, lutMUX;
	
	/**
		Modules
	*/
	PC myPC(.reset(reset), .clk(clk), .branch(pcBranch), .target(opRegData), .progCtr(PC));
	
	InstrROM myInstrROM(.addr(PC), .readData(instr));

	regFile myRegFile(.clk(clk), 
							.regWrite(regWrite),
							.regSet(regSet),
							.reset(reset),
//							.LUTSet(LUTSet),
							.writeData(lutMUX),
//							.lutAddr(),
							.opRegAddr(instr[7:4]),
							.accData(accData),
							.opRegData(opRegData));
							
	alu coreALU(.acc(accData),
					.opReg(opRegData),
					.imm(instr[7:3]),
					.typeCode(typeCode),
					.rOp(rOp),
					.iOp(iOp),
					.scIn('b0),	// Reserved wire
					.rslt(result),
					.scOut(scOut),
					.zero(),	// Reserved wire
					.branch(aluBranch));
	 
	dataMem myDataMem(.writeData(accData),
							.clk(clk),
							.memWrite(memWrite),
							.addr(result),
							.readData(readData));
	
	LUT myLUT(.key(wbMUX), .LUTaddr(LUTaddr));
	
	CtrlDecoder myCtrl(.instr(instr),
					.regWrite(regWrite),	// Write enable signal, write to R0
					.regSet(regSet),		// Signal for write to general registers
					.LUTSet(LUTSet),			// LUT signal to regFile
					.memWrite(memWrite),  // Write to Data Memory
					.ctrlBranch(ctrlBranch),   // Signal for ctrlBranch address
//					.ALUSrc(ALUSrc),	// Control the MUX to select between imm and opRegData
					.memToReg(memToReg),	// Control the MUX to select between dataMem and ALU output
					.typeCode(typeCode),
					.rOp(rOp),
					.iOp(iOp));
					
	
	assign	pcBranch = (aluBranch & ctrlBranch);
	assign	wbMUX = memToReg? readData : result;
	assign	lutMUX = LUTSet? LUTaddr : wbMUX;
//	assign 	pcTarget = pcBranch? PC : opRegData;
	assign done = PC == 128;
				
endmodule