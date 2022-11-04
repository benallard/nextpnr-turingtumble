module RAMP_LEFT(
    input i_left,
    input i_right,
    output o_left);
    assign #1 o_left = i_right | i_left;
endmodule

module RAMP_RIGHT(
    input i_left,
    input i_right,
    output o_right);
    assign #1 o_right = i_right | i_left;
endmodule

module CROSS_OVER(
    input i_left,
    input i_right,
    output o_left,
    output o_right);
    assign #1 o_left = i_right;
    assign #1 o_right = i_left;
endmodule

module INTERCEPTOR(
    input i_left,
    input i_right,
    output reg occupied = 0);
    wire i_both;
    assign i_both = i_right | i_left;
    always @(posedge i_both)
    begin
        occupied <= 1;
    end
endmodule

module BIT
#(parameter INIT = 0)
(
    input i_left,
    input i_right,
    output o_left,
    output o_right);
    reg V = INIT;
    // Theoritically, we could move the condition to negedge (leaving of the ball), and invert the V and ~V.
    // Here, we are taking the previous state to decide which side to go, which is not strictly correct.
    // Maybe one could design an FSM (IDLE, TURNING), to separate the decision and the state change.
    // Being clockless does not really helps there with designing FSMs.
    wire i_both;
    assign i_both = i_right | i_left;
    always @(posedge i_both)
    begin
        V <= ~V;
    end
    assign #1 o_left = ~V & (i_both);
    assign #1 o_right = V & (i_both);
endmodule

// in on all four sides
// out common.
module GEAR (
    input i_top, i_right, i_bottom, i_left,
    output o_moving
);
    assign #1 o_moving = i_top | i_right | i_bottom | i_left;
endmodule

// Basically a GEAR and a BIT
module GEARED_BIT
#(parameter INIT = 0)(
    input i_ball_left,
    input i_ball_right,
    output o_ball_left,
    output o_ball_right,
    input i_gear_top,
    input i_gear_right,
    input i_gear_bottom,
    input i_gear_left,
    output o_moving);

    BIT #(.INIT(INIT)) _bit (
        .i_left(i_ball_left),
        .i_right(i_ball_right),
        .o_left(o_ball_left),
        .o_right(o_ball_right));

    wire gear_moving;
    GEAR gear(
        .i_top(i_gear_top),
        .i_right(i_gear_right),
        .i_bottom(i_gear_bottom),
        .i_left(i_gear_left),
        .o_moving(gear_moving)
    );

    assign #1 o_moving = i_ball_left | i_ball_right | gear_moving;
endmodule
