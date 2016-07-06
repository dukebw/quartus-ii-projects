`include "vga_controller.vh"

`define HAS_RESET 2'b0
`define DRAWING 2'b1
`define WHITE 16'hFFF0
`define BLACK 16'b0

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
module cellular_automaton(output reg [10:0] mem_write_address_o,
                          output reg mem_write_enable_o,
                          output reg [15:0] mem_write_data_o,
                          output wire [10:0] mem_read_address_o,
                          output wire [7:0] red_o,
                          output wire [7:0] green_o,
                          output wire [7:0] blue_o,
                          input wire [15:0] mem_read_data_i,
                          input wire [9:0] x_pixel_coord_i,
                          input wire [9:0] y_pixel_coord_i,
                          input wire clock_i,
                          input wire reset_i);

    reg is_pixel_black;
    reg [1:0] current_state;
    reg [9:0] reset_x_coord;
    // 3 bits representing whether the 3 squares above the currently calculating one were black
    reg [2:0] previous_row_state;
    reg [9:0] prev_x_pixel_coord;

    // Reset: how to force waiting until row 0 to start the state machine?
    // current_state bit
    // Reset --Reset de-asserted--> Has-Reset --Row0 reached--> Drawing CA_0 --Key3 pressed--> Drawing CA_1 ...
    //
    // To generate the rule for each pixel, the previous 3 pixels have to have been fetched from memory on the
    // previous clock cycle. Use dual-ported M9K block to store the entire previous line.
    //
    // How to fetch three pixels on reset?
    // On reset, store three pixels from first line in register

    // TODO(bwd): verify whether the pixels read back are timed on the correct clock cycle
    assign red_o = {mem_read_data_i[15:12], 4'b0};
    assign green_o = {mem_read_data_i[11:8], 4'b0};
    assign blue_o = {mem_read_data_i[7:4], 4'b0};

    assign mem_read_address_o = ((y_pixel_coord_i == 10'b0) ? {1'b0, x_pixel_coord_i} :
                                                              {1'b0, x_pixel_coord_i} + `HORIZONTAL_WIDTH_PIXELS);

    always @* begin
        // Memory:
        // [0:HORIZONTAL_WIDTH_PIXELS*16 bits) - Initial row
        // [HORIZONTAL_WIDTH_PIXELS*16 bits:2*HORIZONTAL_WIDTH_PIXELS*16 bits) - Currently drawing and displaying row
        // [2*HORIZONTAL_WIDTH_PIXELS*16 bits:3*HORIZONTAL_WIDTH_PIXELS*16 bits) - Final row (used to
        // initialize next screen on key press)
        if (reset_i == 1'b1) begin
            mem_write_enable_o = 1'b1;
            mem_write_address_o = {1'b0, reset_x_coord};

            // Assume that reset is depressed for > 640 clock cycles, so that we can store the whole first row
            // in on-chip RAM. 640 clock cycles / 25.175Mcycles/second == 25.4*10^-6 == 25.4us
            if (reset_x_coord == (`HORIZONTAL_WIDTH_PIXELS/2)) begin
                mem_write_data_o = `BLACK;
            end
            else begin
                mem_write_data_o = `WHITE;
            end
        end
        else begin
            mem_write_enable_o = 1'b1;
            // Three cycles of delay: one to account for needing the first pixel, one to latch the correct
            // write data, and one for the write to go through??
            if (x_pixel_coord_i >= 10'h3) begin
                mem_write_address_o = {1'b0, x_pixel_coord_i - 10'h3} + `HORIZONTAL_WIDTH_PIXELS;
            end
            else begin
                mem_write_address_o = {1'b0, (`HORIZONTAL_WIDTH_PIXELS - x_pixel_coord_i - 1'b1)} + `HORIZONTAL_WIDTH_PIXELS;
            end

            // Continually write to the previous x-coord pixel on the next row the value assigned from
            // the current rule.
            // TODO(brendan): For now, hard-code rule 30
            case (previous_row_state)
                3'b000: begin
                    mem_write_data_o = `WHITE;
                end
                3'b001: begin
                    mem_write_data_o = `WHITE;
                end
                3'b010: begin
                    mem_write_data_o = `WHITE;
                end
                3'b011: begin
                    mem_write_data_o = `BLACK;
                end
                3'b100: begin
                    mem_write_data_o = `BLACK;
                end
                3'b101: begin
                    mem_write_data_o = `BLACK;
                end
                3'b110: begin
                    mem_write_data_o = `BLACK;
                end
                3'b111: begin
                    mem_write_data_o = `WHITE;
                end
                default: begin
                    mem_write_data_o = `WHITE;
                end
            endcase
        end
    end

    always @(posedge clock_i) begin
        prev_x_pixel_coord <= x_pixel_coord_i;
    end

    // Synchronous reset, TODO(brendan): why, versus async reset?
    always @(posedge clock_i) begin
        if (reset_i == 1'b1) begin
            current_state <= `HAS_RESET;
            previous_row_state <= 3'b111;

            if (reset_x_coord == (`HORIZONTAL_WIDTH_PIXELS - 1)) begin
                reset_x_coord <= 10'b0;
            end
            else begin
                reset_x_coord <= reset_x_coord + 10'b1;
            end
        end
        else begin
            reset_x_coord <= 10'b0;

            case (current_state)
                `HAS_RESET: begin
                    if ((y_pixel_coord_i == 10'b0) && (x_pixel_coord_i == 10'b0)) begin
                        current_state <= `DRAWING;
                    end
                end
                `DRAWING: begin
                    if (x_pixel_coord_i != prev_x_pixel_coord) begin
                        previous_row_state <= {previous_row_state[1:0], mem_read_data_i[15]};
                    end
                end
                default: begin
                    current_state <= `HAS_RESET;
                end
            endcase
        end
    end

endmodule
