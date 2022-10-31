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
    always @(posedge i_right or posedge i_left) begin
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
    always @(posedge i_right or posedge i_left) begin
        V <= ~V;
    end
    assign #1 o_left = ~V & (i_right | i_left);
    assign #1 o_right = V & (i_right | i_left);
endmodule

// inout on the four sides
module GEAR();
endmodule

// Basically a GEAR and a BIT
module GEARED_BIT();
endmodule
