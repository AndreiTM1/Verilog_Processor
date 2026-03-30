module register_file(
    input clk,
    input regwrite,
    input [4:0]     read_reg1,
    input [4:0]     read_reg2,
    input [4:0]     write_reg,
    input [31:0]    write_data,

    output [31:0]   read_data_1,
    output [31:0]   read_data_2
);

reg [31:0] rf [0:31];

assign read_data_1 = (read_reg1 == 0) ? 0 : rf [read_reg1];
assign read_data_2 = (read_reg2 == 0) ? 0 : rf [read_reg2];

always @(posedge clk) begin            
    if(regwrite && write_reg != 0) rf [write_reg] <= write_data;
end


endmodule