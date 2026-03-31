`timescale 1ns / 1ps

module processor_tb;

    // Semnale pentru intrările procesorului
    reg clk;
    reg rst_n;

    // Semnale pentru monitorizarea ieșirilor
    wire [31:0] pc;
    wire [31:0] alu_result;

    // Instanțierea Unității de Test (UUT - Unit Under Test)
    processor uut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_out(pc),
        .alu_res_out(alu_result)
    );

    // Generarea semnalului de ceas (perioadă de 10 unități de timp)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Comută starea la fiecare 5ns
    end

    // Scenariul de testare
    initial begin
        // Pasul 1: Inițializare și Reset
        rst_n = 0;           // Activează reset-ul (activ pe 0) [cite: 42]
        #15;                 // Așteaptă 15 unități de timp
        rst_n = 1;           // Dezactivează reset-ul; procesorul începe execuția [cite: 43]

        // Pasul 2: Monitorizarea execuției
        // Simularea va rula până când toate instrucțiunile din fisier.hex sunt procesate
        // sau până la un timp limită stabilit
        #200; 

        $display("Simulare finalizata.");
        $finish;             // Oprește simularea
    end

    // Afișarea valorilor în consolă pentru debug la fiecare schimbare a PC-ului
    always @(pc) begin
        $display("Timp: %0t | PC: %h | Rezultat ALU: %d", $time, pc, alu_result);
    end

endmodule