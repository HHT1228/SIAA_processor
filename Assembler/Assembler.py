# R-type OpCode definition
opADD   = '0000'
opSUB   = '0001'
opAND   = '0010'
opOR    = '0011'
opXOR   = '0100'
opRXOR  = '0101'
opSLR   = '0110'
opSRR   = '0111'
opLW    = '1000'
opSW    = '1001'
opEQ    = '1010'
opSLT   = '1011'
opBR    = '1100'
opJ     = '1101'
opSET   = '1110'
opLA    = '1111'

# I-type OpCode definition
opADDI  = '000'
opSUBI  = '001'
opANDI  = '010'
opSLL   = '011'
opSRL   = '100'
opSETI  = '101'
opHALT  = '110'
opLUTA  = '111'

# Register dictionary
regDict = {
    'R0': '0000',
    'R1': '0001',
    'R2': '0010',
    'R3': '0011',
    'R4': '0100',
    'R5': '0101',
    'R6': '0110',
    'R7': '0111',
    'R8': '1000',
    'R9': '1001',
    'R10': '1010',
    'R11': '1011',
    'R12': '1100',
    'R13': '1101',
    'R14': '1110',
    'R15': '1111',
}

# TODO?: Clean-up immediates (i.e. convert 0b0001_1110 into 00001110)

# Type code definition
rType = 1
iType= 0

# Read the entire assembly code file as input
with open('assembly.txt', 'r') as inFile:
    assemblyCode = inFile.read()

# Write the decoded result into the output machine code file
with open('mach_code.txt', 'w') as outFile:
    assemblyCode = assemblyCode.split('\n')     # SPlit the assembly code into separate lines
    lineCount = len(assemblyCode)
    
    for i in range(lineCount):
        # print(assemblyCode[i])    # DELETE: for debug
        
        # Fetch the instruction line by line and split the components
        instr = assemblyCode[i].split()
         
        # Skip comments and empty lines
        if (len(instr) == 0) or (len(instr) < 2):
            continue
        elif(instr == '\n') or (instr[0] == '#'):
            continue
        
        # print(instr)    # DELTE: for debug
        op = instr[0]
        # print(op)
        regOrImm = instr[1]
        
        # Code translation and write
        # IMPORTANT: Each machine code has follows the structure:
            # type (rType or iType) + op (e.g. opADD, opXOR, op SLL) + regDict[regOrImm] + '\n"
        
        # Translate ADD instruction
        if(op == 'add') or (op == 'ADD'):
            machineCode = rType + opADD + regDict[regOrImm] +  '\n'
            outFile.write(machineCode)
            
        # Translate SUB instruction
        elif(op == 'sub') or (op == 'SUB'):
            machineCode = rType + opSUB + regDict[regOrImm] +  '\n'
            outFile.write(machineCode)
            
        # TODO: Implement translations for the other instructions


# Close files
inFile.close()
outFile.close()
