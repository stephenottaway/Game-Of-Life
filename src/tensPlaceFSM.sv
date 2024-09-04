module tensPlaceFSM (hundredsPlaceOn, hexFourDisplay, tensPlaceOn, clk , reset);
	input logic tensPlaceOn, clk, reset;
	output logic [6:0] hexFourDisplay;
	output logic hundredsPlaceOn;
	
	enum logic [6:0] { off = 7'b1111111, zero = 7'b1000000, one = 7'b1111001, two = 7'b0100100, three = 7'b0110000, four = 7'b0011001, five = 7'b0010010, six = 7'b0000010, seven = 7'b1111000, eight = 7'b0000000, nine = 7'b0010000 } ps, ns;
	
	always_comb begin 
		case(ps)
		
			off: if (tensPlaceOn) ns = one;
				  else ns = ps;
				  
			zero: if (tensPlaceOn) ns = one;
					else ns = ps;
			 
			one: if (tensPlaceOn) ns = two;
				  else ns = ps;
			
			two: if (tensPlaceOn) ns = three;
				  else ns = ps;
			
			three: if (tensPlaceOn) ns = four;
				    else ns = ps;
			
			four: if (tensPlaceOn) ns = five;
					else ns = ps;
			
			five: if (tensPlaceOn) ns = six;
					else ns = ps;
			
			six: if (tensPlaceOn) ns = seven;
				  else ns = ps;
			
			seven: if (tensPlaceOn) ns = eight;
					 else ns = ps;
			
			eight: if (tensPlaceOn) ns = nine;
					 else ns = ps;
			
			nine: if (tensPlaceOn) ns = zero;
					else ns = ps;
			
		endcase
	end
	
	
	assign hexFourDisplay = ps;
	assign hundredsPlaceOn = (ps == nine);
	
	
	logic six_hundred_sixty_ms; // Period of the slower clock signal we want to create a 1.5 Hz clock enable for
	generateClockEnable clockEnable (.six_hundred_sixty_ms, .clk, .reset);
	
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= off;
		else if (six_hundred_sixty_ms)
			ps <= ns;
	end
	
endmodule


module tensPlaceFSM_testbench();
	logic tensPlaceOn, clk, reset;
	logic [6:0] hexFourDisplay;
	logic hundredsPlaceOn;
	
	tensPlaceFSM dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0; 
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; tensPlaceOn <= 0; @(posedge clk);
		reset <= 0; repeat(4) @(posedge clk);
		tensPlaceOn <= 1; repeat(20) @(posedge clk);
	  $stop;
	end
endmodule

module onesAndTensPlaceFSM_testbench();
	logic startGameSwitch, tensPlaceOnOutput, clk, reset;
	logic [6:0] hexThreeDisplay, hexFourDisplay;
	logic hundredsPlaceOn;
	
	onesPlaceFSM ones (.tensPlaceOn(tensPlaceOnOutput), .hexThreeDisplay, .startGameSwitch, .clk, .reset); 
	tensPlaceFSM tens (.hundredsPlaceOn, .hexFourDisplay, .tensPlaceOn(tensPlaceOnOutput), .clk, .reset);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0; 
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; startGameSwitch <= 0; repeat(4) @(posedge clk);
		startGameSwitch <= 1; repeat(50) @(posedge clk);
	  $stop;
	end
endmodule
		
	



		
	