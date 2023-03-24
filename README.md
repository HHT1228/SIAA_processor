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
