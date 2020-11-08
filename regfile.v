module regfile(
    clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg, 
    ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, 
    data_readRegB
);

    input clock, ctrl_writeEnable, ctrl_reset;
    input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    input [31:0] data_writeReg;

    output [31:0] data_readRegA, data_readRegB;
    

    wire [31:0] decoderOut;
    wire [31:0] Rgout0, Rgout1, Rgout2, Rgout3, Rgout4, Rgout5, Rgout6, Rgout7, Rgout8, Rgout9, Rgout10, Rgout11, Rgout12, Rgout13, Rgout14, Rgout15, Rgout16, Rgout17, Rgout18, Rgout19, Rgout20, Rgout21, Rgout22, Rgout23, Rgout24, Rgout25, Rgout26, Rgout27, Rgout28, Rgout29, Rgout30, Rgout31;
 
    decoder32 decodWriteReg(decoderOut, ctrl_writeReg, ctrl_writeEnable);

    assign Rgout0 = 32'b0;
    register32 NormReg1(Rgout1, data_writeReg, ~clock, decoderOut[1], ctrl_reset);
    register32 NormReg2(Rgout2, data_writeReg, ~clock, decoderOut[2], ctrl_reset);
    register32 NormReg3(Rgout3, data_writeReg, ~clock, decoderOut[3], ctrl_reset);
    register32 NormReg4(Rgout4, data_writeReg, ~clock, decoderOut[4], ctrl_reset);
    register32 NormReg5(Rgout5, data_writeReg, ~clock, decoderOut[5], ctrl_reset);
    register32 NormReg6(Rgout6, data_writeReg, ~clock, decoderOut[6], ctrl_reset);
    register32 NormReg7(Rgout7, data_writeReg, ~clock, decoderOut[7], ctrl_reset);
    register32 NormReg8(Rgout8, data_writeReg, ~clock, decoderOut[8], ctrl_reset);
    register32 NormReg9(Rgout9, data_writeReg, ~clock, decoderOut[9], ctrl_reset);
    register32 NormReg10(Rgout10, data_writeReg, ~clock, decoderOut[10], ctrl_reset);
    register32 NormReg11(Rgout11, data_writeReg, ~clock, decoderOut[11], ctrl_reset);
    register32 NormReg12(Rgout12, data_writeReg, ~clock, decoderOut[12], ctrl_reset);
    register32 NormReg13(Rgout13, data_writeReg, ~clock, decoderOut[13], ctrl_reset);
    register32 NormReg14(Rgout14, data_writeReg, ~clock, decoderOut[14], ctrl_reset);
    register32 NormReg15(Rgout15, data_writeReg, ~clock, decoderOut[15], ctrl_reset);
    register32 NormReg16(Rgout16, data_writeReg, ~clock, decoderOut[16], ctrl_reset);
    register32 NormReg17(Rgout17, data_writeReg, ~clock, decoderOut[17], ctrl_reset);
    register32 NormReg18(Rgout18, data_writeReg, ~clock, decoderOut[18], ctrl_reset);
    register32 NormReg19(Rgout19, data_writeReg, ~clock, decoderOut[19], ctrl_reset);
    register32 NormReg20(Rgout20, data_writeReg, ~clock, decoderOut[20], ctrl_reset);
    register32 NormReg21(Rgout21, data_writeReg, ~clock, decoderOut[21], ctrl_reset);
    register32 NormReg22(Rgout22, data_writeReg, ~clock, decoderOut[22], ctrl_reset);
    register32 NormReg23(Rgout23, data_writeReg, ~clock, decoderOut[23], ctrl_reset);
    register32 NormReg24(Rgout24, data_writeReg, ~clock, decoderOut[24], ctrl_reset);
    register32 NormReg25(Rgout25, data_writeReg, ~clock, decoderOut[25], ctrl_reset);
    register32 NormReg26(Rgout26, data_writeReg, ~clock, decoderOut[26], ctrl_reset);
    register32 NormReg27(Rgout27, data_writeReg, ~clock, decoderOut[27], ctrl_reset);
    register32 NormReg28(Rgout28, data_writeReg, ~clock, decoderOut[28], ctrl_reset);
    register32 NormReg29(Rgout29, data_writeReg, ~clock, decoderOut[29], ctrl_reset);
    register32 NormReg30(Rgout30, data_writeReg, ~clock, decoderOut[30], ctrl_reset);
    register32 NormReg31(Rgout31, data_writeReg, ~clock, decoderOut[31], ctrl_reset);

    decoderTristate selectRegA(data_readRegA, ctrl_readRegA, Rgout0, Rgout1, Rgout2, Rgout3, Rgout4, Rgout5, Rgout6, Rgout7, Rgout8, Rgout9, Rgout10, Rgout11, Rgout12, Rgout13, Rgout14, Rgout15, Rgout16, Rgout17, Rgout18, Rgout19, Rgout20, Rgout21, Rgout22, Rgout23, Rgout24, Rgout25, Rgout26, Rgout27, Rgout28, Rgout29, Rgout30, Rgout31); 
    decoderTristate selectRegB(data_readRegB, ctrl_readRegB, Rgout0, Rgout1, Rgout2, Rgout3, Rgout4, Rgout5, Rgout6, Rgout7, Rgout8, Rgout9, Rgout10, Rgout11, Rgout12, Rgout13, Rgout14, Rgout15, Rgout16, Rgout17, Rgout18, Rgout19, Rgout20, Rgout21, Rgout22, Rgout23, Rgout24, Rgout25, Rgout26, Rgout27, Rgout28, Rgout29, Rgout30, Rgout31);

endmodule
