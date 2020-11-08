module BlockRAM_tb();
    reg                     clk;
    reg                     wEn;
    reg [11:0] addr1;
    reg [11:0] addr2;
    reg [31:0]    dataIn, checkID;
    reg nowCheck;

    BlockRAM testRAM(.clk(clk), .wEn(wEn), .addr1(addr1), .addr2(addr2), .dataIn(dataIn), .checkID(checkID), .nowCheck(nowCheck));
    initial begin
        clk = 0;
        wEn = 0;
        addr1 = 12'b0;
        addr2 = 12'b0;
        dataIn = 31'b0;
        nowCheck = 0;
        checkID = 32'd5;

        #20
        nowCheck = 1;
        #30
        nowCheck = 0;
        #40
        checkID = 32'd16;
        #60
        nowCheck = 1;

        //Set a time delay, in nanoseconds
        #8000;

        //Ends the testbench
        $finish;
    end

    always  
        #10 clk = ~clk;

    // integer i, j;
    initial begin
        //output filename
        $dumpfile("BlockRAM_tb.vcd");
        // Module to capture and what level, 0 means all wires
        //$dumpvars(0, BlockRAM_tb);
        // for(i = 0; i < 5; i = i + 1)
        //     $dumpvars(1, BlockRAM_tb.testRAM.BlockRAM.numArray[i][0]);
        //     $dumpvars(1, BlockRAM_tb.testRAM.BlockRAM.numArray[i][0]);
        
        // for (i = 0; i < 5; i = i + 1) begin
        //     for (j = 0; j < 5; j = j + 1) begin
        //         $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[i][j]);
        //     end
        // end
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[0]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[1]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[2]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[3]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[4]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[5]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[6]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[7]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[8]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[9]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[10]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[11]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[12]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[13]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[14]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[15]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[16]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[17]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[18]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[19]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[20]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[21]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[22]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[23]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.MemoryArray[24]);

        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[0]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[1]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[2]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[3]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[4]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[5]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[6]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[7]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[8]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[9]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[10]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[11]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[12]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[13]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[14]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[15]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[16]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[17]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[18]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[19]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[20]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[21]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[22]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[23]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[24]);
        $dumpvars(0, BlockRAM_tb);
    end
endmodule