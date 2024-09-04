module generateClockEnable (six_hundred_sixty_ms, clk, reset); // generate a 1.5 Hz clock enable from the 1526 Hz main clock, gating logic that must run every 660 ms
	input logic clk, reset;
	output logic six_hundred_sixty_ms;
	
	logic [9:0] counter; // counter to increment, 10 bits since 1526/1.5 = 1017 and 2^10 = 1024
	
	
	always_ff @(posedge clk) begin
		if (reset) begin
			counter <= 10'b0000000000;
			six_hundred_sixty_ms <= 1'b0;
		end else if (counter == 10'b1111111111) begin
			six_hundred_sixty_ms <= 1'b1;
			counter <= 10'b0000000000;
		end else
			six_hundred_sixty_ms <= 1'b0;
			counter <= counter + 1'b1;
	end

endmodule	
	
	
	
	
	