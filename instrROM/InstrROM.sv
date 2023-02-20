module InstrRom #(parameter D=8)(
  input       [D-1:0] addr,    // prog_ctr	  address pointer
  output logic[ 8:0] readData);

  logic[8:0] memory[2**D];
  initial							    // load the program
	 $readmemb("mach_code.txt",memory);

  always_comb  readData = memory[addr];

endmodule

