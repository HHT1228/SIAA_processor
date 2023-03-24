# SIAA_processor

## Codes

### Design Files
- `TopLevel.sv`: Top Level module file
- `alu.sv`: ALU module file
- `CtrlDecoder.sv`: Control Decoder module file
- `dataMem.sv`: Data Memory module file
- `InstrROM.sv`: Instruction Memory module file
- `LUT.sv`: Lookup Table module file
- `MUX.sv`: MUX module file
- `PC.sv`: Program Counter module file
- `regFile.sv`: Register File module file

### Other Codes
- `Assembler.py`: Assembler program that translates assembly instructions into binary machine codes
- `Program1`, `Program2`, and `Program3`: Folders containing assembly and machine codes for the three programs
- `prog1_tb.sv`, `prog2_tb.sv`, `prog2_tb_one_error.sv`, `prog3_tb.sv`: Test benches for the three programs
  - `prog2_tb_one_error.sv`: the modified test bench for Program 2 based on `prog2_tb.sv`, generating one-bit error cases only
  
## Initial Values for the Lookup Table
| Key | Value | Meaning |
|---|---|---|
| 0 | 8'b00100000 | Big Number (larger than 5 bits) |
| 1 | 8'b00100001 | Big Number |
| 2 | 8'b00100010 | Big Number |
| 3 | 8'b00100011 | Big Number |
| 4 | 8'b01000000 | Big Number |
| 5 | 8'b01011011 | Big Number |
| 6 | 8'b01101101 | Big Number |
| 7 | 8'b10001110 | Big Number |
| 8 | 8'b10101000 | Big Number |
| 9 | 8'b10101010 | Big Number |
| 10 | 8'b11001000 | Big Number |
| 11 | 8'b11001100 | Big Number |
| 12 | 8'b11100000 | Big Number |
| 13 | 8'b11101000 | Big Number |
| 14 | 8'b11110000 | Big Number |
| 15 | 8'b11111110 | Big Number |
| 16 | 2 | Branch Address (`LOOP` in Program 1 machine code) |
| 17 | 4 | Branch Address (`loop_start` in Program 2 machine code) |
| 18 | 104 | Branch Address (`loop_one_error` in Program 2 machine code) |
| 19 | 154 | Branch Address (`loop_error_b1` in Program 2 machine code) |
| 20 | 158 | Branch Address (`loop_error_b234` in Program 2 machine code) |
| 21 | 162 | Branch Address (`loop_error_b5678` in Program 2 machine code) |
| 22 | 164 | Branch Address (`loop_error_LSW` in Program 2 machine code) |
| 23 | 171 | Branch Address (`loop_end` in Program 2 machine code) |
| 24 | 9 | Branch Address (`LOOP1_part_a` in Program 3 machine code) |
| 25 | 17 | Branch Address (`LOOP1_J_loop` in Program 3 machine code) |
| 26 | 58 | Branch Address (`LOOP2_part_a` in Program 3 machine code) |
| 27 | 68 | Branch Address (`LOOP2_J_loopA` in Program 3 machine code) |
| 28 | 103 | Branch Address (`LOOP2_J_loopInByte` in Program 3 machine code) |
| 29 | 113 | Branch Address (`LOOP2_J_loopB` in Program 3 machine code) |
| 30 | 129 | Branch Address (`LOOP2_part_b` in Program 3 machine code) |


## How to Run the Code
- Download the code
- Download and open ModelSim
- Make sure you have all the design files, one of the test benches, and the machine code for the program same as that for the test bench ready in one folder
- `File` ->  `New` -> `Project`
- `Project Location` -> `Browse` -> Choose the folder with all files and codes ready
- `Add Existing File` -> Select all the `.sv` files in the folder
- `Compile` -> `Compile All`
- `Simulate` -> `Start Simulation`
- `work` -> choose the test bench with suffix `_tb`
- `Simulate` -> `Run` -> `Run -All`
- If instruction fetch fails, try use the absolute file path in `InstrROM.sv`

## What Worked
### Program 1
- Score: 15 out of 15
### Program 2
- `prog2_tb.sv` as the test bench
  - Score when `flip[i] = $random;` and `flip2[i] = $random;`: 15 out of 15
  - Score when `flip[i] = 'b1000;` and `flip2[i] = 'b0;`: 15 out of 15
- `prog2_tb_one_error.sv` as the test bench
  - Score when `flip[i] = $random;`: 15 out of 15
  - Score when `flip[i] = 'b1000;`: 15 out of 15
### Program 3
- Score when `pat = 5'b0000;` and `mat_str[i] = 8'b00000000;`
  - Number of patterns w/o byte crossing: 128 128 (expected value & actual value)
  - Number of bytes w/ at least one pattern: 32 32
  - Number of patterns w/ byte crossing: 252 252
- Score when `pat = 5'b10101;` and `mat_str[i] = 8'b01010101;`
  - Number of patterns w/o byte crossing: 64 64
  - Number of bytes w/ at least one pattern: 32 32
  - Number of patterns w/ byte crossing: 126 126
- Score when `pat = $random;` and `mat_str[i] = $random;`
  - Number of patterns w/o byte crossing: 3 3
  - Number of bytes w/ at least one pattern: 3 3
  - Number of patterns w/ byte crossing: 6 6
