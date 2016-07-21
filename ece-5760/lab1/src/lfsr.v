module lfsr(output wire next_random_bit_o,
            input wire clock_i,
            input wire reset_i);

    reg [15:0] state;

    assign next_random_bit_o = state[0] ^ state[1] ^ state[3] ^ state[12] ^ state[15];

    // Maximal-length 16-bit feedback polynomial (https://users.ece.cmu.edu/~koopman/lfsr/index.html)
    // x^16 + x^15 + x^13 + x^4 + 1
    always @(posedge clock_i) begin
        if ((reset_i == 1'b1) && (state == 16'b0)) begin
            state <= 16'b1;
        end
        else begin
            state <= {next_random_bit_o, state[15:1]};
        end
    end

endmodule
