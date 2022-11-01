`include "turingtumble/board.v"
`include "turingtumble/cells.v"

module puzzle(
    input start,
    output stopped,
    output [19:0] tray,
    output [4:0] tray_size
);


    // The top
    /* verilator lint_off UNOPTFLAT */wire blue_balls, red_balls;/* verilator lint_on UNOPTFLAT */
    // the bottom
    wire blue_sink, red_sink;

    wire no_balls;


    // our board definition
    BOARD  #(.AMOUNT_BLUE(10), .AMOUNT_RED(10))
        board (
        .blue_trigger(blue_sink | start), // We have no blue sink in this design
        .red_trigger(red_sink),
        .blue_ball(blue_balls),
        .red_ball(red_balls),
        .no_balls(no_balls),
        .current_color(),
        .tray(tray),
        .tray_amount(tray_size));

    // Fixed pieces:
    wire w1, w2;
    BIT #(.INIT(1)) b1 (1'b0, red_balls, w1, w2);
    wire ball_in_int;
    INTERCEPTOR block (w2, 1'b0, ball_in_int);

    assign #1 stopped = no_balls | ball_in_int;

    // Our pieces
    wire w3, w4;
    BIT #(.INIT(1)) b2 (blue_balls, 1'b0, w3, w4);

    wire w5;
    RAMP_LEFT rl1 (1'b0, w3, w5);
    wire w6;
    RAMP_LEFT rl2 (w4, 1'b0, w6);
    wire w7;
    RAMP_LEFT rl3 (1'b0, w1, w7);

    wire w8;
    RAMP_RIGHT rr1 (1'b0, w5, w8);
    wire w9, w10;
    BIT #(.INIT(1)) b3 (1'b0, w6, w9, w10);
    wire w11;
    RAMP_RIGHT rr2 (1'b0, w7, w11);

    wire w12;
    RAMP_RIGHT rr3 (w8, w9, w12);
    wire w13;
    RAMP_LEFT rl4 (w10, 1'b0, w13);
    wire w14;
    RAMP_LEFT rl5 (w11, 1'b0, w14);

    wire w15, w16;
    CROSS_OVER x1 (w12, w13, w15, w16);
    wire w17;
    RAMP_LEFT rl6 (1'b0, w14, w17);

    wire w18;
    RAMP_RIGHT rr4 (1'b0, w15, w18);
    wire w19;
    RAMP_LEFT rl7 (w16, w17, w19);

    wire w20, w21;
    CROSS_OVER x2 (w18, w19, w20, w21);

    wire w22;
    RAMP_RIGHT rr5 (1'b0, w20, w22);
    wire w23;
    RAMP_RIGHT rr6 (w21, 1'b0, w23);

    wire w24;
    RAMP_RIGHT rr7 (w22, 1'b0, w24);
    wire w25;
    RAMP_RIGHT rr8 (w23, 1'b0, w25);

    RAMP_LEFT rl8 (w24, 1'b0, blue_sink);
    RAMP_RIGHT rr9 (w25, 1'b0, red_sink);

endmodule
