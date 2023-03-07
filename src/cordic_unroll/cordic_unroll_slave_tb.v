`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg reset;
    reg clk;
	reg clk_en;

	//Output from DUT is wire type
	wire [31:0] result;

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

	initial
	begin
		$dumpfile("cordic_tb_waves.vcd");
    	$dumpvars(0,tb);
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b1;

		// dataa = 32'b00111111000001100110101100101101;
		// dataa = 32'b0; 							     // 0  	  => 00111111010101111111101101000101 0.999998629093
		// dataa = 32'b00111101110011001100110011001101; // 0.1   => 00111111011111101010110111101110 0.994841456413
		// dataa = 32'b00111110010011001100110011001101; // 0.2   => 00111111011110101110111101101111 0.980215966702
		// dataa = 32'b00111110100110011001100110011010; // 0.3   => 00111111011101001000010001101001 0.955145418644
		// dataa = 32'b00111110110011001100110011001101; // 0.4   => 00111111011010111010011000001010 0.920502245426
		// dataa = 32'b00111111000000000000000000000000; // 0.5   => 00111111011000001100101001101001 0.878088533878
		// dataa = 32'b00111111000110011001100110011010; // 0.6   => 00111111010100110110000000101110 0.825686335564
		dataa = 32'b00111111001100110011001100110011; // 0.7   => 00111111010000111010101110110101 0.76433879137
		// dataa = 32'b00111111010011001100110011001101; // 0.8   => 00111111001100100110100001001110 0.696904063225
		// dataa = 32'b00111111011001100110011001100110; // 0.9   => 00111111000111101110011111110001 0.620726644993
		// dataa = 32'b00111111100000000000000000000000; // 1     => 00111111111001000100010101011011 0.541345000267

		@(posedge clk); 
		@(negedge clk);
		reset = 1'b0;
		clk_en = 1'b1;
	
		repeat (16) begin
			@(negedge clk);
		end 
		@(negedge clk);

        $display("Output: %b", result);
		$display($time, " << Simulation Complete >>");

		// TODO: Conversion from fixed-point to floating-point
		// $display("float: %b", dataa);

		$stop;
	end

endmodule
