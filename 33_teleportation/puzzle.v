`include "turingtumble/board.v"
`include "turingtumble/cells.v"

`define F 1'b0 // false

module puzzle
    #(parameter A_INIT = 0,
      parameter B_INIT = 0)
(
    input start,
    output stopped,
    output b_value);


    // The top
    wire blue_balls, red_balls;
    // the bottom
    wire blue_sink, red_sink;

    wire no_balls;

    // our board definition
    BOARD board (
        .blue_trigger(blue_sink | start), // We have no blue sink in this design
        .red_trigger(red_sink),
        .blue_ball(blue_balls),
        .red_ball(red_balls),
        .no_balls(no_balls),
        .current_color(),
        .tray(),
        .tray_amount());

    // fixed pieces
    wire w13, w1, w2;
    wire c1; // c for contact
    GEARED_BIT #(.INIT(B_INIT)) gb1(w13, `F, w1, w2, `F, );
    GEAR g1 ();
    wire w14, w3, w4;
    GEARED_BIT #(.INIT(B_INIT)) gb2(`F, w14, w3, w4,);

    assign b_value = gb1._bit.V;

    wire w15, w5, w6;
    GEARED_BIT #(.INIT(A_INIT)) gb3(`F, w15, w5, w6,);
    wire w7, w8;
    GEARED_BIT #(.INIT(B_INIT)) gb4(w2, w3, w7, w8,);

    wire w10;
    GEARED_BIT #(.INIT(A_INIT)) gb5(`F, w5, ,w10,);
    GEAR g2();
    wire w11;
    GEARED_BIT #(.INIT(A_INIT)) gb6 (w6, `F, w11,,);

endmodule