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
	wire [4:0] rotate_index_debug;
	wire [31:0] x_debug;
	wire [31:0] z_debug;
	wire [31:0] fixed_point_input_debug;
	wire [7:0] exponent_debug;
	wire [31:0] fixed_point_result_debug;

    shortreal x;
    shortreal f_x;
	//Instantiate the DUT
	math_expression math_expression_1(
    .x(x),
    .clk(clk),
    .clk_en(clk_en),
    .reset(reset),
    .f_x(f_x)
    );
	

	//Create a 50MHz clock
	always
		#10 clk = ~clk;

	initial
	begin
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b1;

		x = 32'h42f19999;
		dataa = 32'b00111111011001100110011001100110; // 0.9   => 00111111000111101110011111110001 0.620726644993

		@(posedge clk); 
		@(negedge clk);
		reset = 1'b0;
		clk_en = 1'b1;
	
		repeat (16) @(posedge clk);

		@(negedge clk);

		$display($time, "<< Simulation Complete >>");

		$display("x: %b", $shortrealtobits(x));
		$display("f_x: ", f_x);

		


		$stop;
	end

endmodule
