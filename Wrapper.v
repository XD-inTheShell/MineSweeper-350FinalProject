`timescale 1ns / 1ps
/**
 */

module Wrapper(clock, reset, right, left, up, down, flip, hSync, vSync, VGA_R, VGA_G, VGA_B
                ////// test bits
                , x_topleft, y_topleft, VGAid
                );
    input clock, reset;
    input right, left, up, down, flip;
    output hSync, vSync;
    output[3:0] VGA_R, VGA_G, VGA_B;
    ///// test bits;
    input [9:0] x_topleft;
    input [8:0] y_topleft;
    input [31:0] VGAid;

    wire rwe, mwe;
    wire[4:0] rd, rs1, rs2;
    wire[31:0] instAddr, instData, 
               rData, regA, regB,
               memAddr1, memAddr2, memDataIn, 
               memDataOut1, memDataOut2;
    
    ///// Main Processing Unit
    processor CPU(.clock(clock), .reset(reset), 
                  
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
                  .pressed(flip),
                  .x_game(x_topleft),
                  .y_game(y_topleft),
                  .pr_reset(),
                  .VGAid(VGAid)
                  ); 
                  
    ///// Instruction Memory (ROM)
    ROM InstMem(.clk(clock), .wEn(1'b0), .addr(instAddr[11:0]), .dataIn(32'b0), .dataOut(instData));
    
    ///// Register File
    regfile RegisterFile(.clock(clock), 
             .ctrl_writeEnable(rwe), .ctrl_reset(reset), 
             .ctrl_writeReg(rd),
             .ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
             .data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
             
    ///// Processor Memory (RAM)
    BlockRAM BlockInfo(.clk(clock), .wEn(mwe), .addr1(memAddr1[11:0]), .addr2(memAddr2[11:0]), .dataIn(memDataIn), .dataOut1(memDataOut1), .dataOut2(memDataOut2));

    ///// VGA Controller
    VGAController VGA(.clk(), 			
            .reset(reset), 		// Reset Signal
            .left(left), .right(right), .up(up), .down(down),
            .hSync(hSync), 		// H Sync Signal
            .vSync(vSync), 		// Veritcal Sync Signal
            .VGA_R(VGA_R),  // Red Signal Bits
            .VGA_G(VGA_G),  // Green Signal Bits
            .VGA_B(VGA_B));

endmodule
