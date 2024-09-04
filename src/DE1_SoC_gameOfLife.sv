module DE1_SoC_gameOfLife (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	output logic [35:0] GPIO_1;
	input logic CLOCK_50;
	
	// Turn off HEX0, HEX1, HEX2, and HEX5
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	/* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // clock for faster components of the system
	 //assign SYSTEM_CLOCK = CLOCK_50;
	
	
	
	/* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST(SW[9]), .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 

	gameOfLifeUpdated game (.RedPixels, .GrnPixels, .leftButton(~KEY[3]), .rightButton(~KEY[0]), .downButton(~KEY[2]), .upButton(~KEY[1]), .confirmSeedSwitch(SW[0]), .startGameSwitch(SW[1]), .clk(SYSTEM_CLOCK), .reset(SW[9]));
	
	logic tensPlaceOn;
	onesPlaceFSM ones (.tensPlaceOn, .hexThreeDisplay(HEX3), .startGameSwitch(SW[1]), .clk(SYSTEM_CLOCK), .reset(SW[9]));
	logic hundredsPlaceOn;
	tensPlaceFSM tens (.hundredsPlaceOn, .hexFourDisplay(HEX4), .tensPlaceOn, .clk(SYSTEM_CLOCK), .reset(SW[9]));
	 


endmodule


module DE1_SoC_gameOfLife_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [35:0] GPIO_1;
	logic CLOCK_50;
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	
	DE1_SoC_gameOfLife dut (.*);
	
	initial begin
		SW[9] <= 1; @(posedge CLOCK_50);
		SW[9] <= 0; KEY[3] <= 1; KEY[0] <= 1; KEY[2] <= 1; KEY[1] <= 1; SW[0] <= 0; SW[1] <= 0; @(posedge CLOCK_50);
		SW[0] <= 1; @(posedge CLOCK_50);
		SW[0] <= 0; repeat(3) @(posedge CLOCK_50);
		KEY[3] <= 0; @(posedge CLOCK_50);
		KEY[3] <= 1; repeat(4) @(posedge CLOCK_50);
		SW[0] <= 1; @(posedge CLOCK_50);
		SW[0] <= 0; repeat(3) @(posedge CLOCK_50);
		KEY[1] <= 0; @(posedge CLOCK_50);
		KEY[1] <= 1; repeat(4) @(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; repeat(4) @(posedge CLOCK_50);
		SW[0] <= 1; @(posedge CLOCK_50);
		SW[0] <= 0; repeat(3) @(posedge CLOCK_50);
		KEY[2] <= 0; @(posedge CLOCK_50);
		KEY[2] <= 1; repeat(4) @(posedge CLOCK_50);
		KEY[2] <= 0; @(posedge CLOCK_50);
		KEY[2] <= 1; repeat(4) @(posedge CLOCK_50);
		SW[0] <= 1; @(posedge CLOCK_50);
		SW[0] <= 0; repeat(3) @(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; repeat(4) @(posedge CLOCK_50);
		SW[0] <= 1; @(posedge CLOCK_50);
		SW[0] <= 0; repeat(3) @(posedge CLOCK_50);
		SW[1] <= 1; repeat(50) @(posedge CLOCK_50);
		SW[9] <= 1; @(posedge CLOCK_50);
		SW[9] <= 0; KEY[3] <= 1; KEY[0] <= 0; KEY[2] <= 1; KEY[1] <= 1; SW[0] <= 0; SW[1] <= 0; @(posedge CLOCK_50);
	  $stop;
	end
endmodule
	 
	 
	
	
	
	
	
	
	
	
	
	
	
	
	