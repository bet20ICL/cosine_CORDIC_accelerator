`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg reset;
    reg clk;
	reg clk_en;
	reg start;

	//Output from DUT is wire type
	wire [31:0] result;
	wire done;

	//Instantiate the DUT
	cordic unit(
			.aclr(reset),
			.clk_en(clk_en),
			.clock(clk),
			.start(start),
			.dataa(dataa),
			.result(result),
			.done(done)
		);

	//Create a 50MHz clock
	always
		#10 clk = ~clk;

	initial
	begin
		$dumpfile("cordic_tb_waves_v.vcd");
    	$dumpvars(0,tb);
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b1;
		start = 1'b0;

		@(negedge clk);
		clk_en = 1'b1;
		reset = 1'b0;
		start = 1'b1;

		// dataa = 32'b00000000000000000000000000000000; 	 // in: 0.0 	 out: 1.00000095367431640625 
		// dataa = 32'b00111101110011001100110011001101; 	 // in: 0.1 	 out: 0.99500274658203125000 
		dataa = 32'b00111110010011001100110011001101; 	 // in: 0.2 	 out: 0.98006725311279296875 
		// dataa = 32'b00111110100110011001100110011010; 	 // in: 0.3 	 out: 0.95533657073974609375 
		// dataa = 32'b00111110110011001100110011001101; 	 // in: 0.4 	 out: 0.92105865478515625000 
		// dataa = 32'b00111111000000000000000000000000; 	 // in: 0.5 	 out: 0.87757778167724609375 
		// dataa = 32'b00111111000110011001100110011010; 	 // in: 0.6 	 out: 0.82532501220703125000 
		// dataa = 32'b00111111001100110011001100110011; 	 // in: 0.7 	 out: 0.76482963562011718750 
		// dataa = 32'b00111111010011001100110011001101; 	 // in: 0.8 	 out: 0.69670677185058593750 
		// dataa = 32'b00111111011001100110011001100110; 	 // in: 0.9 	 out: 0.62161064147949218750 
		// dataa = 32'b00111111100000000000000000000000; 	 // in: 1.0 	 out: 0.54029560089111328125 
	
		repeat (20) begin
			@(negedge clk);
			start = 1'b0;
			if (done) $display("Done: %h", result);
		end 
		@(negedge clk);

        $display("Output: %h", result);
		$display($time, " << Simulation Complete >>");

		// TODO: Conversion from fixed-point to floating-point
		// $display("float: %b", dataa);

		$stop;
	end

endmodule
