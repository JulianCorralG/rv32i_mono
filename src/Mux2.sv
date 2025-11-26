module Mux2 #(parameter WIDTH = 32) (
    input  logic              sel,
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    output logic [WIDTH-1:0] y
);
    always_comb begin
        y = sel ? b : a;
    end
endmodule