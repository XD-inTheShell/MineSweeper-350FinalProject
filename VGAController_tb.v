`timescale 1 ns/ 100 ps
module VGAController_tb();
    reg clock, reset, left, right, up, down, middle, pr_reset;
    wire pressed;
    VGAController controller(.clk(clock), .reset(reset), .left(left), .right(right), .up(up), .down(down), .hSync(), .vSync(), .VGA_R(), .VGA_G(), .VGA_B(), .ps2_clk(), .ps2_data(), .middle(middle), .pr_reset(pr_reset), .pressed(pressed));
    initial begin
        clock = 0;
        reset = 0;
        right = 0;
        left = 0;
        up = 0;
        down = 0;
        middle = 0;
        pr_reset = 0;

        #10
        right = 1;
        #50
        right = 0;

        #100
        middle = 1;
        #505
        pr_reset = 1;
        #515
        pr_reset = 0;
        #525
        middle = 0;
        #535
        middle = 1;
        #545
        middle = 0;
        #555
        pr_reset = 1;
        #565
        pr_reset = 0;
        #575
        middle = 1;
        //Set a time delay, in nanoseconds
        #50000;

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