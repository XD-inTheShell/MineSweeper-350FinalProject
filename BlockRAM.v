`timescale 1ns / 1ps
module BlockRAM #( parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 12, DEPTH = 4096, MEMFILE = "dataMem.mem") (
    input wire                     clk,
    input wire                     wEn,
    input wire [ADDRESS_WIDTH-1:0] addr1,
    input wire [ADDRESS_WIDTH-1:0] addr2,
    input wire [DATA_WIDTH-1:0]    dataIn,
    output wire [DATA_WIDTH-1:0]    dataOut1,
    output wire [DATA_WIDTH-1:0]    dataOut2); //VGA read
    
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

    wire [31:0] numArray[4:0][4:0];

    assign numArray[0][0] = (MemoryArray[1]==32'd10) + (MemoryArray[6]==32'd10) + (MemoryArray[5]==32'd10);
    assign numArray[0][4] = (MemoryArray[3]==32'd10) + (MemoryArray[8]==32'd10) + (MemoryArray[9]==32'd10);
    assign numArray[4][0] = (MemoryArray[15]==32'd10) + (MemoryArray[16]==32'd10) + (MemoryArray[21]==32'd10);
    assign numArray[4][4] = (MemoryArray[18]==32'd10) + (MemoryArray[19]==32'd10) + (MemoryArray[23]==32'd10);

    genvar i;
    generate
        for(i=1; i<4; i=i+1) begin: loopi
            assign numArray[0][i] = (MemoryArray[i-1]==32'd10) + (MemoryArray[i+1]==32'd10) + (MemoryArray[i+5]==32'd10)+ (MemoryArray[i+4]==32'd10)+ (MemoryArray[i+6]==32'd10);
            assign numArray[4][i] = (MemoryArray[20+i-1]==32'd10) + (MemoryArray[20+i+1]==32'd10) + (MemoryArray[20+i-5]==32'd10)+ (MemoryArray[20+i-4]==32'd10)+ (MemoryArray[20+i-6]==32'd10);
        end 
    endgenerate

    genvar j;
    generate
        for(j=1; j<4; j=j+1) begin: loopj
            assign numArray[j][0] = (MemoryArray[5*(j-1)]==32'd10) + (MemoryArray[5*(j+1)]==32'd10)+ (MemoryArray[5*(j-1)+1]==32'd10)+ (MemoryArray[5*(j+1)+1]==32'd10) + (MemoryArray[5*j+1]==32'd10);
            assign numArray[j][4] = (MemoryArray[5*(j-1)+4]==32'd10) + (MemoryArray[5*(j+1)+4]==32'd10)+ (MemoryArray[5*(j-1)+3]==32'd10)+ (MemoryArray[5*(j+1)+3]==32'd10) + (MemoryArray[5*j+3]==32'd10);
        end 
    endgenerate

    genvar m,n;
    generate
        for(m=1; m<4; m=m+1) begin: loopm
            for(n=1; n<4; n=n+1) begin: loopn
            assign numArray[m][n] = (MemoryArray[5*(m-1)+n]==32'd10) + (MemoryArray[5*(m+1)+n]==32'd10)+ (MemoryArray[5*(m-1)+n+1]==32'd10)+ (MemoryArray[5*(m+1)+n+1]==32'd10) + (MemoryArray[5*m+n+1]==32'd10)+ (MemoryArray[5*(m-1)+n-1]==32'd10)+ (MemoryArray[5*(m+1)+n-1]==32'd10) + (MemoryArray[5*m+n-1]==32'd10);
            end
        end 
    endgenerate
    

    // always @(negedge clk) begin
    //       $display("%d,     %d,     %d",numArray[0][0], numArray[0][1], numArray[4][2]);
    //   end
endmodule

