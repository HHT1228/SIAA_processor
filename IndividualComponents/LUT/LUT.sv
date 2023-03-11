// Lookup table
module LUT (
  input        [7:0] key,
  
  output logic [7:0] LUTaddr // Target address
  );

  always_comb begin
    case(key)
      // big numbers
      0:  LUTaddr = 8'b00100000; // 32
      1:  LUTaddr = 8'b00100001;// 33
      2:  LUTaddr = 8'b00100010; // 34
      3:  LUTaddr = 8'b00100011; // 35
      4:  LUTaddr = 8'b01000000;
      5:  LUTaddr = 8'b01011011;
      6:  LUTaddr = 8'b01101101;
      7:  LUTaddr = 8'b10001110;
      8:  LUTaddr = 8'b10101000;
      9:  LUTaddr = 8'b10101010;
      10: LUTaddr = 8'b11001000;
      11: LUTaddr = 8'b11001100;
      12: LUTaddr = 8'b11100000;
      13: LUTaddr = 8'b11101000;
      14: LUTaddr = 8'b11110000;
      15: LUTaddr = 8'b11111110;

      // branch addresses
      16: LUTaddr = 2; // Program 1: LOOP
      17: LUTaddr = 4; // Program 2: loop_start
      18: LUTaddr = 104; // Program 2: loop_one_error
      19: LUTaddr = 137; // Program 2: loop_error_b1
      20: LUTaddr = 141; // Program 2: loop_error_b234
      21: LUTaddr = 145; // Program 2: loop_error_b5678
      22: LUTaddr = 147; // Program 2: loop_error_LSW
      23: LUTaddr = 154; // Program 2: loop_end
      24: LUTaddr = 9; // Program 3: LOOP1_part_a
      25: LUTaddr = 17; // Program 3: LOOP1_J_loop
      26: LUTaddr = 58; // Program 3: LOOP2_part_a
      27: LUTaddr = 68; // Program 3: LOOP2_J_loopA
      28: LUTaddr = 110; // Program 3: LOOP2_J_loopInByte
      29: LUTaddr = 120; // Program 3: LOOP2_J_loopB
      30: LUTaddr = 136; // Program 3: LOOP2_part_b

      default: LUTaddr = 0;
    endcase
  end

endmodule
