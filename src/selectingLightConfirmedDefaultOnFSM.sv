module selectingLightConfirmedDefaultOnFSM (selectingLightConfirmed, l, a, r, b, leftButton, rightButton, upButton, downButton, confirmSeedSwitch, startGameSwitch, clk, reset);
	input logic l, a, r, b, leftButton, rightButton, upButton, downButton, confirmSeedSwitch, startGameSwitch, clk, reset;
	output logic selectingLightConfirmed;
	
	// signal for only right, only left, only up, or only down buttonPressed
	logic onlyLeftButtonPressed, onlyRightButtonPressed, onlyDownButtonPressed, onlyUpButtonPressed;
	assign onlyLeftButtonPressed = leftButton & ~rightButton & ~downButton & ~upButton;
	assign onlyRightButtonPressed = ~leftButton & rightButton & ~downButton & ~upButton;
	assign onlyDownButtonPressed = ~leftButton & ~rightButton & downButton & ~upButton;
	assign onlyUpButtonPressed = ~leftButton & ~rightButton & ~downButton & upButton;
	
	logic onlyOneMovementButtonPressed;
	assign onlyOneMovementButtonPressed = onlyLeftButtonPressed | onlyRightButtonPressed | onlyUpButtonPressed | onlyDownButtonPressed;
	
	// conditions for redLED to turn on during game setup
	logic leftButtonRightLED, rightButtonLeftLED, downButtonAboveLED, upButtonBelowLED;
	assign leftButtonRightLED = onlyLeftButtonPressed & r;
	assign rightButtonLeftLED = onlyRightButtonPressed & l;
	assign downButtonAboveLED = onlyDownButtonPressed & a;
	assign upButtonBelowLED = onlyUpButtonPressed & b;
	
	
	enum { gameSetupSelectingOff, gameSetupSelectingOn, confirmedAsSeed, confirmedAsNotSeed } ps, ns;
	
	always_comb begin
		case (ps)
		
			gameSetupSelectingOff: if (startGameSwitch)  ns = confirmedAsNotSeed;
										  else if (~startGameSwitch & (leftButtonRightLED | rightButtonLeftLED | downButtonAboveLED | upButtonBelowLED))   ns = gameSetupSelectingOn;
										  else  ns = ps;
										  
			gameSetupSelectingOn: if (startGameSwitch)  ns = confirmedAsNotSeed;
										 else if (~startGameSwitch & onlyOneMovementButtonPressed)  ns = gameSetupSelectingOff;
										 else if (~startGameSwitch & confirmSeedSwitch)  ns = confirmedAsSeed;
										 else ns = ps;
										 
			confirmedAsSeed: ns = ps;
										 
			confirmedAsNotSeed: ns = ps;
		
		endcase
	end
	
	
	assign selectingLightConfirmed = (ps == confirmedAsSeed);
	
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= gameSetupSelectingOn;
		else
			ps <= ns;
	end
	
endmodule


module selectingLightConfirmedDefaultOnFSM_testbench();
	logic l, a, r, b, leftButton, rightButton, upButton, downButton, confirmSeedSwitch, startGameSwitch, clk, reset;
	logic selectingLightConfirmed;
	
	selectingLightConfirmedFSM dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; confirmSeedSwitch <= 0; startGameSwitch <= 0; @(posedge clk);
		leftButton <= 1; r <= 1; @(posedge clk);
		confirmSeedSwitch <= 1; leftButton <= 0; @(posedge clk);
		confirmSeedSwitch <= 0; leftButton <= 0; r <= 0; l <= 1; rightButton <= 1; repeat(4) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; confirmSeedSwitch <= 0; startGameSwitch <= 0; @(posedge clk);
		leftButton <= 1; r <= 1; @(posedge clk);
		confirmSeedSwitch <= 1; startGameSwitch <= 1; repeat(4) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; confirmSeedSwitch <= 0; startGameSwitch <= 0; @(posedge clk);
		leftButton <= 1; r <= 1; @(posedge clk);
		startGameSwitch <= 1; @(posedge clk);
		r <= 1; leftButton <= 1; repeat(4) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; confirmSeedSwitch <= 0; startGameSwitch <= 0; @(posedge clk);
	  $stop;
	end
endmodule


		
		


