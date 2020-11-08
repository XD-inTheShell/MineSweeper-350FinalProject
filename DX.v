module DX(X_PC, X_A, X_B, X_IR, D_PC, D_A, D_B, D_IR, clock, reset);
    input clock, reset;
    input [31:0] D_PC, D_A, D_B, D_IR;
    output [31:0] X_PC, X_A, X_B, X_IR;

    register32 DXpcLatch(X_PC, D_PC, clock, 1'b1, reset);
    register32 DX_A_Latch(X_A, D_A, clock, 1'b1, reset);
    register32 DX_B_Latch(X_B, D_B, clock, 1'b1, reset);
    register32 DXirLatch(X_IR, D_IR, clock, 1'b1, reset);
    
endmodule
