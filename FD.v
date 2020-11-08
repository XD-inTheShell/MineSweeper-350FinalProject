module FD(D_PC, D_IR, F_PC, F_IR, clock, reset, enable);
    input clock, reset, enable;
    input [31:0] F_PC, F_IR;
    output [31:0] D_PC, D_IR;

    register32 FDpcLatch(D_PC, F_PC, clock, enable, reset);
    register32 FDirLatch(D_IR, F_IR, clock, enable, reset);

endmodule
