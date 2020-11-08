module sll_op(out, in1, shamt);
    input [31:0] in1;
    input [4:0] shamt;
    output [31:0] out;
    wire [31:0] w0, w1, w2, w3;
    // wire cond0, cond1, cond2, cond3, cond4;

    // cond0 = shamt[0]；
    // cond1 = shamt[1];
    // assign cond2 = shamt[2];
    // assign cond3 = shamt[3];
    // assign cond4 = shamt[4];

    assign w0[31:16] = shamt[4] ? in1[15:0] : in1[31:16];
    assign w0[15:0] = shamt[4] ? 16'd0 : in1[15:0];

    assign w1[31:8] = shamt[3] ? w0[23:0] : w0[31:8];
    assign w1[7:0] = shamt[3] ? 8'd0 : w0[7:0];

    assign w2[31:4] = shamt[2] ? w1[27:0] : w1[31:4];
    assign w2[3:0] = shamt[2] ? 4'd0 : w1[3:0];

    assign w3[31:2] = shamt[1] ? w2[29:0] : w2[31:2];
    assign w3[1:0] = shamt[1] ? 2'd0 : w2[1:0];

    assign out[31:1] = shamt[0] ? w3[30:0] : w3[31:1];
    assign out[0] =  shamt[0] ? 0 : w3[0];


endmodule

