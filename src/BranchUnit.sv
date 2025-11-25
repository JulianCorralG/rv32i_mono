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
    
    // La salida NextPCSrc en el diagrama parece ser el selector final del PC MUX.
    // Si la instrucción es Branch y la condición se cumple, se activa la lógica para el MUX.
    // Aquí solo se determina si la condición se cumple.
    assign NextPCSrc = BranchTaken; // Ajusta este nombre de señal al MUX final
    
endmodule