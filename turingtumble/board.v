// A generic board definition.
// That's about everything that is not defined by the cells on the front of the board.

// For the current_color
`define BLUE  0
`define RED   1

module BOARD
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
    output reg no_balls,
    // color of the ball currently on the board
    output reg current_color,
    output reg [5:0] tray
);

    reg [4:0] blues = AMOUNT_BLUE;
    reg [4:0] reds = AMOUNT_RED;

    reg start = 1;
    reg [3:0] tray_idx = 0;

    always @(posedge blue_trigger) begin
        if (blues > 0)
            begin
                // TODO: save color of current ball on the result array
                current_color <= `BLUE;
                blues <= blues - 1;
            end
        else
            no_balls <= 1;
    end

    always @(posedge red_trigger) begin
        if (reds > 0)
            begin
                // TODO: save color of current ball on the result array
                current_color <= `RED;
                reds <= reds - 1;
            end
        else
            no_balls <= 1;
    end

    always @(posedge blue_trigger or posedge red_trigger) begin
        if (start)
            start <= 0;
        else
            begin
                tray[tray_idx] <= current_color;
                tray_idx <= tray_idx + 1;
            end
    end

    assign blue_ball = (blues > 0) & blue_trigger;
    assign red_ball = (reds > 0) & red_trigger;
    
endmodule