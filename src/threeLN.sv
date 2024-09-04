module threeLN (out, l, la, a, ra, r, rb, b, lb);
	input logic l, la, a, ra, r, rb, b, lb;
	output logic out;
	
	assign out = (l & la & a & ~ra & ~r & ~rb & ~b & ~lb) | (l & la & ~a & ra & ~r & ~rb & ~b & ~lb) | (l & la & ~a & ~ra & r & ~rb & ~b & ~lb) | (l & la & ~a & ~ra & ~r & rb & ~b & ~lb) | (l & la & ~a & ~ra & ~r & ~rb & b & ~lb) | (l & la & ~a & ~ra & ~r & ~rb & ~b & lb) | (l & ~la & a & ra & ~r & ~rb & ~b & ~lb) | (l & ~la & a & ~ra & r & ~rb & ~b & ~lb) | (l & ~la & a & ~ra & ~r & rb & ~b & ~lb) | (l & ~la & a & ~ra & ~r & ~rb & b & ~lb) | (l & ~la & a & ~ra & ~r & ~rb & ~b & lb) | (l & ~la & ~a & ra & r & ~rb & ~b & ~lb) | (l & ~la & ~a & ra & ~r & rb & ~b & ~lb) | (l & ~la & ~a & ra & ~r & ~rb & b & ~lb) | (l & ~la & ~a & ra & ~r & ~rb & ~b & lb) | (l & ~la & ~a & ~ra & r & rb & ~b & ~lb) | (l & ~la & ~a & ~ra & r & ~rb & b & ~lb) | (l & ~la & ~a & ~ra & r & ~rb & ~b & lb) | (l & ~la & ~a & ~ra & ~r & rb & b & ~lb) | (l & ~la & ~a & ~ra & ~r & rb & ~b & lb) | (l & ~la & ~a & ~ra & ~r & ~rb & b & lb) | (~l & la & a & ra & ~r & ~rb & ~b & ~lb) | (~l & la & a & ~ra & r & ~rb & ~b & ~lb) | (~l & la & a & ~ra & ~r & rb & ~b & ~lb) | (~l & la & a & ~ra & ~r & ~rb & b & ~lb) | (~l & la & a & ~ra & ~r & ~rb & ~b & lb) | (~l & la & ~a & ra & r & ~rb & ~b & ~lb) | (~l & la & ~a & ra & ~r & rb & ~b & ~lb) | (~l & la & ~a & ra & ~r & ~rb & b & ~lb) | (~l & la & ~a & ra & ~r & ~rb & ~b & lb) | (~l & la & ~a & ~ra & r & rb & ~b & ~lb) | (~l & la & ~a & ~ra & r & ~rb & b & ~lb) | (~l & la & ~a & ~ra & r & ~rb & ~b & lb) | (~l & la & ~a & ~ra & ~r & rb & b & ~lb) | (~l & la & ~a & ~ra & ~r & rb & ~b & lb) | (~l & la & ~a & ~ra & ~r & ~rb & b & lb) | (~l & ~la & a & ra & r & ~rb & ~b & ~lb) | (~l & ~la & a & ra & ~r & rb & ~b & ~lb) | (~l & ~la & a & ra & ~r & ~rb & b & ~lb) | (~l & ~la & a & ra & ~r & ~rb & ~b & lb) | (~l & ~la & a & ~ra & r & rb & ~b & ~lb) | (~l & ~la & a & ~ra & r & ~rb & b & ~lb) | (~l & ~la & a & ~ra & r & ~rb & ~b & lb) | (~l & ~la & a & ~ra & ~r & rb & b & ~lb) | (~l & ~la & a & ~ra & ~r & rb & ~b & lb) | (~l & ~la & a & ~ra & ~r & ~rb & b & lb) | (~l & ~la & ~a & ra & r & rb & ~b & ~lb) | (~l & ~la & ~a & ra & r & ~rb & b & ~lb) | (~l & ~la & ~a & ra & r & ~rb & ~b & lb) | (~l & ~la & ~a & ra & ~r & rb & b & ~lb) | (~l & ~la & ~a & ra & ~r & rb & ~b & lb) | (~l & ~la & ~a & ra & ~r & ~rb & b & lb) | (~l & ~la & ~a & ~ra & r & rb & b & ~lb) | (~l & ~la & ~a & ~ra & r & rb & ~b & lb) | (~l & ~la & ~a & ~ra & r & ~rb & b & lb) | (~l & ~la & ~a & ~ra & ~r & rb & b & lb);
	
endmodule

module threeLN_testbench();
	logic l, la, a, ra, r, rb, b, lb, clk;
	logic out;
	
	threeLN dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		 l <= 1; la <= 1; a <= 1; ra <= 0; r <= 0; rb <= 0; b <= 0; lb <= 0; @(posedge clk);
		 a <= 0; ra <= 1; @(posedge clk);
		 ra <= 0; r <= 1; @(posedge clk);
		 r <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 l <= 1; a <= 1; ra <= 1; la <= 0; r <= 0; rb <= 0; b <= 0; lb <= 0; @(posedge clk);
		 ra <= 0; r <= 1; @(posedge clk);
		 r <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 lb <= 0; a <= 0; ra <= 1; r <= 1; @(posedge clk);
		 l <= 1; la <= 0; a <= 0; ra <= 1; r <= 0; rb <= 1; b <= 0; lb <= 0; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 ra <= 0; r <= 1; lb <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk); 
		 b <= 0; lb <= 1; @(posedge clk);
		 r <= 0; rb <= 1; lb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 l <= 0; b <= 0; lb <= 0; la <= 1; a <= 1; ra <= 1; @(posedge clk);
		 ra <= 0; r <= 1; @(posedge clk);
		 r <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 a <= 0; ra <= 1; lb <= 0; r <= 1; @(posedge clk);
		 r <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 l <= 0; la <= 1; a <= 0; ra <= 1; r <= 0; rb <= 0; b <= 0; lb <= 1; @(posedge clk);
		 ra <= 0; r <= 1; lb <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 r <= 0; rb <= 1; lb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 la <= 0; a <= 1; b <= 0; ra <= 1; lb <= 0; r <= 1; @(posedge clk);
		 r <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 ra <= 0; r <= 1; lb <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 r <= 0; rb <= 1; lb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 l <= 0; la <= 0; a <= 1; ra <= 0; r <= 0; rb <= 0; b <= 1; lb <= 1; @(posedge clk);
		 a <= 0; ra <= 1; b <= 0; r <= 1; lb <= 0; rb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 r <= 0; rb <= 1; lb <= 0; b <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 ra <= 0; r <= 1; lb <= 0; rb <= 1; @(posedge clk);
		 b <= 0; lb <= 1; @(posedge clk);
		 rb <= 0; b <= 1; @(posedge clk);
		 r <= 0; rb <= 1; @(posedge clk);
	  $stop;
	end
	
endmodule