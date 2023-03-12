`timescale 1 ns / 100 ps
module tb_fp_add_pipelined ();

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg [31:0] datab; 
	reg add_sub;
	reg reset;

	//Output from DUT is wire type
	wire [31:0] result;
	// wire [63:0] result;

	reg clk;
	reg clk_en;

	//Instantiate the DUT
	//mul refers to the verilog module defined by the LPM_MULT ip
	fp_addsub_custom unit(
		.aclr(reset),
		.add_sub(add_sub),
		.clk_en(clk_en),
		.clock(clk),
		.dataa(dataa),
		.datab(datab), 
		.result(result)
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
		add_sub <= 1'b1;
		// 1 + 4.125 = 4.125
		// expected = 32'h40a40000
		
		// @(posedge clk);
		@(negedge clk);
		dataa <= 32'h42ff8000;
		datab <= 32'h41de0000;
		add_sub <= 1'b0;
		// 127.75 - 27.75 = 100
		// expected = 32'h42c80000
		
		// @(posedge clk);
		@(negedge clk);
		dataa <= 32'h45000000;
		datab <= 32'h45000000;
		add_sub <= 1'b0;
		// 2048 - 2048 = 0
		// expected = 32'h00000000

		@(negedge clk);
		dataa <= 32'h45000000;
		datab <= 32'h45000000;
		add_sub <= 1'b1;
		// 2048 + 2048 = 4096
		// expected = 32'h45800000


		@(negedge clk);

		repeat (14) @(posedge clk);

		reset = 1'b1;

		@(negedge clk);
		
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
