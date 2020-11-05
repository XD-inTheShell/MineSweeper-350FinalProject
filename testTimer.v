module testTimer(input clock, output newclk);
    reg pixCounter = 0;      // Pixel counter to divide the clock
    assign newclk = pixCounter; // Set the clock high whenever the second bit (2) is high
	always @(posedge clock) begin
		pixCounter <= pixCounter + 1; // Since the reg is only 3 bits, it will reset every 8 cycles
	end

endmodule