module cla_adder(out, overflow, A, B, carry_in);
    input [31:0] A, B;
    input carry_in;
    output overflow;
    output [31:0] out;
    wire [31:0] Bval;
    wire c1, c2, c3;
    
    //subtraction
    genvar m;
    generate
        for (m=0; m<32; m=m+1) begin: loopB
            xor accom(Bval[m], B[m], carry_in);
        end
    endgenerate

    eight_bit_cla cla0(.sum(out[7:0]), .cout(c1), .overflow(), .A(A[7:0]), .B(Bval[7:0]), .carry_in(carry_in));
    eight_bit_cla cla1(.sum(out[15:8]), .cout(c2), .overflow(), .A(A[15:8]), .B(Bval[15:8]), .carry_in(c1));
    eight_bit_cla cla2(.sum(out[23:16]), .cout(c3), .overflow(), .A(A[23:16]), .B(Bval[23:16]), .carry_in(c2));
    eight_bit_cla cla3(.sum(out[31:24]), .cout(), .overflow(overflow), .A(A[31:24]), .B(Bval[31:24]), .carry_in(c3));


endmodule

module eight_bit_cla(sum, cout, overflow, A, B, carry_in);
    input [7:0] A, B;
    input carry_in;
    output overflow;
    output [7:0] sum;
    output cout;
    wire [7:0] p, g;
    wire c0, c1, c2, c3, c4, c5, c6;
    wire p0c0, p1p0c0, p1g0, p2p1p0c0, p2p1g0, p2g1, p3p2p1p0c0, p3p2p1g0, p3p2g1, p3g2; 
    wire p4p3p2p1p0c0, p4p3p2p1g0, p4p3p2g1, p4p3g2, p4g3;
    wire p5p4p3p2p1p0c0, p5p4p3p2p1g0, p5p4p3p2g1, p5p4p3g2, p5p4g3, p5g4;
    wire p6p5p4p3p2p1p0c0, p6p5p4p3p2p1g0, p6p5p4p3p2g1, p6p5p4p3g2, p6p5p4g3, p6p5g4, p6g5;
    wire p7p6p5p4p3p2p1p0c0, p7p6p5p4p3p2p1g0, p7p6p5p4p3p2g1, p7p6p5p4p3g2, p7p6p5p4g3, p7p6p5g4, p7p6g5, p7g6;
    
    genvar i;
    generate
        for (i = 0; i<8; i = i+1) begin: loop_pg
            and andg(g[i], A[i], B[i]);
            or orp(p[i], A[i], B[i]);
        end
    endgenerate

    //c1
    and p0c0(p0c0, p[0],carry_in);
    or c1(c1, g[0], p0c0);

    //c2
    and p1p0c0(p1p0c0, p[1], p[0], carry_in);
    and p1g0(p1g0, p[1], g[0]);
    or c2(c2, g[1], p1g0, p1p0c0);

    //c3
    and p2p1p0c0(p2p1p0c0, p[2], p[1], p[0], carry_in);
    and p2p1g0(p2p1g0, p[2], p[1], g[0]);
    and p2g1(p2g1, p[2], g[1]);
    or c3(c3, g[2], p2g1, p2p1g0, p2p1p0c0);

    //c4
    and p3p2p1p0c0(p3p2p1p0c0, p[3], p[2], p[1], p[0], carry_in);
    and p3p2p1g0(p3p2p1g0, p[3], p[2], p[1], g[0]);
    and p3p2g1(p3p2g1, p[3], p[2], g[1]);
    and p3g2(p3g2, p[3], g[2]);
    or c4(c4, g[3], p3g2, p3p2g1, p3p2p1g0, p3p2p1p0c0);

    //c5
    and p4p3p2p1p0c0(p4p3p2p1p0c0, p[4], p[3], p[2], p[1], p[0], carry_in);
    and p4p3p2p1g0(p4p3p2p1g0, p[4], p[3], p[2], p[1], g[0]);
    and p4p3p2g1(p4p3p2g1, p[4], p[3], p[2], g[1]);
    and p4p3g2(p4p3g2, p[4], p[3], g[2]);
    and p4g3(p4g3, p[4], g[3]);
    or c5(c5, g[4], p4g3, p4p3g2, p4p3p2g1, p4p3p2p1g0, p4p3p2p1p0c0);

    //c6
    and p5p4p3p2p1p0c0(p5p4p3p2p1p0c0, p[5], p[4], p[3], p[2], p[1], p[0], carry_in);
    and p5p4p3p2p1g0(p5p4p3p2p1g0, p[5], p[4], p[3], p[2], p[1], g[0]);
    and p5p4p3p2g1(p5p4p3p2g1, p[5], p[4], p[3], p[2], g[1]);
    and p5p4p3g2(p5p4p3g2, p[5], p[4], p[3], g[2]);
    and p5p4g3(p5p4g3, p[5], p[4], g[3]);
    and p5g4(p5g4, p[5], g[4]);
    or c6(c6, g[5], p5g4, p5p4g3, p5p4p3g2, p5p4p3p2g1, p5p4p3p2p1g0, p5p4p3p2p1p0c0);

    //c7
    and p6p5p4p3p2p1p0c0(p6p5p4p3p2p1p0c0, p[6], p[5], p[4], p[3], p[2], p[1], p[0], carry_in);
    and p6p5p4p3p2p1g0(p6p5p4p3p2p1g0, p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and p6p5p4p3p2g1(p6p5p4p3p2g1, p[6], p[5], p[4], p[3], p[2], g[1]);
    and p6p5p4p3g2(p6p5p4p3g2, p[6], p[5], p[4], p[3], g[2]);
    and p6p5p4g3(p6p5p4g3, p[6], p[5], p[4], g[3]);
    and p6p5g4(p6p5g4, p[6], p[5], g[4]);
    and p6g5(p6g5, p[6], g[5]);
    or c7(c7, g[6], p6g5, p6p5g4, p6p5p4g3, p6p5p4p3g2, p6p5p4p3p2g1, p6p5p4p3p2p1g0, p6p5p4p3p2p1p0c0);

    //c8 ; cout
    and p7p6p5p4p3p2p1p0c0(p7p6p5p4p3p2p1p0c0, p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0], carry_in);
    and p7p6p5p4p3p2p1g0(p7p6p5p4p3p2p1g0, p[7], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and p7p6p5p4p3p2g1(p7p6p5p4p3p2g1, p[7], p[6], p[5], p[4], p[3], p[2], g[1]);
    and p7p6p5p4p3g2(p7p6p5p4p3g2, p[7], p[6], p[5], p[4], p[3], g[2]);
    and p7p6p5p4g3(p7p6p5p4g3, p[7], p[6], p[5], p[4], g[3]);
    and p7p6p5g4(p7p6p5g4, p[7], p[6], p[5], g[4]);
    and p7p6g5(p7p6g5, p[7], p[6], g[5]);
    and p7g6(p7g6, p[7], g[6]);
    or cout(cout, g[7], p7g6, p7p6g5, p7p6p5g4, p7p6p5p4g3, p7p6p5p4p3g2, p7p6p5p4p3p2g1, p7p6p5p4p3p2p1g0, p7p6p5p4p3p2p1p0c0);



    s_calc s0(sum[0], A[0], B[0], carry_in);
    s_calc s1(sum[1],A[1],B[1], c1);
    s_calc s2(sum[2],A[2],B[2], c2);
    s_calc s3(sum[3],A[3],B[3], c3);
    s_calc s4(sum[4],A[4],B[4], c4);
    s_calc s5(sum[5],A[5],B[5], c5);
    s_calc s6(sum[6],A[6],B[6], c6);
    s_calc s7(sum[7],A[7],B[7], c7);

    xor ovr(overflow,cout, c7); 

endmodule

module s_calc(sum, A, B, carry_in);
    input A, B, carry_in;
    output sum;
    xor(sum, A, B, carry_in);
endmodule