module XM(M_O, M_B, M_IR, X_O, X_B, X_IR, clock, reset);
    input clock, reset;
    input [31:0] X_O, X_B, X_IR;
    output [31:0] M_O, M_B, M_IR;

    register32 XM_O_Latch(M_O, X_O, clock, 1'b1, reset);
    register32 XM_B_Latch(M_B, X_B, clock, 1'b1, reset);
    register32 XMirLatch(M_IR, X_IR, clock, 1'b1, reset);

endmodule