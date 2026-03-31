module alu (
    input      [31:0]  nr_a,
    input      [31:0]  nr_b,
    input      [3:0]   alu_op,
    output reg         zero,
    output reg [31:0]  result
);

always @(*) begin
    case (alu_op)
        4'b000: result = nr_a & nr_b;
        4'b001: result = nr_a | nr_b;
        4'b010: result = nr_a + nr_b;
        4'b011: result = nr_a - nr_b;
        4'b100: result = (nr_a < nr_b) ? 1 : 0;
        4'b101: result = (nr_a > nr_b) ? 1 : 0;
        default: result = 32'b0;
    endcase
    zero = (result == 32'b0);
end

endmodule