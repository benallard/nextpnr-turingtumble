// A generic board definition.
// That's about everything that is not defined by the cells on the front of the board.

// For the current_color
`define BLUE  0
`define RED   1

module BOARD
    // With how many balls to start
    #(parameter AMOUNT_BLUE = 8,
      parameter AMOUNT_RED  = 8)
     (
    // bottom of the board
    input blue_trigger,
    input red_trigger,
    // top of the board
    output blue_ball,
    output red_ball,
    // All balls gone
    output reg no_balls = 0,
    // color of the ball currently on the board
    output reg current_color,
    output reg [31:0] tray,
    output wire [4:0] tray_amount
);

    reg [4:0] blues = AMOUNT_BLUE;
    reg [4:0] reds = AMOUNT_RED;

    reg start = 1;
    reg [4:0] tray_idx = 0;

    wire trigger = blue_trigger | red_trigger;

    always @(posedge blue_trigger) begin
        if (blues > 0)
            blues <= blues - 1;
    end

    always @(posedge red_trigger) begin
        if (reds > 0)
            reds <= reds - 1;
    end

    always @(posedge trigger)
        no_balls <= (blue_trigger & blues == 0) | (red_trigger & reds == 0);

    always @(posedge trigger) begin
        if (red_trigger & reds > 0)
            current_color <= `RED;
        if (blue_trigger & blues > 0)
            current_color <= `BLUE;
    end

    always @(posedge trigger) begin
        if (start)
            start <= 0;
        else
            begin
                tray[tray_idx] <= current_color;
                tray_idx <= tray_idx + 1;
            end
    end

    assign #1 tray_amount = tray_idx;

    assign #1 blue_ball = ~start & (blues > 0) & blue_trigger;
    assign #1 red_ball = ~start & (reds > 0) & red_trigger;
    
endmodule