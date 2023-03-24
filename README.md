# SIAA_processor

- `alu.sv`: ALU module file
- `alu_tb.sv`: ALU testbench file
- `CtrlDecoder.sv`: Control Decoder module file
- `dataMem.sv`: Data Memory module file
- `InstrROM.sv`: Instruction Memory module file
- `LUT.sv`: Lookup Table module file
- `mach_code.txt`: Dummy machine code instructions for compilation
- `MUX.sv`: MUX module file
- `PC.sv`: Program Counter module file
- `PC_tb.sv`: Program Counter testbench file
- `regFile.sv`: Register File module file
- `TopLevel.sv`: Top Level module file
- `Assembler.py`: Assembler program that translates assembly instructions into binary machine codes
- `Program1`, `Program2`, and `Program3`: Assembly and machine codes for the three programs

## How to Run the Code
- Download the code
- Download and open ModelSim
- `File` ->  `New` -> `Project`
- `Project Location` -> `Browse` -> Choose one of the three program folders (ex. `Program1`)
- `Add Existing File` -> Select all the `.sv` files in the program folder
- `Compile` -> `Compile All` (You can change the compile order if you want)
- `Simulate` -> `Start Simulation`
- `work` -> choose the test bench (ex. `prog1_tb`)
- `Simulate` -> `Run` -> `Run -All`

## What Worked
### Program 1
- Score: 15 out of 15
### Program 2
- `prog2_tb.sv` as the test bench
  - Score when `flip[i] = $random;` and `flip2[i] = $random;`: 15 out of 15
  - Score when `flip[i] = 'b1000;` and `flip2[i] = 'b0;`: 15 out of 15
- `prog2_tb_one_error.sv` as the test bench (generating 15 one-bit error cases)
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
