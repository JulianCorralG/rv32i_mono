module ImmGen (
    input logic [31:7] Instr, // Parte relevante de la instrucción (bits 31 a 7)
    input logic [2:0] ImmSrc,

    output logic [31:0] ImmExt
);

    always_comb begin
        case (ImmSrc)
            // I-Type (ADDI, LW, JALR, etc.)
            // Imm[11:0] = Instr[31:20]
            3'b000: ImmExt = {{20{Instr[31]}}, Instr[31:20]};

            // S-Type (SW)
            // Imm[11:5] = Instr[31:25], Imm[4:0] = Instr[11:7]
            3'b001: ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};

            // B-Type (BEQ, BNE, etc.)
            // Imm[12] = Instr[31], Imm[10:5] = Instr[30:25], Imm[4:1] = Instr[11:8], Imm[11] = Instr[7]
            3'b010: ImmExt = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
            
            // J-Type (JAL)
            // Imm[20] = Instr[31], Imm[10:1] = Instr[30:21], Imm[11] = Instr[20], Imm[19:12] = Instr[19:12]
            3'b011: ImmExt = {{12{Instr[31]}}, Instr[31], Instr[19:12], Instr[20], Instr[30:21], 1'b0};

            // U-Type (LUI, AUIPC)
            // Imm[31:12] = Instr[31:12]
            3'b100: ImmExt = {Instr[31:12], 12'b0};

            default: ImmExt = 32'b0;
        endcase
    end
    
endmodule