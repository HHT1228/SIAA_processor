// Lookup table
module LUT (
  input        [4:0] key,
  
  output logic [7:0] LUTaddr // Target address
  );

  always_comb begin
    case(key)
      0:  LUTaddr = 8'b00100000; // 32
      1:  LUTaddr = 8'b00100001;// 33
      2:  LUTaddr = 8'b00100010; // 34
      3:  LUTaddr = 8'b00100011; // 35
      4:  LUTaddr = 8'b00111100; // 60
      5:  LUTaddr = 8'b01000000; // 64
      6:  LUTaddr = 8'b01011011; // 91
      7:  LUTaddr = 8'b01101101; // 109
      8:  LUTaddr = 8'b10000000; // 128
      9:  LUTaddr = 8'b10001110; // 142
      10: LUTaddr = 8'b10101000; // 168
      11: LUTaddr = 8'b10101010; // 170
      12: LUTaddr = 8'b11001000; // 200
      13: LUTaddr = 8'b11001100; // 204
      14: LUTaddr = 8'b11100000; // 224
      15: LUTaddr = 8'b11101000; // 232
      16: LUTaddr = 8'b11110000; // 240
      17: LUTaddr = 8'b11111110; // 254

      default: LUTaddr = 0;
    endcase
  end

endmodule
