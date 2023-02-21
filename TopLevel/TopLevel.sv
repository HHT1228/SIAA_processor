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
				ALUSrc,			// Control the MUX to select between imm and opRegData
				memToReg;		// Control the MUX to select between dataMem and ALU output
	
	// PC branch signal
	logic pcBranch;
//	assign pcBranch = (aluBranch & ctrlBranch);	// PCSrc signal
	
	// MUX outputs
	logic [8:0]	pcMUX, wbMUX, lutMUX;
	
	/**
		Modules
	*/
	PC myPC(.reset(reset), .clk(clk), .branch(pcBranch), .progCtr(PC));
	
	instrROM myInstrROM(.addr(PC), .readData(instr));
	
	// TODO: writeData (from MUX)
	regFile myRegFile(.clk(clk), 
							.regWrite(regWrite),
							.regSet(regSet),
							.reset(reset),
							.LUTSet(LUTSet),
							.writeData( ),	// TODO
							.opRegAddr(instr[7:4]),
							.accData(accData),
							.opRegData(opRegData));
							
	// TODO: scIn, zero
	ALU coreALU(.acc(accData),
					.opReg(opRegData),
					.imm(instr[7:3]),
					.typeCode(typeCode),
					.rOp(rOp),
					.iOp(iOp),
					.scIn(),	// TODO
					.rslt(rslt),
					.scOut(scOut),
					.zero(),	// TODO
					.branch(aluBranch));
	
	dataMem myDataMem(.writeData(accData),
							.clk(clk),
							.memWrite(memWrite),
							.addr(rslt),
							.readData(readData));
	
	// TODO: both in and out to MUXes
	LUT myLUT(.key(wbMUX), .LUTaddr(LUTaddr));
	
	CtrlDecoder(.instr(instr),
					.regWrite(regWrite),	// Write enable signal, write to R0
					.regSet(regSet),		// Signal for write to general registers
					.LUTSet(LUTSet),			// LUT signal to regFile
					.memWrite(memWrite),  // Write to Data Memory
					.ctrlBranch(ctrlBranch),   // Signal for ctrlBranch address
					.ALUSrc(ALUSrc),	// Control the MUX to select between imm and opRegData
					.memToReg(memToReg),	// Control the MUX to select between dataMem and ALU output
					.typeCode(typeCode),
					.rOp(rOp),
					.iOp(iOp));
					
	
	assign	pcBranch = (aluBranch & ctrlBranch);
	assign	wbMUX = memToReg? readData : rslt;
	assign	lutMUX = LUTSet? LUTaddr : wbMUX;
	assign done = PC == 128;
				
endmodule

//    A = 3;             		  // ALU command bit width
//  wire[D-1:0] target, 			  // jump 
//              prog_ctr;
//  wire        RegWrite;
//  wire[7:0]   datA,datB,		  // from RegFile
//              muxB, 
//			  rslt,               // alu output
//              immed;
//  logic sc_in,   				  // shift/carry out from/to ALU
//   		pariQ,              	  // registered parity flag from ALU
//		zeroQ;                    // registered zero flag from ALU 
//  wire  relj;                     // from control to PC; relative jump enable
//  wire  pari,
//        zero,
//		sc_clr,
//		sc_en,
//        MemWrite,
//        ALUSrc;		              // immediate switch
//  wire[A-1:0] alu_cmd;
//  wire[8:0]   mach_code;          // machine code
//  wire[2:0] rd_addrA, rd_adrB;    // address pointers to reg_file
//// fetch subassembly
//  PC #(.D(D)) 					  // D sets program counter width
//     pc1 (.reset            ,
//         .clk              ,
//		 .reljump_en (relj),
//		 .absjump_en (absj),
//		 .target           ,
//		 .prog_ctr          );
//
//// lookup table to facilitate jumps/branches
//  PC_LUT #(.D(D))
//    pl1 (.addr  (how_high),
//         .target          );   
//
//// contains machine code
//  instr_ROM ir1(.prog_ctr,
//               .mach_code);
//
//// control decoder
//  Control ctl1(.instr(),
//  .RegDst  (), 
//  .Branch  (relj)  , 
//  .MemWrite , 
//  .ALUSrc   , 
//  .RegWrite   ,     
//  .MemtoReg(),
//  .ALUOp());
//
//  assign rd_addrA = mach_code[2:0];
//  assign rd_addrB = mach_code[5:3];
//  assign alu_cmd  = mach_code[8:6];
//
//  reg_file #(.pw(3)) rf1(.dat_in(regfile_dat),	   // loads, most ops
//              .clk         ,
//              .wr_en   (RegWrite),
//              .rd_addrA(rd_addrA),
//              .rd_addrB(rd_addrB),
//              .wr_addr (rd_addrB),      // in place operation
//              .datA_out(datA),
//              .datB_out(datB)); 
//
//  assign muxB = ALUSrc? immed : datB;
//
//  alu alu1(.alu_cmd(),
//         .inA    (datA),
//		 .inB    (muxB),
//		 .sc_i   (sc),   // output from sc register
//		 .rslt       ,
//		 .sc_o   (sc_o), // input to sc register
//		 .pari  );  
//
//  dat_mem dm1(.dat_in(datB)  ,  // from reg_file
//             .clk           ,
//			 .wr_en  (MemWrite), // stores
//			 .addr   (datA),
//             .dat_out());
//
//// registered flags from ALU
//  always_ff @(posedge clk) begin
//    pariQ <= pari;
//	zeroQ <= zero;
//    if(sc_clr)
//	  sc_in <= 'b0;
//    else if(sc_en)
//      sc_in <= sc_o;
//  end
//
//  assign done = prog_ctr == 128;
 
//endmodule