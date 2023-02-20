// Control Decoder
module CtrlDecoder (
  input [8:0]  inst,   // 9-bit instruction

  output logic regWrite,	// Write enable signal, write to R0
			         regSet,		// Signal for write to general registers
               memRead,   // Read from Data Memory
               memWrite,  // Write to Data Memory
               branch,    // Signal for branch address
  );    

  wire      op_type;
  wire[3:0] R_op;
  wire[2:0] I_op;

  assign op_type = inst[8];     
  assign R_op    = inst[3:0];
  assign I_op    = inst[2:0];
  
  always_comb begin
    if (op_type) begin // I-type
      case (I_op)
        0: begin // addi
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        1: begin // subi
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        2: begin // andi
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        3: begin // sll
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        4: begin // srl
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        5: begin // seti
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        6: begin // terminate
          regWrite = 0;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        default: begin
          regWrite = 0;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
      endcase
    end else begin
      case (R_op)
        0: begin // add
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        1: begin // sub
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end

        2: begin // and
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        3: begin // or
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        4: begin // xor
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        5: begin // rxor
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        6: begin // slr
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        7: begin // srr
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        8: begin // lw
          regWrite = 1;
			    regSet = 0;
          memRead = 1;
          memWrite = 0;
          branch = 0;
        end
        
        9: begin // sw
          regWrite = 0;
			    regSet = 0;
          memRead = 0;
          memWrite = 1;
          branch = 0;
        end
        
        10: begin // eq
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        11: begin // slt
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        12: begin // br
          regWrite = 0;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 1;
        end
        
        13: begin // j
          regWrite = 0;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 1;
        end
        
        14: begin // set
          regWrite = 0;
			    regSet = 1;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        15: begin // la
          regWrite = 1;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
        
        default: begin
          regWrite = 0;
			    regSet = 0;
          memRead = 0;
          memWrite = 0;
          branch = 0;
        end
      endcase
    end
  end
endmodule
