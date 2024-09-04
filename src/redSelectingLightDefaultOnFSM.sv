module redSelectingLightDefaultOnFSM (redLED, l, a, r, b, leftButton, rightButton, upButton, downButton, startGameSwitch, clk, reset);
	input logic l, a, r, b, leftButton, rightButton, upButton, downButton, startGameSwitch, clk, reset;
	output logic redLED;
	
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
	
	
	enum { gameSetupSelectingOff, gameSetupSelectingOn, inGameOff } ps, ns;
	
	always_comb begin
		case (ps)
		
			gameSetupSelectingOff: if (startGameSwitch)  ns = inGameOff;
										  else if ((~startGameSwitch & ((leftButtonRightLED) | (rightButtonLeftLED) | (downButtonAboveLED) | (upButtonBelowLED))))   ns = gameSetupSelectingOn;
										  else  ns = ps;
										  
			gameSetupSelectingOn: if (startGameSwitch)  ns = inGameOff;
										 else if (~startGameSwitch & onlyOneMovementButtonPressed)  ns = gameSetupSelectingOff;
										 else ns = ps;
										 
			inGameOff: ns = ps;
			
		endcase
	end
	
	
	assign redLED = (ps == gameSetupSelectingOn);
	
	
	always_ff @(posedge clk) begin
		if (reset) 
			ps <= gameSetupSelectingOn;
		else
			ps <= ns;
	end
	
endmodule


module redSelectingDefaultOnLightFSM_testbench();
	logic l, a, r, b, leftButton, rightButton, upButton, downButton, startGameSwitch, clk, reset;
	logic redLED;
	
	redSelectingLightFSM dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		startGameSwitch <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		leftButton <= 1; r <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		rightButton <= 1; l <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		downButton <= 1; a <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		upButton <= 1; b <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		upButton <= 1; b <= 1; @(posedge clk);
		upButton <= 0; rightButton <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		leftButton <= 1; r <= 1; @(posedge clk);
		leftButton <= 0; upButton <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		rightButton <= 1; l <= 1; @(posedge clk);
		rightButton <= 0; leftButton <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		rightButton <= 1; l <= 1; @(posedge clk);
		rightButton <= 0; downButton <= 1; @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
		rightButton <= 1; l <= 1; @(posedge clk);
		rightButton <= 0; repeat(4) @(posedge clk);
		startGameSwitch <= 1; @(posedge clk);
		startGameSwitch <= 0; @(posedge clk);
		leftButton <= 1; repeat(4) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; l <= 0; a <= 0; r <= 0; b <= 0; leftButton <= 0; rightButton <= 0; upButton <= 0; downButton <= 0; startGameSwitch <= 0; @(posedge clk);
	  $stop;
	end
endmodule


										  
