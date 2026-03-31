module processor (
    input clk,
    input rst_n,

    output [31:0] pc_out,
    output [31:0] alu_res_out
);

wire [31:0] pc_crt;
wire [31:0] pc_next;
wire [31:0] instr;

wire [31:0] rd1, rd2;        
wire [31:0] imm_ext;           
wire [31:0] alu_src_b;       
wire [31:0] alu_result;
wire        alu_zero;

wire        reg_write;
wire        alu_src;
wire        mem_read, mem_write, mem_to_reg;
wire        branch, jump;
wire [3:0]  alu_ctrl;

assign pc_next = pc_current + 4;
assign pc_out = pc_current;
assign alu_res_out = alu_result;

program_counter pc_inst (
    .clk(clk),
    .rst_n(rst_n),
    .next_pc(pc_next),
    .pc(pc_current)
);

instruction_memory imem_inst (
    .adress(pc_current),
    .instruction(instr)
);

control_unit cu_inst (
    .op_code(instr[31:26]),
    .funct(instr[5:0]),
    .regwrite(reg_write),
    .alu_src(alu_src),
    .memread(mem_read),
    .memwrite(mem_write),
    .memtoreg(mem_to_reg),
    .branch(branch),
    .jump(jump),
    .alu_op(alu_ctrl)
);

register_file rf_inst (
    .clk(clk),
    .regwrite(reg_write),
    .read_reg1(instr[25:21]), 
    .read_reg2(instr[20:16]), 
    .write_reg(instr[15:11]), 
    .write_data(alu_result),  
    .read_data_1(rd1),
    .read_data_2(rd2)
);

sign_extend se_inst (
    .in(instr[15:0]),
    .out(imm_ext)
);

assign alu_src_b = (alu_src == 1) ? imm_ext : rd2;

alu alu_inst (
    .nr_a(rd1),
    .nr_b(alu_src_b),
    .alu_op(alu_ctrl),
    .result(alu_result),
    .zero(alu_zero)
);

endmodule