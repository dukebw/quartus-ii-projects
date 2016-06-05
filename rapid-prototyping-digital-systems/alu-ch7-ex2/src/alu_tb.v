`include "alu_opcodes.vh"

module assertion(input wire clock_i, input wire test);

    always @(posedge clock_i) begin
        if (test !== 1'b1) begin
            $display("ASSERTION FAILED in %m");
            $finish;
        end
    end

endmodule

module alu_tb;

    wire [31:0] alu_result;
    reg clock;
    reg [31:0] a;
    reg [31:0] b;
    reg [4:0] opcode;

    reg add_assert_valid;
    reg sub_assert_valid;
    reg add_test;

    initial
        clock = 1'b0;
    always
        #20 clock = ~clock;

    initial
    begin
        $dumpfile("test.lxt");
        $dumpvars(0, alu_tb);
        #0 add_assert_valid = 0;
        #0 sub_assert_valid = 0;
        #0 a = 32'h44e96cb8;
        #0 b = 32'h5dd45397;
        #0 opcode = `ALU_GET_OPCODE(`ALU_PASS_A, `ALU_NO_SHIFT);
        #25 opcode = `ALU_GET_OPCODE(`ALU_ADD, `ALU_NO_SHIFT);;
        #45 b = 32'h79adc30e;
        #60 add_assert_valid = 1;
        #100 $finish;
    end

    alu alu_inst1(.alu_out(alu_result),
                  .clock_i(clock),
                  .opcode_i(opcode),
                  .input_a(a),
                  .input_b(b));

    assign add_test = !add_assert_valid || (alu_result === 32'hbe972fc6);

    assertion add_assert(.clock_i(clock),
                         .test(add_test));

endmodule
