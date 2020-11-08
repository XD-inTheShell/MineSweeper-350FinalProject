module decoderTristate(
    out, select,
    in0, in1, in2, in3, in4, in5, in6, in7, in8, 
    in9, in10, in11, in12, in13, in14, in15, 
    in16, in17, in18, in19, in20, in21, in22, 
    in23, in24, in25, in26, in27, in28, in29, in30, in31
);
    input [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31;
    input [4:0] select;
    output [31:0] out;
    wire [31:0] decodeBit;
    

    decoder32 decodeRead(decodeBit, select, 1'b1);

    my_tri tristateS0(out, decodeBit[0], in0);
    my_tri tristateS1(out, decodeBit[1], in1);
    my_tri tristateS2(out, decodeBit[2], in2);
    my_tri tristateS3(out, decodeBit[3], in3);
    my_tri tristateS4(out, decodeBit[4], in4);
    my_tri tristateS5(out, decodeBit[5], in5);
    my_tri tristateS6(out, decodeBit[6], in6);
    my_tri tristateS7(out, decodeBit[7], in7);
    my_tri tristateS8(out, decodeBit[8], in8);
    my_tri tristateS9(out, decodeBit[9], in9);
    my_tri tristateS10(out, decodeBit[10], in10);
    my_tri tristateS11(out, decodeBit[11], in11);
    my_tri tristateS12(out, decodeBit[12], in12);
    my_tri tristateS13(out, decodeBit[13], in13);
    my_tri tristateS14(out, decodeBit[14], in14);
    my_tri tristateS15(out, decodeBit[15], in15);
    my_tri tristateS16(out, decodeBit[16], in16);
    my_tri tristateS17(out, decodeBit[17], in17);
    my_tri tristateS18(out, decodeBit[18], in18);
    my_tri tristateS19(out, decodeBit[19], in19);
    my_tri tristateS20(out, decodeBit[20], in20);
    my_tri tristateS21(out, decodeBit[21], in21);
    my_tri tristateS22(out, decodeBit[22], in22);
    my_tri tristateS23(out, decodeBit[23], in23);
    my_tri tristateS24(out, decodeBit[24], in24);
    my_tri tristateS25(out, decodeBit[25], in25);
    my_tri tristateS26(out, decodeBit[26], in26);
    my_tri tristateS27(out, decodeBit[27], in27);
    my_tri tristateS28(out, decodeBit[28], in28);
    my_tri tristateS29(out, decodeBit[29], in29);
    my_tri tristateS30(out, decodeBit[30], in30);
    my_tri tristateS31(out, decodeBit[31], in31);

endmodule