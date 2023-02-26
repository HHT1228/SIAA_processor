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
    'r0': '0000',
    'r1': '0001',
    'r2': '0010',
    'r3': '0011',
    'r4': '0100',
    'r5': '0101',
    'r6': '0110',
    'r7': '0111',
    'r8': '1000',
    'r9': '1001',
    'r10': '1010',
    'r11': '1011',
    'r12': '1100',
    'r13': '1101',
    'r14': '1110',
    'r15': '1111',
}

# Clean-up immediates (i.e. convert 0b0001_1110 into 00011110)
# Return: 8 bits!
def cope_with_immediates(imm_str):
    if len(imm_str) > 2 and imm_str[:2] == '0b': # binary
        return imm_str[2:6] + imm_str[7:11]
    else: # decimal
        num = int(imm_str)
        num_binary_str = bin(num)[2:] # ex. bin(3) = '0b11'
        num_binary_str = '0' * (8 - len(num_binary_str)) + num_binary_str
        return num_binary_str

# Type code definition
rType = '0'
iType = '1'

# Read the entire assembly code file as input
with open('assembly.txt', 'r') as inFile:
    assemblyCode = inFile.read()

# Write the decoded result into the output machine code file
with open('mach_code.txt', 'w') as outFile:
    assemblyCode = assemblyCode.split('\n')     # SPlit the assembly code into separate lines
    lineCount = len(assemblyCode)
    # branch_name = None
    
    for i in range(lineCount):
        # print(assemblyCode[i])    # DELETE: for debug
        
        # Fetch the instruction line by line and split the components
        instr = assemblyCode[i].split()
         
        # Skip comments and empty lines
        if len(instr) == 0:
            continue
        elif instr == '\n' or instr[0] == '#':
            continue
            
        # Handle HALT and branch definition
        if instr[0].lower() == 'halt':
            machineCode = iType + '00000' + opHALT + '\n'
            outFile.write(machineCode)
            continue
        if instr[0][-1] == ':':
            # branch_name = instr[0][:-1]
            continue
        # if branch_name != None:
            # print(i, branch_name, instr)
            # branch_name = None
        
        # print(instr)    # DELETE: for debug
        op = instr[0].lower()
        # print(op)
        regOrImm = instr[1].lower()
        
        # Code translation and write
        # IMPORTANT: Each machine code follows the structure:
            # type (rType or iType) + regDict[regOrImm] + op (e.g. opADD, opXOR, op SLL) + '\n"
        
        # Translate ADD instruction
        if op == 'add':
            machineCode = rType + regDict[regOrImm] + opADD +  '\n'
            outFile.write(machineCode)
            
        # Translate SUB instruction
        elif op == 'sub':
            machineCode = rType + regDict[regOrImm] + opSUB +  '\n'
            outFile.write(machineCode)
        
        # Translate ADDI instruction
        elif op == 'addi':
            imm = cope_with_immediates(regOrImm)[3:] # cope_with_immediates() returns 8 bits
            machineCode = iType + imm + opADDI + '\n'
            outFile.write(machineCode)
            
        # Translate SUBI instruction
        elif op == 'subi':
            imm = cope_with_immediates(regOrImm)[3:] # cope_with_immediates() returns 8 bits
            machineCode = iType + imm + opSUBI + '\n'
            outFile.write(machineCode)
        
        # Translate AND instruction
        elif op == 'and':
            machineCode = rType + regDict[regOrImm] + opAND + '\n'
            outFile.write(machineCode)
        
        # Translate OR instruction
        elif op == 'or':
            machineCode = rType + regDict[regOrImm] + opOR + '\n'
            outFile.write(machineCode)

        # Translate XOR instruction
        elif op == 'xor':
            machineCode = rType + regDict[regOrImm] + opXOR + '\n'
            outFile.write(machineCode)
            
        # Translate RXOR instruction
        elif op == 'rxor':
            machineCode = rType + regDict[regOrImm] + opRXOR + '\n'
            outFile.write(machineCode)
        
        # Translate ANDI instruction
        elif op == 'andi':
            imm = cope_with_immediates(regOrImm)[3:] # cope_with_immediates() returns 8 bits
            machineCode = iType + imm + opANDI + '\n'
            outFile.write(machineCode)
        
        # Translate SLR instruction
        elif op == 'slr':
            machineCode = rType + regDict(regOrImm) + opSLR + '\n'
            outFile.write(machineCode)
        
        # Translate SRR instruction
        elif op == 'srr':
            machineCode = rType + regDict(regOrImm) + opSRR + '\n'
            outFile.write(machineCode)

        # Translate SLT instruction
        elif op == 'slt':
            machineCode = rType + regDict(regOrImm) + opSLT + '\n'
            outFile.write(machineCode)
        
        # Translate LW instruction
        elif op == 'lw':
            machineCode = rType + regDict(regOrImm) + opLW + '\n'
            outFile.write(machineCode)
        
        # Translate SW instruction
        elif op == 'sw':
            machineCode = rType + regDict(regOrImm) + opSW + '\n'
            outFile.write(machineCode)

        # Translate EQ instruction
        elif op == 'eq':
            machineCode = rType + regDict(regOrImm) + opEQ + '\n'
            outFile.write(machineCode)
        
        # Translate BR instruction
        elif op == 'br':
            machineCode = rType + regDict(regOrImm) + opBR + '\n'
            outFile.write(machineCode)
        
        # Translate J instruction
        elif op == 'j':
            machineCode = rType + regDict(regOrImm) + opJ + '\n'
            outFile.write(machineCode)

        # Translate SET instruction
        elif op == 'set':
            machineCode = rType + regDict(regOrImm) + opSET + '\n'
            outFile.write(machineCode)
        
        # Translate SETI instruction
        elif op == 'seti':
            imm = cope_with_immediates(regOrImm)[3:] # cope_with_immediates() returns 8 bits
            machineCode = iType + imm + opSETI + '\n'
            outFile.write(machineCode)
        
        # Translate SLL instruction
        elif op == 'sll':
            imm = cope_with_immediates(regOrImm)[3:] # cope_with_immediates() returns 8 bits
            machineCode = iType + imm + opSLL + '\n'
            outFile.write(machineCode)

        # Translate SRL instruction
        elif op == 'srl':
            imm = cope_with_immediates(regOrImm)[3:] # cope_with_immediates() returns 8 bits
            machineCode = iType + imm + opSRL + '\n'
            outFile.write(machineCode)
        
        # Translate LA instruction
        elif op == 'la':
            machineCode = rType + regDict(regOrImm) + opLA + '\n'
            outFile.write(machineCode)
        
        # Translate LUTA instruction
        elif op == 'luta':
            imm = cope_with_immediates(regOrImm)[3:] # cope_with_immediates() returns 8 bits
            machineCode = iType + imm + opLUTA + '\n'
            outFile.write(machineCode)


# Close files
inFile.close()
outFile.close()
