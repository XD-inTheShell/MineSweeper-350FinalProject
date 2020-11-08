module BlockRAM_tb();
    reg                     clk;
    reg                     wEn;
    reg [11:0] addr1;
    reg [11:0] addr2;
    reg [31:0]    dataIn;

    BlockRAM testRAM(.clk(clk), .wEn(wEn), .addr1(addr1), .addr2(addr2), .dataIn(dataIn));
    initial begin
        clk = 0;
        wEn = 0;
        addr1 = 12'b0;
        addr2 = 12'b0;
        dataIn = 31'b0;

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
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[0][0]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[0][1]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[0][2]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[0][3]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[0][4]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[1][0]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[1][1]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[1][2]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[1][3]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[1][4]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[2][0]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[2][1]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[2][2]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[2][3]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[2][4]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[3][0]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[3][1]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[3][2]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[3][3]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[3][4]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[4][0]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[4][1]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[4][2]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[4][3]);
        $dumpvars(0, BlockRAM_tb.testRAM.BlockRAM.numArray[4][4]);
        $dumpvars(0, BlockRAM_tb);
    end
endmodule