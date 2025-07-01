`timescale 1ns/1ps

module ALU_tb;
    // Inputs
    reg [31:0] A, B;
    reg [2:0] ALUControl;
    
    // Outputs
    wire [31:0] Result;
    wire OverFlow, Carry, Zero, Negative;
    
    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .Result(Result),
        .ALUControl(ALUControl),
        .OverFlow(OverFlow),
        .Carry(Carry),
        .Zero(Zero),
        .Negative(Negative)
    );
    
    // Initialize dump
    initial begin
        $dumpfile("ALU_waveforms.vcd");
        $dumpvars(0, ALU_tb);
    end
    
    // Test cases
    initial begin
        // Test ADD (000)
        ALUControl = 3'b000;
        A = 32'h00000005;
        B = 32'h00000003;
        #10;
        
        // Test SUB (001)
        ALUControl = 3'b001;
        A = 32'h00000007;
        B = 32'h00000002;
        #10;
        
        // Test AND (010)
        ALUControl = 3'b010;
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        #10;
        
        // Test OR (011)
        ALUControl = 3'b011;
        A = 32'hAAAAAAAA;
        B = 32'h55555555;
        #10;
        
        // Test SLT (101)
        ALUControl = 3'b101;
        A = 32'h00000001;
        B = 32'h00000002;
        #10;
        
        A = 32'hFFFFFFFE;  // -2
        B = 32'hFFFFFFFF;  // -1
        #10;
        
        // Test overflow cases
        ALUControl = 3'b000;  // ADD
        A = 32'h7FFFFFFF;  // Max positive
        B = 32'h00000001;
        #10;
        
        ALUControl = 3'b001;  // SUB
        A = 32'h80000000;  // Min negative
        B = 32'h00000001;
        #10;
        
        $display("Simulation complete. Waveform saved to ALU_waveforms.vcd");
        $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time = %t: A=%h B=%h ALUControl=%b Result=%h Overflow=%b Carry=%b Zero=%b Negative=%b",
                 $time, A, B, ALUControl, Result, OverFlow, Carry, Zero, Negative);
    end
endmodule