`timescale 1 ns / 100 ps
module Wrapper_tb();
    reg clock, reset, flip;
    reg [9:0] x_topleft;
    reg [8:0] y_topleft;
    reg [31:0] VGAid;
    Wrapper Pipelined_Processor(.clock(clock), .reset(reset), .x_topleft(x_topleft), .y_topleft(y_topleft), .flip(flip), .VGAid(VGAid));

    initial begin
        clock = 0;
        reset = 0;
        x_topleft = 9'd5;
        y_topleft = 8'd3;
        flip = 0;
        VGAid = 0;
        #10
        flip = 1;
        VGAid = 9;
        //Set a time delay, in nanoseconds
        #8000;

        //Ends the testbench
        $finish;
    end

    always  
        #10 clock = ~clock;

    initial begin
        //output filename
        $dumpfile("Wrapper.vcd");
        // Module to capture and what level, 0 means all wires
        $dumpvars(0, Wrapper_tb);
    end
endmodule