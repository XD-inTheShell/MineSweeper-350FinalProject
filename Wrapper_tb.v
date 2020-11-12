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
        #50
        flip = 1;
        VGAid = 32'd1;
        #200
        flip = 0;
        //Set a time delay, in nanoseconds
        #250
        flip = 1;
        VGAid = 8;
        #300
        flip = 0;
        #8000;

        //Ends the testbench
        $finish;
    end

    always  
        #10 clock = ~clock;

    initial begin
        //output filename
        $dumpfile("Wrapper_tb.vcd");
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[0]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[1]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[2]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[3]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[4]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[5]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[6]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[7]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[8]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[9]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[10]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[11]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[12]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[13]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[14]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[15]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[16]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[17]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[18]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[19]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[20]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[21]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[22]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[23]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.MemoryArray[24]);

        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[0]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[1]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[2]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[3]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[4]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[5]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[6]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[7]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[8]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[9]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[10]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[11]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[12]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[13]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[14]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[15]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[16]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[17]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[18]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[19]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[20]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[21]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[22]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[23]);
        $dumpvars(0, Wrapper_tb.Pipelined_Processor.BlockInfo.numArray[24]);
        // Module to capture and what level, 0 means all wires
        $dumpvars(0, Wrapper_tb);
    end
endmodule