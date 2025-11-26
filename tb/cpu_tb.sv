module cpu_tb;
    logic clk, reset;
    logic [31:0] WriteData, DataAdr;

    cpu_top dut (
        .clk(clk),
        .reset(reset),
        .WriteData(WriteData),
        .DataAdr(DataAdr)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        clk = 0; reset = 1;
        #10;
        reset = 0;

        // Run for some cycles
        #200;
        
        $finish;
    end
endmodule
