module instruction_memory (
    input   [31:0]  adress,
    output  [31:0]  instruction
);

reg [31:0] array [0:63]; 

assign instruction = array [adress >> 2];

initial begin
    $readmemh("fisier.hex", array);
end

endmodule