module mux2_5(out, select2, in0, in1);
    input select2;
    input [4:0] in0, in1;
    output [4:0] out;
    assign out = select2 ? in1 : in0;
endmodule