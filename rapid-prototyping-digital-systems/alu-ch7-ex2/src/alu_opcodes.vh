`define ALU_PASS_A      3'b000
`define ALU_ADD         3'b001
`define ALU_SUBTRACT    3'b010
`define ALU_AND         3'b011
`define ALU_OR          3'b100
`define ALU_INCREMENT   3'b101
`define ALU_DECREMENT   3'b110
`define ALU_PASS_B      3'b111

`define ALU_NO_SHIFT    2'b00
`define ALU_LEFT_SHIFT  2'b01
`define ALU_RIGHT_SHIFT 2'b10
`define ALU_PASS_ZEROS  2'b11

`define ALU_GET_OPCODE(alu_arith_op, alu_shift_op) ((alu_arith_op << 2) | alu_shift_op)
