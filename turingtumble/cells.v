module RAMP_LEFT(
    input i_right,
    input i_left,
    output o_left);
    assign o_left = i_right | i_left;
endmodule

module RAMP_RIGHT(
    input i_right,
    input i_left,
    output o_right);
    assign o_right = i_right | i_left;
endmodule

module CROSS_OVER(
    input i_right,
    input i_left,
    output o_right,
    output o_left);
    assign o_left = i_right;
    assign o_right = i_left;
endmodule

module INTERCEPTOR(
    input i_right,
    input i_left,
    output reg occupied = 0);
    always @(posedge i_right or posedge i_left) begin
        occupied <= 1;
    end
endmodule

module BIT
#(parameter INIT = 0)
(
    input i_right,
    input i_left,
    output o_right,
    output o_left);
    reg V = INIT;
    always @(posedge i_right, posedge i_left)
        V <= ~V;
    assign o_right = ~V & (i_right | i_left);
    assign o_left = V & (i_right | i_left);
endmodule

// inout on the four sides
module GEAR();
endmodule

// Basically a GEAR and a BIT
module GEARED_BIT();
endmodule
