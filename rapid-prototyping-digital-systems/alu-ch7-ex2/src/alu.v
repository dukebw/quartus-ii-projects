`include "alu_opcodes.vh"

module alu(output reg [31:0] alu_out,
           input wire clock_i,
           input wire [4:0] opcode_i,
           input wire [31:0] input_a,
           input wire [31:0] input_b);

    reg [31:0] alu_result;

    always @(*) begin
       case (opcode_i[4:2])
           `ALU_PASS_A: alu_result = input_a;
           `ALU_ADD: alu_result = input_a + input_b;
           `ALU_SUBTRACT: alu_result = input_a - input_b;
           `ALU_AND: alu_result = input_a & input_b;
           `ALU_OR: alu_result = input_a | input_b;
           `ALU_INCREMENT: alu_result = input_a + 32'b1;
           `ALU_DECREMENT: alu_result = input_a - 32'b1;
           default: alu_result = 32'b0;
       endcase
    end

    always @(posedge clock_i) begin
       case (opcode_i[1:0])
           `ALU_NO_SHIFT: alu_out <= alu_result;
           `ALU_LEFT_SHIFT: alu_out <= (alu_result << 1);
           `ALU_RIGHT_SHIFT: alu_out <= (alu_result >> 1);
           `ALU_PASS_ZEROS: alu_out <= 32'b0;
           default: alu_out <= 32'b0;
       endcase
    end

endmodule
