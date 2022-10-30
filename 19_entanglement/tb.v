`timescale 1ps/1ps
`include "19_entanglement/solution.v"

module tb;

    reg start;
    wire [3:0] stopped;
    wire [3:0] colour;

    puzzle #(0, 0) uut0 (start, stopped[0], colour[0]);
    puzzle #(0, 1) uut1 (start, stopped[1], colour[1]);
    puzzle #(1, 0) uut2 (start, stopped[2], colour[2]);
    puzzle #(1, 1) uut3 (start, stopped[3], colour[3]);


    initial begin
        $dumpvars(0, tb);
        $monitor("[%03d] start=%0b, stopped=%0b, colour=%0b", $time, start, stopped, colour);
        start = 0;
        #50 start = 1;
        #1 start = 0;

        #2000 $finish;
    end

endmodule