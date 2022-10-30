`include "board.v"
`include "cells.v"

module puzzle
#(parameter A_INIT = 0,
  parameter B_INIT = 0)
(
    input start,
    output stopped,
    output colour
);

    // The top
    wire blue_balls, red_balls;
    // the bottom
    wire red_sink;

    wire no_balls;

    // our board definition
    BOARD board(
        .blue_trigger(start), // We have no blue sink in this design
        .red_trigger(red_sink),
        .blue_ball(blue_balls),
        .red_ball(red_balls),
        .no_balls(no_balls),
        .current_color(colour),
        .tray(),
        .tray_amount());

    wire w1;
    RAMP_RIGHT rr1 (
        .i_left(blue_balls),
        .i_right(1'b0),
        .o_right(w1)
    );
    wire w2;
    RAMP_RIGHT rr2 (
        .i_left(w1),
        .i_right(1'b0),
        .o_right(w2)
    );

    wire w3;
    RAMP_LEFT rl1(1'b0, red_balls, w3);
    wire w4;
    RAMP_LEFT rl2(1'b0, w3, w4);

    wire w5, w6;
    BIT #(.INIT(A_INIT)) A (w2, w4, w5, w6);

    wire w7;
    RAMP_RIGHT rr3 (1'b0, w5, w7);
    wire w8;
    RAMP_RIGHT rr4 (w6, 1'b0, w8);

    wire w9, w10;
    BIT #(.INIT(B_INIT)) B (w7, 1'b0, w9, w10);
    wire w11;
    RAMP_RIGHT rr5 (w8, 1'b0, w11);

    wire w12;
    RAMP_LEFT rl3 (w9, 1'b0, w12);
    wire w13;
    RAMP_RIGHT rr6 (w10, 1'b0, w13);
    wire w14;
    RAMP_LEFT rl4 (w11, 1'b0, w14);

    wire w15;
    RAMP_RIGHT rr7 (1'b0, w12, w15);
    wire w16;
    RAMP_RIGHT rr8 (w13, w14, w16);

    wire w17;
    RAMP_LEFT rl5 (w15, 1'b0, w17);
    wire w18;
    RAMP_LEFT rl6 (w16, 1'b0, w18);

    wire w19;
    RAMP_RIGHT rr9 (1'b0, w17, w19);
    wire w20;
    RAMP_RIGHT rr10 (1'b0, w18, w20);

    wire w21;
    RAMP_RIGHT rr11 (w19, 1'b0, w21);
    wire w22;
    RAMP_LEFT rl7 (w20, 1'b0, red_sink);

    wire int_full;
    INTERCEPTOR stop (w21, 1'b0, int_full);

    assign stopped = no_balls | int_full;

endmodule