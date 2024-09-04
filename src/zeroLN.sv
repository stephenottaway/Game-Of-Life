module zeroLN (out, l, la, a, ra, r, rb, b, lb);
	input logic l, la, a, ra, r, rb, b, lb;
	output logic out;
	
	assign out = ~l & ~la & ~a & ~ra & ~r & ~rb & ~b & ~lb;

endmodule




module zeroLN_testbench();
	logic l, la, a, ra, r, rb, b, lb, clk;
	logic out;
	
	zeroLN dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		l <= 0; la <= 0; a <= 0; ra <= 0; r <= 0; rb <= 0; b <= 0; lb <= 0; @(posedge clk);  // only condition for out to be one
		l <= 1; @(posedge clk);
		la <= 1; @(posedge clk);
		a <= 1; @(posedge clk);
		ra <= 1; @(posedge clk);
		r <= 1; @(posedge clk);
		rb <= 1; @(posedge clk);
		b <= 1; @(posedge clk);
		lb <= 1; @(posedge clk); // cycling through having one up to all eight inputs true, all of these conditions should result in out being zero
	  $stop;
	end
	
endmodule

