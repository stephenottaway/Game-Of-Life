module onesPlaceFSM (tensPlaceOn, hexThreeDisplay, startGameSwitch, clk, reset);
	input logic startGameSwitch, clk, reset;
	output logic [6:0] hexThreeDisplay;
	output logic tensPlaceOn;
	
	enum logic [6:0] { off = 7'b1111111, zero = 7'b1000000, one = 7'b1111001, two = 7'b0100100, three = 7'b0110000, four = 7'b0011001, five = 7'b0010010, six = 7'b0000010, seven = 7'b1111000, eight = 7'b0000000, nine = 7'b0010000 } ps, ns;
	
	
	
	always_comb begin
		case (ps) 
			
			off: if (startGameSwitch)  ns = zero;
				  else ns = ps;
			
			zero: ns = one;
			
			one: ns = two;
			
			two: ns = three;
			
			three: ns = four;
			
			four: ns = five;
			
			five: ns = six;
			
			six: ns = seven;
			
			seven: ns = eight;
			
			eight: ns = nine;
			
			nine: ns = zero;
			
		endcase
	end
	
	
	assign hexThreeDisplay = ps;
	assign tensPlaceOn = (ps == nine);
	
	
	
	logic six_hundred_sixty_ms; // Period of the slower clock signal we want to create a 1.5 Hz clock enable for
	generateClockEnable clockEnable (.six_hundred_sixty_ms, .clk, .reset);
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= off;
		else if (six_hundred_sixty_ms)
			ps <= ns;
	end
	
endmodule


module onesPlaceFSM_testbench();
	logic startGameSwitch, clk, reset;
	logic [6:0] hexThreeDisplay;
	logic tensPlaceOn;
	
	onesPlaceFSM dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0; 
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; startGameSwitch <= 0; repeat(4) @(posedge clk);
		startGameSwitch <= 1; repeat(20) @(posedge clk);
	  $stop;
	end
endmodule
