`define FRONT_PORCH_CYCLES 10'h30

module vga_controller(output wire [7:0] vga_red_o,
                      output wire [7:0] vga_green_o,
                      output wire [7:0] vga_blue_o,
                      output wire vga_sync_n_o,
                      output wire vga_blank_n_o,
                      output wire vga_vertical_sync_o,
                      output wire vga_horizontal_sync_o,
                      inout wire clock_i,
                      input wire reset_i);

    reg [9:0] horizontal_cycle_count;

    // SYNC can be left as 0 so that green channel is not encoded specially
    assign vga_sync_n_o = 1'b0;

    // Assume 640x480 screen
    // - 25MHz Pixel Clock
    // - back porch 1.9us => 47.5 cycles
    // - front porch 0.6us => 15 cycles
    // Dot rate = (Horizontal res) * (Vertical res) * (Refresh Rate) / (Retrace Factor)
    //          = 20232000
    
    // H-Sync state machine
    always @((posedge clock_i) or (negedge reset_i)) begin
        if (reset_i == 1'b0) begin
            vga_horizontal_sync_o = 1'b0;
            horizontal_cycle_count = 10'b0;
        end
        else begin
            if (horizontal_cycle_count == FRONT_PORCH_CYCLES) begin
                vga_horizontal_sync_o = 1'b1;
            end
            else begin
                vga_horizontal_sync_o = vga_horizontal_sync_o;
            end
            // TODO(bwd): Add back porch, increment cycle count
        end
    end

endmodule
