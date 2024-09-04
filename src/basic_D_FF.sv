module basic_D_FF (q, d, clk);
	output logic q;
	input logic d, clk;
	
	always_ff @(posedge clk) begin
		q <= d;
	end
endmodule

