module greenSeedLightFSM (greenLED, gl, gla, ga, gra, gr, grb, gb, glb, selectingLightConfirmed, startGameSwitch, clk, reset); 
	input logic gl, gla, ga, gra, gr, grb, gb, glb, selectingLightConfirmed, startGameSwitch, clk , reset;
	output logic greenLED;
	
	// conditions for state changes of individual green LEDs during Game of Life 
	logic zeroLiveNeighbors, oneLiveNeighbor, twoLiveNeighbors, threeLiveNeighbors;
	
	zeroLN zero (.out(zeroLiveNeighbors), .l(gl), .la(gla), .a(ga), .ra(gra), .r(gr), .rb(grb), .b(gb), .lb(glb));	
	oneLN one (.out(oneLiveNeighbor), .l(gl), .la(gla), .a(ga), .ra(gra), .r(gr), .rb(grb), .b(gb), .lb(glb));
	twoLN two (.out(twoLiveNeighbors), .l(gl), .la(gla), .a(ga), .ra(gra), .r(gr), .rb(grb), .b(gb), .lb(glb));
	threeLN three (.out(threeLiveNeighbors), .l(gl), .la(gla), .a(ga), .ra(gra), .r(gr), .rb(grb), .b(gb), .lb(glb));
	
	enum { gameSetupStayOff, gameSetupStayOn, inGameOn, inGameOff } ps, ns;
	
	always_comb begin
		case (ps)
		
			gameSetupStayOff: if (startGameSwitch)  ns = inGameOff;
									else if (~startGameSwitch & selectingLightConfirmed)  ns = gameSetupStayOn;
									else  ns = ps;
									
			gameSetupStayOn: if (startGameSwitch)  ns = inGameOn;
								  else ns = ps;
								  
			inGameOn: if (zeroLiveNeighbors | oneLiveNeighbor)  ns = inGameOff;
						 else if (twoLiveNeighbors | threeLiveNeighbors)  ns = ps;
						 else  ns = inGameOff;
						 
			inGameOff: if (threeLiveNeighbors)  ns = inGameOn;
						  else ns = ps;
						  
		endcase
	end
	
	
	assign greenLED = ((ps == gameSetupStayOn) | (ps == inGameOn));
	
	
	
	logic six_hundred_sixty_ms; // Period of the slower clock signal we want to create a 1.5 Hz clock enable for
	generateClockEnable clockEnable (.six_hundred_sixty_ms, .clk, .reset);
	
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= gameSetupStayOff;
		else if (six_hundred_sixty_ms)
			ps <= ns;
	end
	
endmodule
			
			
module greenSeedLightFSM_testbench();
	logic gl, gla, ga, gra, gr, grb, gb, glb, selectingLightConfirmed, startGameSwitch, clk, reset;
	logic greenLED;
	
	greenSeedLightFSM dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; gl <= 0; gla <= 0; ga <= 0; gra <= 0; gr <= 0; grb <= 0; gb <= 0; glb <= 0; selectingLightConfirmed <= 0; startGameSwitch <= 0; @(posedge clk);
		startGameSwitch <= 1; @(posedge clk);
		startGameSwitch <= 0; repeat(4) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; gl <= 0; gla <= 0; ga <= 0; gra <= 0; gr <= 0; grb <= 0; gb <= 0; glb <= 0; selectingLightConfirmed <= 0; startGameSwitch <= 0; @(posedge clk);
		selectingLightConfirmed <= 1; @(posedge clk);
		selectingLightConfirmed <= 0; repeat(10) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; gl <= 0; gla <= 0; ga <= 0; gra <= 0; gr <= 0; grb <= 0; gb <= 0; glb <= 0; selectingLightConfirmed <= 0; startGameSwitch <= 0; @(posedge clk);
		selectingLightConfirmed <= 1; @(posedge clk);
		selectingLightConfirmed <= 0; startGameSwitch <= 1; @(posedge clk);
		startGameSwitch <= 0; gl <= 1; gla <= 1; ga <= 1; @(posedge clk);
		ga <= 0; gla <= 0; @(posedge clk);
		ga <= 1; gla <= 1; @(posedge clk);
		gla <= 0; @(posedge clk);
		gla <= 1; @(posedge clk);
		gra <= 1; repeat(4) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; gl <= 0; gla <= 0; ga <= 0; gra <= 0; gr <= 0; grb <= 0; gb <= 0; glb <= 0; selectingLightConfirmed <= 0; startGameSwitch <= 0; @(posedge clk);
	 $stop;
	end
endmodule
		
			
			
			
			
			
