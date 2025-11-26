module BranchUnit (
    input logic signed [31:0] RURs1, RURs2,
    input logic [4:0] BrOp,

    output logic NextPCSrc // Debería ser un flag (BranchTaken)
);

    logic BranchTaken;
    
    // Asumimos que BrOp[2:0] es Funct3
    always @* begin
        BranchTaken = 1'b0;
        
        case (BrOp[2:0]) // Funct3
            3'b000: BranchTaken = (RURs1 == RURs2); // BEQ
            3'b001: BranchTaken = (RURs1 != RURs2); // BNE
            3'b100: BranchTaken = (RURs1 < RURs2); // BLT
            3'b101: BranchTaken = (RURs1 >= RURs2); // BGE
            3'b110: BranchTaken = ($unsigned(RURs1) < $unsigned(RURs2)); // BLTU (Unsigned)
            3'b111: BranchTaken = ($unsigned(RURs1) >= $unsigned(RURs2)); // BGEU (Unsigned)
            default: BranchTaken = 1'b0;
        endcase
    end
    
    // La salida NextPCSrc determina si se toma el salto (Branch o Jump)
    // BrOp[4] indica salto incondicional (JAL, JALR)
    // BrOp[3] indica instrucción de Branch
    assign NextPCSrc = BrOp[4] | (BrOp[3] & BranchTaken);
    
endmodule