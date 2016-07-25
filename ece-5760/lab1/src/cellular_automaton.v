`include "vga_controller.vh"

`define HAS_RESET 2'b0
`define DRAWING 2'b1
`define WHITE 16'h80F0
`define BLACK 16'b0
`define SELECT_COLOUR(rule_bit) ((rule_bit == 1'b0) ? `WHITE : `BLACK)

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
                          output reg [10:0] mem_read_address_o,
                          output wire [7:0] red_o,
                          output wire [7:0] green_o,
                          output wire [7:0] blue_o,
                          input wire is_inside_visible_region_i,
                          input wire [15:0] mem_read_data_i,
                          input wire [9:0] x_pixel_coord_i,
                          input wire [9:0] y_pixel_coord_i,
                          input wire clock_i,
                          input wire reset_i,
                          input wire next_screen_i,
                          input wire seed_or_random_i,
                          input wire [7:0] rule_i);

    reg is_pixel_black;
    reg [1:0] current_state;
    reg [9:0] reset_x_coord;
    reg [9:0] reset_x_coord_n1;
    // 3 bits representing whether the 3 squares above the currently calculating one were black
    reg [2:0] previous_row_state;
    reg [9:0] x_pixel_coord_n1;
    reg [9:0] x_pixel_coord_n2;
    reg [9:0] x_pixel_coord_n3;
    reg is_inside_visible_n1;
    reg is_inside_visible_n2;
    reg is_inside_visible_n3;
    reg prev_row_pixel0_save;
    wire next_random_bit;

    // Reset: how to force waiting until row 0 to start the state machine?
    // current_state bit
    // Reset --Reset de-asserted--> Has-Reset --Row0 reached--> Drawing CA_0 --Key3 pressed--> Drawing CA_1 ...
    //
    // To generate the rule for each pixel, the previous 3 pixels have to have been fetched from memory on the
    // previous clock cycle. Use dual-ported M9K block to store the entire previous line.
    //
    // How to fetch three pixels on reset?
    // On reset, store three pixels from first line in register

    assign red_o = {mem_read_data_i[15:12], 4'b0};
    assign green_o = {mem_read_data_i[11:8], 4'b0};
    assign blue_o = {mem_read_data_i[7:4], 4'b0};

    // After writing the first line, must use first clock cycle outside visible region to write pixel 639
    // using pixels 0, 638 of the previous row (now overwritten), as well as pixel 639 of the previous row.
    // Store pixel 0 and shift it into an extra previous_row_state variable.
    always @* begin
        if (next_screen_i == 1'b1) begin
            mem_read_address_o = {1'b0, reset_x_coord} + (10'h2*`HORIZONTAL_WIDTH_PIXELS);
        end
        else begin
            if (y_pixel_coord_i == 10'b0) begin
                mem_read_address_o = {1'b0, x_pixel_coord_i};
            end
            else begin
                mem_read_address_o = {1'b0, x_pixel_coord_i} + `HORIZONTAL_WIDTH_PIXELS;
            end
        end
    end

    wire [15:0] debug_mem_write_addr = {8'b0, mem_write_address_o[3:0], 4'b0};

    always @* begin
        // Memory:
        // [0:HORIZONTAL_WIDTH_PIXELS*16 bits) - Initial row
        // [HORIZONTAL_WIDTH_PIXELS*16 bits:2*HORIZONTAL_WIDTH_PIXELS*16 bits) - Currently drawing and
        // displaying row
        // [2*HORIZONTAL_WIDTH_PIXELS*16 bits:3*HORIZONTAL_WIDTH_PIXELS*16 bits) - Final row (used to
        // initialize next screen on key press)
        if ((reset_i == 1'b1) || (next_screen_i == 1'b1)) begin
            mem_write_enable_o = 1'b1;

            // Assume that reset is depressed for > 640 clock cycles, so that we can store the whole first row
            // in on-chip RAM. 640 clock cycles / 25.175Mcycles/second == 25.4*10^-6 == 25.4us
            if (reset_i == 1'b1) begin
                mem_write_address_o = {1'b0, reset_x_coord};

                if (seed_or_random_i == 1'b0) begin
                    if (reset_x_coord == (`HORIZONTAL_WIDTH_PIXELS/2)) begin
                        mem_write_data_o = `BLACK;
                    end
                    else begin
                        mem_write_data_o = `WHITE;
                    end
                end
                else begin
                    if (next_random_bit == 1'b0) begin
                        mem_write_data_o = `BLACK;
                    end
                    else begin
                        mem_write_data_o = `WHITE;
                    end
                end
            end
            else begin
                mem_write_address_o = {1'b0, reset_x_coord_n1};
                mem_write_data_o = mem_read_data_i;
            end
        end
        else begin
            mem_write_enable_o = is_inside_visible_n3;

            if (y_pixel_coord_i == (`VERTICAL_HEIGHT_PIXELS - 10'h1)) begin
                mem_write_address_o = x_pixel_coord_n3 + (10'h2*`HORIZONTAL_WIDTH_PIXELS);
            end
            else begin
                mem_write_address_o = x_pixel_coord_n3 + `HORIZONTAL_WIDTH_PIXELS;
            end

            // Continually write to the previous x-coord pixel on the next row the value assigned from
            // the current rule.
            case (previous_row_state)
                3'b000: begin
                    mem_write_data_o = `SELECT_COLOUR(rule_i[7]);
                end
                3'b001: begin
                    mem_write_data_o = `SELECT_COLOUR(rule_i[6]);
                end
                3'b010: begin
                    mem_write_data_o = `SELECT_COLOUR(rule_i[5]);
                end
                3'b011: begin
                    mem_write_data_o = `SELECT_COLOUR(rule_i[4]);
                end
                3'b100: begin
                    mem_write_data_o = `SELECT_COLOUR(rule_i[3]);
                end
                3'b101: begin
                    mem_write_data_o = `SELECT_COLOUR(rule_i[2]);
                end
                3'b110: begin
                    mem_write_data_o = `SELECT_COLOUR(rule_i[1]);
                end
                3'b111: begin
                    mem_write_data_o = `SELECT_COLOUR(rule_i[0]);
                end
                default: begin
                    mem_write_data_o = `WHITE;
                end
            endcase
        end
    end

    // Three cycles of delay: the read of whatever pixel was above us in memory takes one cycle, then
    // two more cycles to get all three pixels into previous_row_state
    always @(posedge clock_i) begin
        x_pixel_coord_n1 <= x_pixel_coord_i;
        x_pixel_coord_n2 <= x_pixel_coord_n1;
        x_pixel_coord_n3 <= x_pixel_coord_n2;

        is_inside_visible_n1 <= is_inside_visible_region_i;
        is_inside_visible_n2 <= is_inside_visible_n1;
        is_inside_visible_n3 <= is_inside_visible_n2;
    end

    // Synchronous reset, TODO(brendan): why, versus async reset?
    // State machine, previous_row_state, reset handling
    always @(posedge clock_i) begin
        if ((reset_i == 1'b1) || (next_screen_i == 1'b1)) begin
            current_state <= `HAS_RESET;
            previous_row_state <= 3'b111;
            reset_x_coord_n1 <= reset_x_coord;

            // During reset, if SW[17] == 1, then use one pixel at x == 320.
            // If SW[17] == 0, use LFSR seeded with reset_x_coord to generate
            if (reset_x_coord == `LAST_X_PIXEL) begin
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
                    // previous_row_state should save the 639 pixel as it's written.
                    // Then, on is_inside_visible_n1 and is_inside_visible_n2, previous_row_state should be
                    // loading pixels 0 and 1.
                    // Therefore these bits are buffered one clock cyle.
                    // On is_inside_visible_n3, previous_row_state starts writing.
                    if (is_inside_visible_n1) begin
                        previous_row_state <= {previous_row_state[1:0], mem_read_data_i[15]};
                    end
                    else if (is_inside_visible_n2) begin
                        previous_row_state <= {previous_row_state[1:0], prev_row_pixel0_save};
                    end
                    else if (is_inside_visible_n3) begin
                        previous_row_state <= {previous_row_state[1:0], mem_write_data_o[15]};
                    end

                    // x_pixel_coord_i will be 1 when the read from pixel 0 is in mem_read_data_i, so we save
                    // pixel 0 when x_pixel_coord_i == 10'b1
                    if (x_pixel_coord_i == 10'b1) begin
                        prev_row_pixel0_save <= mem_read_data_i[15];
                    end
                end
                default: begin
                    current_state <= `HAS_RESET;
                end
            endcase
        end
    end

    lfsr lfsr_inst(.next_random_bit_o(next_random_bit),
                   .clock_i(clock_i),
                   .reset_i(reset_i));

endmodule
