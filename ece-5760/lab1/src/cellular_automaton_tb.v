`define MAX_X_PIXEL_COORD 10'd639
`define MAX_Y_PIXEL_COORD 10'd479

module cellular_automaton_tb;

    reg clock;
    reg reset;
    reg [9:0] x_pixel_coord;
    reg [9:0] y_pixel_coord;
    wire [7:0] red;
    wire [7:0] green;
    wire [7:0] blue;
    reg test_first_line;

    function [9:0] increment_or_reset_pixel_coord(input [9:0] pixel_coord, input [9:0] max_pixel_coord);
        begin
            if (pixel_coord == max_pixel_coord) begin
                increment_or_reset_pixel_coord = 1'b0;
            end
            else begin
                increment_or_reset_pixel_coord = pixel_coord + 10'b1;
            end
        end
    endfunction

    always begin
        #5 clock = ~clock;
    end

    always @(posedge clock) begin
        x_pixel_coord <= increment_or_reset_pixel_coord(x_pixel_coord, `MAX_X_PIXEL_COORD);

        if (x_pixel_coord == `MAX_X_PIXEL_COORD) begin
            y_pixel_coord <= increment_or_reset_pixel_coord(y_pixel_coord, `MAX_Y_PIXEL_COORD);
        end
    end

    // Test initial two lines out of reset:
    // Line 0: Pixel 320 is black, all other pixels are white
    initial begin
        $dumpfile("test.lxt");
        $dumpvars(0, cellular_automaton_tb);
        clock = 1'b0;
        reset = 1'b1;
        x_pixel_coord = 8'h0;
        y_pixel_coord = 8'h0;
        #5 reset = 1'b0;
        #800000 $finish;
    end

    cellular_automaton cellular_automaton_inst(.red_o(red),
                                               .green_o(green),
                                               .blue_o(blue),
                                               .x_pixel_coord_i(x_pixel_coord),
                                               .y_pixel_coord_i(y_pixel_coord),
                                               .clock_i(clock),
                                               .reset_i(reset));

    always @* begin
        if (y_pixel_coord != 0) begin
            test_first_line = 1;
        end
        else if (x_pixel_coord == 320) begin
            if ((red == 8'h0) && (green == 8'h0) && (blue == 8'h0)) begin
                test_first_line = 1;
            end
            else begin
                test_first_line = 0;
            end
        end
        else begin
            if ((red == 8'hFF) && (green == 8'hFF) && (blue == 8'hFF)) begin
                test_first_line = 1;
            end
            else begin
                test_first_line = 0;
            end
        end
    end
        
    assertion assertion0(.clock_i(clock), .test(test_first_line));

endmodule
