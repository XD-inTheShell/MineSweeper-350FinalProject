`timescale 1ns / 1ps
/**
 */

module Wrapper(clock, reset);
    input clock, reset;

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
                  .data(memDataIn), .q_dmem(memDataOut1)); 
                  
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

    VGAController VGA();

endmodule
