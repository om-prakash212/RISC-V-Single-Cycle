module ALU(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);

    input [31:0]A,B;                // 32-bit input operands
    input [2:0]ALUControl;          // 3-bit control signal to select ALU operation
    output Carry,OverFlow,Zero,Negative; // Status flags
    output [31:0]Result;            // 32-bit ALU result

    wire Cout;                      // Carry out from addition/subtraction
    wire [31:0]Sum;                 // Sum result from addition/subtraction

    // Perform addition or subtraction based on ALUControl[0]
    // If ALUControl[0] == 0: A + B
    // If ALUControl[0] == 1: A + (~B + 1) (i.e., A - B)
    assign {Cout,Sum} = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
  
    // Select ALU operation based on ALUControl
    // 000: ADD, 001: SUB, 010: AND, 011: OR, 101: SLT (set less than)
    assign Result = (ALUControl == 3'b000) ? Sum :
                    (ALUControl == 3'b001) ? Sum :
                    (ALUControl == 3'b010) ? A & B :
                    (ALUControl == 3'b011) ? A | B :
                    (ALUControl == 3'b101) ? {{31{1'b0}},(Sum[31])} : {32{1'b0}};
    
    // Overflow detection for addition/subtraction
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));

    // Carry flag for addition/subtraction
    assign Carry = ((~ALUControl[1]) & Cout);

    // Zero flag: set if Result is zero
    assign Zero = &(~Result);

    // Negative flag: set if Result is negative (MSB is 1)
    assign Negative = Result[31];

endmodule