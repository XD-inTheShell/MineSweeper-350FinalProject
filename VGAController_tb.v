`timescale 1 ns/ 100 ps
module VGAController_tb();
    reg clock, reset, left, right, up, down;

    VGAController controller(.clk(clock), .reset(reset), .left(left), .right(right), .up(up), .down(down), .hSync(), .vSync(), .VGA_R(), .VGA_G(), .VGA_B(), .ps2_clk(), .ps2_data());
    initial begin
        clock = 0;
        reset = 0;
        right = 0;
        left = 0;
        up = 0;
        down = 0;

        #500
        right = 1;
        //Set a time delay, in nanoseconds
        #500000000;

        //Ends the testbench
        $finish;
    end

    always  
        #10 clock = ~clock;

    initial begin
        //output filename
        $dumpfile("VGAController.vcd");
        // Module to capture and what level, 0 means all wires
        $dumpvars(0, VGAController_tb);
    end

endmodule