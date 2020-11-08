module mux_2(out, select2, in0, in1);
    input select2;
    input [31:0] in0, in1;
    output [31:0] out;
    assign out = select2 ? in1 : in0;
endmodule
