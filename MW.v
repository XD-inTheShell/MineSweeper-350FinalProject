module MW(W_O, W_D, W_IR, M_O, M_D, M_IR, clock, reset);
    input clock, reset;
    input [31:0] M_O, M_D, M_IR;
    output [31:0] W_O, W_D, W_IR;

    register32 MW_O_Latch(W_O, M_O, clock, 1'b1, reset);
    register32 MW_D_Latch(W_D, M_D, clock, 1'b1, reset);
    register32 MWirLatch(W_IR, M_IR, clock, 1'b1, reset);

endmodule