`timescale 1 ns/ 100 ps
module VGAController(     
	input clk, 			// 50 MHz System Clock
	input reset, 		// Reset Signal
	input left, input right, input up, input down, input middle, input pr_reset,
	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B,  // Blue Signal Bits
	inout ps2_clk,
	inout ps2_data,
	output pressed,
	output [31:0] VGAid,
	output [31:0] loadBlock,
	input [31:0] memDataOut2
	);
	
	// Lab Memory Files Location
	//localparam FILES_PATH = "C:/Users/xd54/Desktop/testFinal/";
	localparam FILES_PATH = "/Users/xiyingdeng/Desktop/Fall2020/ECE350/AG350/MineSweeper-350FinalProject/";
	// Clock divider 50 MHz -> 25 MHz
	wire clk25; // 25MHz clock
	reg [9:0] x_topleft=4;
    reg [8:0] y_topleft=2;
	
  

	reg pixCounter2 = 0;      // Pixel counter to divide the clock
    assign clk25 = pixCounter2; // Set the clock high whenever the second bit (2) is high
	always @(posedge clk) begin
		pixCounter2 <= pixCounter2 + 1; // Since the reg is only 3 bits, it will reset every 8 cycles
	end

	// VGA Timing Generation for a Standard VGA Screen
	localparam 
		VIDEO_WIDTH = 640,  // Standard VGA Width
		VIDEO_HEIGHT = 480; // Standard VGA Height

	wire active, screenEnd;
	wire[9:0] x;
	wire[8:0] y;
	
	VGATimingGenerator #(
		.HEIGHT(VIDEO_HEIGHT), // Use the standard VGA Values
		.WIDTH(VIDEO_WIDTH))
	Display( 
		.clk25(clk25),  	   // 25MHz Pixel Clock
		.reset(reset),		   // Reset Signal
		.screenEnd(screenEnd), // High for one cycle when between two frames
		.active(active),	   // High when drawing pixels
		.hSync(hSync),  	   // Set Generated H Signal
		.vSync(vSync),		   // Set Generated V Signal
		.x(x), 				   // X Coordinate (from left)
		.y(y)); 			   // Y Coordinate (from top)	   

	// Image Data to Map Pixel Location to Color Address
	localparam 
		PIXEL_COUNT = VIDEO_WIDTH*VIDEO_HEIGHT, 	             // Number of pixels on the screen
		PIXEL_ADDRESS_WIDTH = $clog2(PIXEL_COUNT) + 1,           // Use built in log2 command
		BITS_PER_COLOR = 12, 	  								 // Nexys A7 uses 12 bits/color
		PALETTE_COLOR_COUNT = 256, 								 // Number of Colors available
		PALETTE_ADDRESS_WIDTH = $clog2(PALETTE_COLOR_COUNT) + 1; // Use built in log2 Command

	wire[PIXEL_ADDRESS_WIDTH-1:0] imgAddress;  	 // Image address for the image data
	wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr; 	 // Color address for the color palette
	assign imgAddress = x + 640*y;				 // Address calculated coordinate

	RAM #(		
		.DEPTH(PIXEL_COUNT), 				     // Set RAM depth to contain every pixel
		.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
		.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
		.MEMFILE({FILES_PATH, "image.mem"})) // Memory initialization
	ImageData(
		.clk(clk), 						 // Falling edge of the 100 MHz clk
		.addr(imgAddress),					 // Image data address
		.dataOut(colorAddr),				 // Color palette address
		.wEn(1'b0)); 						 // We're always reading

	// Color Palette to Map Color Address to 12-Bit Color
	wire[BITS_PER_COLOR-1:0] colorData; // 12-bit color data at current pixel
    wire[BITS_PER_COLOR-1:0] square_color;
    wire ctrl_in_square;
    assign square_color = 12'h777;

	RAM #(
		.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
		.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
		.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
		.MEMFILE({FILES_PATH, "colors.mem"}))  // Memory initialization
	ColorPalette(
		.clk(clk), 							   	   // Rising edge of the 100 MHz clk
		.addr(colorAddr),					       // Address from the ImageData RAM
		.dataOut(colorData),				       // Color at current pixel
		.wEn(1'b0)); 						       // We're always reading
	
	
	// Assign to output color from register if active
	wire[BITS_PER_COLOR-1:0] colorOut; 			  // Output color 
	wire [BITS_PER_COLOR-1:0] active_color, active_color0, active_color1;

	wire[9:0] x_index;
	wire[8:0] y_index;
	wire[9:0] blockID;
	wire[8:0] y_proc;
	wire[31:0] memOut;
	wire[3:0] blockStatus;
    
	assign x_index = x >> 6;
	assign y_index = y >> 6;

  	localparam STEP_SIZE = 1;
    wire f; // highlighted?
    assign f = (x_index == x_topleft) && (y_index == y_topleft);
	wire bg; // is it background color?
	assign bg = (x_index == 0 || y_index ==0) || (x_index>=6 || y_index>=6);
	
	assign y_proc = y_index - 1;
	assign blockID = ((y_proc) << 2) + y_proc + x_index - 1;
	wire legalBlk;
	assign legalBlk = blockID < 25;
	//assign blockID_final = bg ? 32'b0 : blockID;
	wire [31:0] y_mark_proc;
	assign y_mark_proc = y_topleft - 1;
	assign VGAid = ((y_mark_proc) << 2) + y_mark_proc + x_topleft - 1;
	assign loadBlock = {22'b0,blockID};
  	// // for testing:
	// VGAtestRAM blockInfo(.wEn(1'b0), .addr({2'b0,blockID}), .clk(clk),
    //               .dataIn(32'b0), .dataOut(memOut));
	assign blockStatus = memDataOut2[3:0];

	

    // Choose flipped color
    reg[BITS_PER_COLOR-1:0] BlockColor;
    /// ********Change in 
    always @(blockStatus)
    case(blockStatus)
        4'd0 : BlockColor <= 12'hfff;
        4'd1 : BlockColor <= 12'h770;
        4'd2 : BlockColor <= 12'h0f0;
        4'd3 : BlockColor <= 12'h00f;
        4'd4 : BlockColor <= 12'h700;
        4'd5 : BlockColor <= 12'h070;
        4'd6 : BlockColor <= 12'h007;
        4'd7 : BlockColor <= 12'hff0;
        4'd8 : BlockColor <= 12'h0ff;
		4'd9 : BlockColor <= 12'hf00;
		4'd10 : BlockColor <= 12'h000;
		4'd11 : BlockColor <= 12'h000;
    endcase
    
    assign active_color0 = bg ? colorData : BlockColor;
	assign active_color = f ? square_color : active_color0;
  
	assign colorOut = active ? active_color : 12'd0; // When not active, output black
	
	// Quickly assign the output colors to their channels using concatenation
	assign {VGA_R, VGA_G, VGA_B} = colorOut;

	// debounce the buttons so that it does not 
	// increase multiple times when user press the button
	// since screenEnd is asserted frequently
	// wire up_db, down_db, right_db, left_db;
	// debouncer db0( .pushed_button(up), .clock(clk), .debounced_button(up_db));
	// debouncer db1( .pushed_button(down), .clock(clk), .debounced_button(down_db));
	// debouncer db2( .pushed_button(left), .clock(clk), .debounced_button(left_db));
	// debouncer db3( .pushed_button(right), .clock(clk), .debounced_button(right_db));
	//debouncer db( .pushed_button(), .clock(), .debounced_button());
	reg HasMoved = 0;
	wire sig;
	assign sig = up | down | left | right;
	always @(posedge screenEnd) begin
		if(sig) begin
			if(~HasMoved) begin
				HasMoved <= 1;
				x_topleft <= x_topleft + right*STEP_SIZE - left*STEP_SIZE;
        		y_topleft <= y_topleft + down*STEP_SIZE - up*STEP_SIZE;
			end
		end 
		else 
			HasMoved <= 0;
		
	end

	
	reg hasPressed = 0;
	reg hasReset = 0;
	always @(posedge clk) begin
		if(pr_reset) begin
			hasReset <= 1;
			hasPressed <= 0;
		end	
		else if( middle) begin
			if(~hasReset) begin
				hasPressed <= 1;
			end
		end
		else
			hasReset <= 0;
	

	end

	assign pressed = hasPressed;

	
	
endmodule