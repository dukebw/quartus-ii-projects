`include "vga_controller.vh"

module vga_controller(output reg [9:0] x_pixel_coord_o,
                      output reg [9:0] y_pixel_coord_o,
                      output reg [7:0] vga_red_o,
                      output reg [7:0] vga_green_o,
                      output reg [7:0] vga_blue_o,
                      output wire vga_sync_n_o,
                      output wire vga_blank_n_o,
                      output reg vga_horizontal_sync_o,
                      output reg vga_vertical_sync_o,
                      input wire clock_i,
                      input wire reset_i,
                      input wire [7:0] red_i,
                      input wire [7:0] green_i,
                      input wire [7:0] blue_i);

    reg [9:0] horizontal_cycle_count;
    reg [9:0] vertical_cycle_count;
    wire is_outside_visible_region;

    // SYNC can be left as 0 so that green channel is not encoded specially
    assign vga_sync_n_o = 1'b0;
    assign vga_blank_n_o = vga_vertical_sync_o & vga_horizontal_sync_o;

    // Assume 640x480 screen at 60Hz
    // - 25.175MHz Pixel Clock
    // - hsync 3.8us => 95.7 cycles
    // - horizontal back porch 1.9us => 47.8 cycles
    // - display interval 25.4us => 639.4 cycles (round to 640?)
    // - horizontal front porch 0.6us => 15.1 cycles
    //
    // - vsync 2 lines
    // - vertical back porch 33 lines
    // - display interval 480 lines
    // - vertical front porch 10 lines
    //
    // Dot rate = (Horizontal res) * (Vertical res) * (Refresh Rate) / (Retrace Factor)

    // RGB output must be off (0V) for a time period called the back porch after hsync pulse occurs.
    // This is followed by the display interval.
    // Then the front porch, followed by hsync again.

    // TODO(brendan): try transferring back porch cycles to front porch

    // Vsync timing is similar, except a vsync pulse signifies the end of one frame.

    // Address LUT calculation
    always @* begin
        if (`IS_OUTSIDE_VISIBLE_REGION(horizontal_cycle_count + `H_ADDRESS_LEAD_CYCLES, vertical_cycle_count)) begin
            x_pixel_coord_o = 10'b0;
            y_pixel_coord_o = 10'b0;
        end
        else begin
            x_pixel_coord_o = (horizontal_cycle_count + `H_ADDRESS_LEAD_CYCLES) - (`H_SYNC_CYCLES + `H_BACK_PORCH_CYCLES);
            y_pixel_coord_o = vertical_cycle_count - (`V_SYNC_CYCLES + `V_BACK_PORCH_CYCLES);
        end
    end

    // Assign output colours based on HSYNC, VSYNC
    always @* begin
        if (`IS_OUTSIDE_VISIBLE_REGION(horizontal_cycle_count, vertical_cycle_count)) begin
            vga_red_o = 8'b0;
            vga_green_o = 8'b0;
            vga_blue_o = 8'b0;
        end
        else begin
            vga_red_o = red_i;
            vga_green_o = green_i;
            vga_blue_o = blue_i;
        end
    end

    // H-Sync state machine
    always @(posedge clock_i or posedge reset_i) begin
        if (reset_i == 1'b1) begin
            vga_horizontal_sync_o <= 1'b0;
            horizontal_cycle_count <= 10'b0;
        end
        else begin
            if (horizontal_cycle_count < `HORIZONTAL_CYCLES_MAX) begin
                if (horizontal_cycle_count == (`H_SYNC_CYCLES - 10'b1)) begin
                    vga_horizontal_sync_o <= 1'b1;
                end

                horizontal_cycle_count <= horizontal_cycle_count + 10'b1;
            end
            else begin
                vga_horizontal_sync_o <= 1'b0;
                horizontal_cycle_count <= 10'b0;
            end
        end
    end

    // V-Sync state machine
    always @(posedge clock_i or posedge reset_i) begin
        if (reset_i == 1'b1) begin
            vga_vertical_sync_o <= 1'b0;
            vertical_cycle_count <= 10'b0;
        end
        else begin
            if (horizontal_cycle_count == `HORIZONTAL_CYCLES_MAX) begin
                if (vertical_cycle_count < `VERTICAL_CYCLES_MAX) begin
                    if (vertical_cycle_count == (`V_SYNC_CYCLES - 10'b1)) begin
                        vga_vertical_sync_o <= 1'b1;
                    end
                    vertical_cycle_count <= vertical_cycle_count + 10'b1;
                end
                else begin
                    vga_vertical_sync_o <= 1'b0;
                    vertical_cycle_count <= 10'b0;
                end
            end
        end
    end

endmodule
