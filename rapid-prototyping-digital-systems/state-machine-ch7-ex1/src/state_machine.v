module state_machine(clock, x_out, y_in, reset);
    output reg x_out;
    input wire clock;
    input wire y_in;
    input wire reset;
    reg present_state;

    parameter state_a = 1'b0, state_b = 1'b1;

    always @(posedge clock or posedge reset) begin
        if (reset)
            present_state <= state_a;
        else
            case (present_state)
                state_a: begin
                    if (y_in == 1'b0)
                        present_state <= state_b;
                end
                state_b: begin
                    if (y_in == 1'b1)
                        present_state <= state_a;
                end
                default: present_state <= present_state;
            endcase
    end

    always @(present_state) begin
        case (present_state)
            state_a: x_out = 1'b0;
            state_b: x_out = 1'b1;
            default: x_out = 1'b0;
        endcase
    end
endmodule
