// Lookup table
module LUT (
  input        [3:0] key,
  
  output logic [7:0] LUTaddr // Target address
  );

  always_comb begin
    case(key)
      // every mem byte has index: MSB 7 6 5 4 3 2 1 0 LSB
      0: LUTaddr = 0; // mem[0][7:7] MSW Start; F1
      1: LUTaddr = 1; // mem[0][6:6] F0
      2: LUTaddr = 5; // mem[0][2:2] b11
      3: LUTaddr = 8; // mem[1][7:7] LSW Start
      4: LUTaddr = 240; // mem[30][7:7] MSW Start
      5: LUTaddr = 247; // mem[30][0:0] p8
      6: LUTaddr = 248; // mem[31][7:7] LSW Start
      7: LUTaddr = 251; // mem[31][4:4] p4
      8: LUTaddr = 253; // mem[31][2:2] p2
      9: LUTaddr = 254; // mem[31][1:1] p1
      10: LUTaddr = 255; // mem[31][0:0] p0
      11: LUTaddr = 256; // mem[32][7:7] 5-bit pattern
      12: LUTaddr = 264; // mem[33][7:7]
      13: LUTaddr = 272; // mem[34][7:7]
      14: LUTaddr = 280; // mem[35][7:7]
      default: LUTaddr = 0;
    endcase
  end

endmodule
