module vga_controller_tb;

    reg [7:0] vga_red;
    reg [7:0] vga_green;
    reg [7:0] vga_blue;
    reg vga_sync;
    reg vga_blank;
    reg horizontal_sync;
    reg vertical_sync;
    reg clock;
    reg reset;

    always begin
        #5 clock = ~clock;
    end

    initial begin
        $dumpfile("test.lxt");
        $dumpvars(0, vga_controller_tb);
        clock = 1'b0;
        reset = 1'b1;
        #5 reset = 1'b0;
        #5 reset = 1'b1;
        #800000 $finish;
    end

    reg [9:0] x_pixel_coord;
    reg [9:0] y_pixel_coord;

    vga_controller vga_controller_inst(.x_pixel_coord_o(x_pixel_coord),
                                       .y_pixel_coord_o(y_pixel_coord),
                                       .vga_red_o(vga_red),
                                       .vga_green_o(vga_green),
                                       .vga_blue_o(vga_blue),
                                       .vga_sync_n_o(vga_sync_n),
                                       .vga_blank_n_o(vga_blank_n),
                                       .vga_horizontal_sync_o(vga_horizontal_sync),
                                       .vga_vertical_sync_o(vga_vertical_sync),
                                       .clock_i(clock),
                                       .reset_i(reset),
                                       .red_i(8'hFF),
                                       .green_i(8'b0),
                                       .blue_i(8'b0));

endmodule
