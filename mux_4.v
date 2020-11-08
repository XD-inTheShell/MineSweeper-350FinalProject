module mux_4(out, select4, in0, in1, in2, in3);
    input [1:0] select4;
    input [31:0] in0, in1, in2, in3;
    output [31:0] out;
    wire [31:0] w1, w2;
    mux_2 first_top2(w1, select4[0], in0, in1);
    mux_2 first_bottom2(w2, select4[0], in2, in3);
    mux_2 second2(out, select4[1], w1, w2);
endmodule
