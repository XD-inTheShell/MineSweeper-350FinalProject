module regfile(
    clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg, 
    ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA, 
    data_readRegB,
    ////////////////////
    //game mod
    blockID_data
    ////////////////////
);

    input clock, ctrl_writeEnable, ctrl_reset;
    input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    input [31:0] data_writeReg;

    output [31:0] blockID_data;
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

    //decoderTristate selectRegA(data_readRegA, ctrl_readRegA, Rgout0, Rgout1, Rgout2, Rgout3, Rgout4, Rgout5, Rgout6, Rgout7, Rgout8, Rgout9, Rgout10, Rgout11, Rgout12, Rgout13, Rgout14, Rgout15, Rgout16, Rgout17, Rgout18, Rgout19, Rgout20, Rgout21, Rgout22, Rgout23, Rgout24, Rgout25, Rgout26, Rgout27, Rgout28, Rgout29, Rgout30, Rgout31); 
    //decoderTristate selectRegB(data_readRegB, ctrl_readRegB, Rgout0, Rgout1, Rgout2, Rgout3, Rgout4, Rgout5, Rgout6, Rgout7, Rgout8, Rgout9, Rgout10, Rgout11, Rgout12, Rgout13, Rgout14, Rgout15, Rgout16, Rgout17, Rgout18, Rgout19, Rgout20, Rgout21, Rgout22, Rgout23, Rgout24, Rgout25, Rgout26, Rgout27, Rgout28, Rgout29, Rgout30, Rgout31);
    ////////////////////
    //game mod
    assign blockID_data = Rgout29;
    //Reg 29 is for block ID
    ////////////////////
    reg [31:0] data_readRegA0, data_readRegB0;
    always @(ctrl_readRegA)
    case(ctrl_readRegA)
        5'd0 : data_readRegA0 <= Rgout0; 
        5'd1 : data_readRegA0 <= Rgout1; 
        5'd2 : data_readRegA0 <= Rgout2; 
        5'd3 : data_readRegA0 <= Rgout3; 
        5'd4 : data_readRegA0 <= Rgout4; 
        5'd5 : data_readRegA0 <= Rgout5; 
        5'd6 : data_readRegA0 <= Rgout6; 
        5'd7 : data_readRegA0 <= Rgout7; 
        5'd8 : data_readRegA0 <= Rgout8; 
        5'd9 : data_readRegA0 <= Rgout9; 
        5'd10 : data_readRegA0 <= Rgout10; 
        5'd11 : data_readRegA0 <= Rgout11; 
        5'd12 : data_readRegA0 <= Rgout12; 
        5'd13 : data_readRegA0 <= Rgout13; 
        5'd14 : data_readRegA0 <= Rgout14; 
        5'd15 : data_readRegA0 <= Rgout15; 
        5'd16 : data_readRegA0 <= Rgout16; 
        5'd17 : data_readRegA0 <= Rgout17; 
        5'd18 : data_readRegA0 <= Rgout18; 
        5'd19 : data_readRegA0 <= Rgout19; 
        5'd20 : data_readRegA0 <= Rgout20; 
        5'd21 : data_readRegA0 <= Rgout21; 
        5'd22 : data_readRegA0 <= Rgout22; 
        5'd23 : data_readRegA0 <= Rgout23; 
        5'd24 : data_readRegA0 <= Rgout24; 
        5'd25 : data_readRegA0 <= Rgout25; 
        5'd26 : data_readRegA0 <= Rgout26; 
        5'd27 : data_readRegA0 <= Rgout27; 
        5'd28 : data_readRegA0 <= Rgout28; 
        5'd29 : data_readRegA0 <= Rgout29; 
        5'd30 : data_readRegA0 <= Rgout30; 
        5'd31 : data_readRegA0 <= Rgout31;
    endcase

    always @(ctrl_readRegB)
    case(ctrl_readRegB)
        5'd0 : data_readRegB0 <= Rgout0; 
        5'd1 : data_readRegB0 <= Rgout1; 
        5'd2 : data_readRegB0 <= Rgout2; 
        5'd3 : data_readRegB0 <= Rgout3; 
        5'd4 : data_readRegB0 <= Rgout4; 
        5'd5 : data_readRegB0 <= Rgout5; 
        5'd6 : data_readRegB0 <= Rgout6; 
        5'd7 : data_readRegB0 <= Rgout7; 
        5'd8 : data_readRegB0 <= Rgout8; 
        5'd9 : data_readRegB0 <= Rgout9; 
        5'd10 : data_readRegB0 <= Rgout10; 
        5'd11 : data_readRegB0 <= Rgout11; 
        5'd12 : data_readRegB0 <= Rgout12; 
        5'd13 : data_readRegB0 <= Rgout13; 
        5'd14 : data_readRegB0 <= Rgout14; 
        5'd15 : data_readRegB0 <= Rgout15; 
        5'd16 : data_readRegB0 <= Rgout16; 
        5'd17 : data_readRegB0 <= Rgout17; 
        5'd18 : data_readRegB0 <= Rgout18; 
        5'd19 : data_readRegB0 <= Rgout19; 
        5'd20 : data_readRegB0 <= Rgout20; 
        5'd21 : data_readRegB0 <= Rgout21; 
        5'd22 : data_readRegB0 <= Rgout22; 
        5'd23 : data_readRegB0 <= Rgout23; 
        5'd24 : data_readRegB0 <= Rgout24; 
        5'd25 : data_readRegB0 <= Rgout25; 
        5'd26 : data_readRegB0 <= Rgout26; 
        5'd27 : data_readRegB0 <= Rgout27; 
        5'd28 : data_readRegB0 <= Rgout28; 
        5'd29 : data_readRegB0 <= Rgout29; 
        5'd30 : data_readRegB0 <= Rgout30; 
        5'd31 : data_readRegB0 <= Rgout31; 
    endcase

    assign data_readRegA = data_readRegA0;
    assign data_readRegB = data_readRegB0;

endmodule
