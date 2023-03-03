`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg reset;

	//Output from DUT is wire type
	wire [31:0] result;

	reg clk;
	reg clk_en;

	//Instantiate the DUT
	cordic unit(
			.aclr(reset),
			.clk_en(clk_en),
			.clock(clk),
			.dataa(dataa),
			.result(result)
	);

	//Create a 50MHz clock
	always
		#10 clk = ~clk;

	//Initial Block
	initial
	begin
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b0;
		add_sub = 1'b0;
		
		@(posedge clk); 
		

		@(negedge clk);
		clk_en = 1'b1;
		
		// set dataa and datab
		dataa <= 32'b0011 1111 0000 0110 0110 1011 0010 1101;
		// input = 0.5250729021869458
		// expected = 0.8652873997993262
		// expected = 01101110110000011011110011001101 (fixed-point output)
		
		repeat (14) @(posedge clk);

		reset = 1'b1;

		@(negedge clk);
		
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
