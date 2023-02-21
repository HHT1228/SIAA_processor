module MUX (
  input	sel,					
  input  [7:0]i1,
  input	[7:0]i0,	
  output logic[7:0] outData
);

assign outData = sel ? i1 : i0;

endmodule