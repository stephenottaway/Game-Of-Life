module buttonPressFSM (out, buttonPressed, clk, reset);
	input logic buttonPressed, clk, reset;
	output logic out;
	
	enum { unpressed, pressed } ps, ns;
	
	always_comb begin
		case (ps)
		
			unpressed: if (buttonPressed) ns = pressed;
						  else ns = ps;
			
			pressed: if (~buttonPressed) ns = unpressed;
						else ns = ps;
		
		endcase
	end
	
	assign out = ((ps == pressed) & (ns == unpressed));
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= unpressed;
		else
			ps <= ns;
	end

endmodule


module buttonPressFSM_testbench();
	logic buttonPressed, clk, reset;
	logic out;
	
	buttonPressFSM dut (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk); // reset FSM
		reset <= 0; buttonPressed <= 0; repeat(2) @(posedge clk); // button is unpressed for two clock cycles
		buttonPressed <= 1; repeat(4) @(posedge clk); // button is pressed for four clock cycles, simulating it being held down for a long time
		buttonPressed <= 0; repeat(2) @(posedge clk); // button is unpressed after being pressed, output should become one (for only one clock cycle)
		reset <= 1; repeat(2) @(posedge clk); // reset FSM
	 $stop;
	end
endmodule

