module Single_Cycle_Top_Tb ();
    
    reg clk=1'b1,rst;

    Single_Cycle_Top Single_Cycle_Top(
                                .clk(clk),
                                .rst(rst)
    );

    initial begin
        $dumpfile("Single Cycle.vcd");
        $dumpvars(0);
    end

    always 
    begin
        clk = ~ clk;
        #5;  
        
    end
    
    initial
    begin
        rst <= 1'b0;
        #50;

        rst <=1'b1;
        #550;
        $finish;
    end
endmodule