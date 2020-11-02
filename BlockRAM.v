`timescale 1ns / 1ps
module RAM #( parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 12, DEPTH = 4096, MEMFILE = "/Users/xiyingdeng/Desktop/Fall2020/ECE350/processor/dataMem.mem") (
    input wire                     clk,
    input wire                     wEn,
    input wire [ADDRESS_WIDTH-1:0] addr1,
    input wire [ADDRESS_WIDTH-1:0] addr2,
    input wire [DATA_WIDTH-1:0]    dataIn,
    output reg [DATA_WIDTH-1:0]    dataOut1,
    output reg [DATA_WIDTH-1:0]    dataOut2); //VGA read
    
    reg[DATA_WIDTH-1:0] MemoryArray[0:DEPTH-1];

    initial begin
        if(MEMFILE > 0) begin
            $readmemh(MEMFILE, MemoryArray);
        end
    end
    
    always @(negedge clk) begin
        if(wEn) begin
            MemoryArray[addr1] = dataIn;
        end
    end

    assign dataOut1 = MemoryArray[addr1];
    assign dataOut2 = MemoryArray[addr2];
endmodule

