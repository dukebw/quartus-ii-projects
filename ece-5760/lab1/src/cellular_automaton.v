// KEY0 will reset the state machine. The state machine will run at VGA clock rate.
//
// The VGA resolution must be at least 640x480.
//
// The initial state of the CA should be shown at the top of the VGA screen, each succeeding state should be
// shown on the next video line below.
//
// When the screen fills, the CA should stop until KEY3 is pressed, then exactly one more screen should be
// filled as if time is proceeding. 
//
// In other words, the bottom line of the screen N should be copied to the top line of screen N+1, and used as
// the initial condition to refill the screen.
//
// There should be no flickering, tearing, or other video artifacts caused by your state machine.
// The initial state will be exactly one cell at the center, top of the screen, or a random binary vector
// across the top of the screen.
//
// The initial state (seed or random) will be entered using SW17 and cannot be changed except at reset.
//
// The CA rule will be entered in binary on SW[7:0] and cannot be changed except at reset.
//
// As mentioned below, compare CA rules to natural phenomena.
module cellular_automaton(output wire [7:0] red_o,
                          output wire [7:0] green_o,
                          output wire [7:0] blue_o,
                          input wire [9:0] x_pixel_coord_i,
                          input wire [9:0] y_pixel_coord_i,
                          input wire clock_i,
                          input wire reset_i);


endmodule
