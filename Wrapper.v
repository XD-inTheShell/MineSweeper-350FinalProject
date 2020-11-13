`timescale 1ns / 1ps
/**
 */

module Wrapper(clock, reset, right, left, up, down, middle, hSync, vSync, VGA_R, VGA_G, VGA_B
                ////// test bits
                // , x_topleft, y_topleft, VGAid
                );
    //////////// need to divide clock
    input clock, reset;
    input right, left, up, down, middle;
    output hSync, vSync;
    output[3:0] VGA_R, VGA_G, VGA_B;
    ///// test bits;
    //input [9:0] x_topleft;
    //input [8:0] y_topleft;
    //input [31:0] VGAid;

    wire rwe, mwe, nowCheck, pr_reset, clk50;
    wire[4:0] rd, rs1, rs2;
    wire[31:0] instAddr, instData, 
               rData, regA, regB,
               memAddr1, memAddr2, memDataIn, 
               memDataOut1, memDataOut2,
               blockID_data, VGAid, loadBlock;
    
    ///// Main Processing Unit
    processor CPU(.clock(clk50), .reset(reset), 
                  
		  ///// ROM
                  .address_imem(instAddr), .q_imem(instData),
                  
		  ///// Regfile
                  .ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
                  .ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
                  .data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),
                  
		  ///// BlockRAM
                  .wren(mwe), .address_dmem(memAddr1), 
                  .data(memDataIn), .q_dmem(memDataOut1),
          ///// Game
                  .pressed(pressed),
                  .x_game(),
                  .y_game(),
                  .pr_reset(pr_reset),
                  .VGAid(VGAid),
                  .nowCheck(nowCheck)
                  ); 
                  
    ///// Instruction Memory (ROM)
    ROM InstMem(.clk(clk50), .wEn(1'b0), .addr(instAddr[11:0]), .dataIn(32'b0), .dataOut(instData));
    
    ///// Register File
    regfile RegisterFile(.clock(clk50), 
             .ctrl_writeEnable(rwe), .ctrl_reset(reset), 
             .ctrl_writeReg(rd),
             .ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
             .data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB), .blockID_data(blockID_data));
             
    ///// Processor Memory (RAM)
    /////////////////////////////////
    // Modified for Minesweeper
    assign memAddr2 = loadBlock;
    BlockRAM BlockInfo(.clk(clk50), .wEn(mwe), .addr1(memAddr1[11:0]), .addr2(memAddr2[11:0]), 
            .dataIn(memDataIn), .dataOut1(memDataOut1), .dataOut2(memDataOut2), 
            .checkID(blockID_data), .nowCheck(nowCheck));
    /////////////////////////////////

    ///// VGA Controller
    VGAController VGA(.clk(clk50), 			
            .reset(reset), 		// Reset Signal
            .left(left), .right(right), .up(up), .down(down), .middle(middle), .pr_reset(pr_reset),
            .hSync(hSync), 		// H Sync Signal
            .vSync(vSync), 		// Veritcal Sync Signal
            .VGA_R(VGA_R),  // Red Signal Bits
            .VGA_G(VGA_G),  // Green Signal Bits
            .VGA_B(VGA_B),
            .pressed(pressed),
            .VGAid(VGAid), .loadBlock(loadBlock),
            .memDataOut2(memDataOut2));

    reg pixCounter = 0;      // Pixel counter to divide the clock
    
    assign clk50 = pixCounter; // Set the clock high whenever the second bit (2) is high
	always @(posedge clock) begin
		pixCounter <= pixCounter + 1; // Since the reg is only 3 bits, it will reset every 8 cycles
	end

endmodule
