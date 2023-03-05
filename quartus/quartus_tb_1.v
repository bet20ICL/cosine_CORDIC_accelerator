`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg reset;

	//Output from DUT is wire type
	wire [31:0] result;

	reg clk;
	reg clk_en;

	// debug siganl
	wire [3:0] rotate_index_debug;
	wire [31:0] x_debug;
	wire [31:0] z_debug;
	wire [31:0] fixed_point_input_debug;
	wire [7:0] exponent_debug;
	wire [31:0] fixed_point_result_debug;

	//Instantiate the DUT
	cordic unit(		
			.aclr(reset),
			.clk_en(clk_en),
			.clock(clk),
			.dataa(dataa),
			.result(result),
			.rotate_index_debug(rotate_index_debug),
			.x_debug(x_debug),
			.z_debug(z_debug),
			.fixed_point_input_debug(fixed_point_input_debug),
			.exponent_debug(exponent_debug),
			.fixed_point_result_debug(fixed_point_result_debug)
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
		reset = 1'b1;
		dataa = 32'b00111111000001100110101100101101;
		// 01000011001101011001011010000000

		@(posedge clk); 
		
		@(negedge clk);
		reset = 1'b0;
		clk_en = 1'b1;
		
		// set dataa and datab
		// input = 0.5250729021869458
		// 		 = 01001101101110100111011011010100

		// expected = 0.8652873997993262
		// expected = 0110 1110 1100 0001 1011 1100 1100 1101 (fixed-point output)
		
		
		repeat (10) @(posedge clk);
		$display("result 01101110110000011011110011001101");
		$display("result %b: ", result);

		@(negedge clk);
		$display("result 01101110110000011011110011001101");
		$display("result %b: ", result);
		
		$display($time, "<< Simulation Complete >>");
		$display("exponent: ", exponent_debug);
		$display("fixed: %b", fixed_point_input_debug);
		$display("float: %b", dataa);


		$stop;
	end

endmodule
