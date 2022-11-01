`timescale 1ps/1ps
`include "26_nucleus/puzzle.v"

module tb;

    reg start;
    wire stopped;
    wire[19:0] tray;
    wire[4:0] tray_size;

    puzzle uut (start, stopped, tray, tray_size);

    initial begin
        $dumpvars(0, tb);
        $monitor("[%03d] start=%0b, tray=%0b, amount=%0d", $time, start, tray, tray_size);
        start = 0;
        #50 start = 1;
        #1 start = 0;

        @(stopped) $finish;
    end
endmodule
