`include "turingtumble/board.v"
`include "19_entanglement/pieces.v"

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

    wire int_full;

    pieces #(.A_INIT(A_INIT), .B_INIT(B_INIT)) 
    pieces(
        .blue_ball(blue_balls),
        .red_ball(red_balls),
        .red_sink(red_sink),
        .int_full(int_full)
    );

    assign #1 stopped = no_balls | int_full;

endmodule
