//////////
// Adapted from: https://www.fpga4student.com/2017/04/simple-debouncing-verilog-code-for.html
//////////
module debouncer(input pushed_button, input clock, output debounced_button);
    wire slow_enable;
    
    reg[27:0] counter = 0;
    assign slow_enable = (counter == {27{1'b1}});
    always @(posedge clock) begin
        counter <= counter + 1;
    end
    wire q0, q1, q2;
    dffe_ref dff0(.q(q0), .d(pushed_button), .clk(clock), .en(slow_enable), .clr(1'b0));
    dffe_ref dff1(.q(q1), .d(q0), .clk(clock), .en(slow_enable), .clr(1'b0));
    dffe_ref dff2(.q(q2), .d(q1), .clk(clock), .en(slow_enable), .clr(1'b0));
    
    assign debounced_button = q2 & ~q3;
endmodule