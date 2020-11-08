module register32(out, in, clk, we, clr);
    input [31:0] in;
    input clk, we, clr;
    output [31:0] out;

    genvar i;
    generate
        for(i=0; i<32; i=i+1) begin: loopDFF
            dffe_ref regDFF(out[i], in[i], clk, we, clr);
        end 
    endgenerate


endmodule