`timescale 1 ns/ 100 ps
module testTimer_tb();
    reg clock;
    wire newclk;

    testTimer divTime(.clock(clock), .newclk(newclk));
    initial begin
        clock = 0;
        
        //Set a time delay, in nanoseconds
        #50000;

        //Ends the testbench
        $finish;
    end

    always  
        #10 clock = ~clock;

    initial begin
        //output filename
        $dumpfile("testTimer.vcd");
        // Module to capture and what level, 0 means all wires
        $dumpvars(0, testTimer_tb);
    end

endmodule