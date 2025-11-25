module PC (
    input logic clk, reset,
    input logic [31:0] NextPC,

    output logic [31:0] PCOutput
);

    // El PC es un registro que almacena su valor
    logic [31:0] current_PC;

    // Conexión de la salida: la dirección actual es el valor almacenado
    assign PCOutput = current_PC;

    // Lógica síncrona: El PC se actualiza en el flanco positivo del reloj
    always @(posedge clk or posedge reset) begin
        // La lógica de reseteo siempre tiene prioridad
        if (reset)
            current_PC <= 32'h00000000; // Inicializa el PC a la dirección 0
        else
            current_PC <= NextPC;   // Actualiza con la dirección de la siguiente instrucción
    end
    
endmodule