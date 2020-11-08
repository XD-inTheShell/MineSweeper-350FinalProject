module mux4_5(out, select4, in0, in1, in2, in3);
    input [1:0] select4;
    input [4:0] in0, in1, in2, in3;
    output [4:0] out;
    wire [4:0] w1, w2;
    mux2_5 first_top2(w1, select4[0], in0, in1);
    mux2_5 first_bottom2(w2, select4[0], in2, in3);
    mux2_5 second2(out, select4[1], w1, w2);
endmodule