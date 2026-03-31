module control_unit (
    input         [5:0]   op_code,
    input         [5:0]   funct,
    output  reg           regwrite,
    output  reg           alu_src,
    output  reg           memread,
    output  reg           memwrite,
    output  reg           memtoreg,
    output  reg           branch,
    output  reg           jump,
    output  reg           reg_dest,
    output  reg   [3:0]   alu_op
);

always @(*) begin

    regwrite = 0;
    reg_dest = 0;
    alu_src  = 0;
    memtoreg = 0;
    memwrite = 0;
    memread  = 0;
    branch   = 0;
    jump     = 0;
    alu_op   = 4'b000;

    case (op_code)
        6'b000000: begin
            regwrite = 1;
            reg_dest = 1;
            alu_src  = 0;
            memtoreg = 0;
            memwrite = 0;
            memread  = 0;
            branch   = 0;
            jump     = 0;

            case (funct)
                6'b100000: alu_op = 4'b010;
                6'b100010: alu_op = 4'b011;
                6'b100100: alu_op = 4'b000;
                6'b100101: alu_op = 4'b001;
                default:   alu_op = 4'b000;
            endcase
        end

        6'b001000: begin
            regwrite = 1;
            reg_dest = 0;
            alu_src  = 1;
            alu_op   = 4'b010;
        end

        default: begin
        end
    endcase
end

endmodule