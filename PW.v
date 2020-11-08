module PW(PW_Pin, PW_Pout, PW_IRin, PW_IRout, PW_IRen, PW_Pen, clock, reset);
    input PW_Pen, PW_IRen, clock, reset;
    input [31:0] PW_Pin, PW_IRin;
    output [31:0] PW_Pout, PW_IRout;

    register32 PWproduct(.out(PW_Pout), .in(PW_Pin), .clk(clock), .we(PW_Pen), .clr(reset));
    register32 PWir(.out(PW_IRout), .in(PW_IRin), .clk(clock), .we(PW_IRen), .clr(reset));

endmodule
