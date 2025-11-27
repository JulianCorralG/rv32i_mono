module fpga_top (
    input logic clk,      // Reloj de la placa (ej. 50MHz o 100MHz)
    input logic rst_n,    // Reset activo bajo (botón)
    output logic [15:0] LEDS, // 16 LEDs para visualización
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 // 6 displays de 7 segmentos
);

    logic reset;
    logic [31:0] WriteData;
    logic [31:0] DataAdr;
    logic [31:0] x3_value;  // Valor del registro x3

    // Invertir reset (activo alto para el procesador)
    assign reset = ~rst_n;

    // Instancia del procesador
    cpu_top processor (
        .clk(clk),
        .reset(reset),
        .WriteData(WriteData),
        .DataAdr(DataAdr),
        .x3_out(x3_value)  // Conectar salida x3
    );

    // Mapeo de salida a LEDs
    // Mostramos los 16 bits menos significativos del dato escrito
    assign LEDS = WriteData[15:0];
    
    // Instancia del DisplayController para mostrar x3 en los 6 displays de 7 segmentos
    DisplayController display_ctrl (
        .data_to_display(x3_value),  // Mostramos el valor de x3 (32 bits, usamos 24 bits, los 8 MSB se ignoran)
        .hex0(HEX0),
        .hex1(HEX1),
        .hex2(HEX2),
        .hex3(HEX3),
        .hex4(HEX4),
        .hex5(HEX5)
    );

endmodule
