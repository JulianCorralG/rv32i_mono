module Adder (
    input logic [31:0] PCOutput,

    output logic [31:0] AdderOutput
);

    assign AdderOutput = PCOutput + 32'd4;
    
endmodule