module assertion(input wire clock_i, input wire test);

    always @(posedge clock_i) begin
        if (test !== 1'b1) begin
            $display("ASSERTION FAILED in %m");
            $finish;
        end
    end

endmodule
