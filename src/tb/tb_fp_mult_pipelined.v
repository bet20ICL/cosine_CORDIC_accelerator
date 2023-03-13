`timescale 1 ns / 100 ps
module tb_fp_mult_pipelined ();

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg [31:0] datab; 
	reg reset;

	//Output from DUT is wire type
	wire [31:0] result;
	// wire [63:0] result;

	reg clk;
	reg clk_en;

	//Instantiate the DUT
	fp_mult_ppl unit (
		.clk    (clk),    //    clk.clk
		.areset (reset), // areset.reset
		.en     (clk_en),     //     en.en
		.a      (dataa),      //      a.a
		.b      (datab),      //      b.b
		.q      (result)       //      q.q
	);

	// ---- If a clock is required, see below ----
	//Create a 50MHz clock
	always
		#10 clk = ~clk;
	// -----------------------

	//Initial Block
	initial
	begin
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b0;
		
		// If using a clock
		@(posedge clk); 
		
		// // Wait 10 cycles (corresponds to timescale at the top) 
		// #10

		@(negedge clk);
		clk_en = 1'b1;
		
		// set dataa and datab
		dataa <= 32'h3f800000;
		datab <= 32'h40840000;
		// 1 * 4.125 = 4.125
		// expected = 32'h40840000
		
		// @(posedge clk);
		@(negedge clk);
		dataa <= 32'h42ff8000;
		datab <= 32'h41de0000;
		// 127.75 * 27.75 = 3545.0625
		// expected = 32'h455d9100
		
		// @(posedge clk);
		@(negedge clk);
		dataa <= 32'h45000000;
		datab <= 32'h45000000;	
		// 2048 * 2048 = 4194304
		// expected = 32'h4a800000

		@(negedge clk);

		repeat (14) @(posedge clk);

		reset = 1'b1;

		@(negedge clk);
		
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
