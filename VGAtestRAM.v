`timescale 1ns / 1ps
module VGAtestRAM #( parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 12, DEPTH = 25, MEMFILE = "") (
    input wire                     clk,
    input wire                     wEn,
    input wire [ADDRESS_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0]    dataIn,
    output reg [DATA_WIDTH-1:0]    dataOut);
    
    reg[DATA_WIDTH-1:0] MemoryArray[0:DEPTH-1];

    initial begin
        if(MEMFILE > 0) begin
            $readmemh(MEMFILE, MemoryArray);
        end
    end
    
    always @(negedge clk) begin
        if(wEn) begin
            MemoryArray[addr] <= dataIn;
        end else begin
            dataOut <= MemoryArray[addr];
        end
    end
endmodule