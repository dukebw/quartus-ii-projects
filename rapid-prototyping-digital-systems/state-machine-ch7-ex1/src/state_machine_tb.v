module state_machine_tb;
    reg clock;
    reg reset;
    reg y;
    wire x;

    initial
        clock = 1'b0;
    always
        #5 clock = ~clock;

    initial
    begin
        $dumpfile("test.lxt");
        $dumpvars(0, state_machine_tb);
        reset = 1'b1;
        #10 reset = 1'b0;
        #0 y = 0;
        #10 y = 1;
        #20 y = 0;
        #30 y = 1;
        #40 $finish;
    end

    state_machine sm1(.clock(clock),
                      .x_out(x),
                      .y_in(y),
                      .reset(reset));
endmodule
