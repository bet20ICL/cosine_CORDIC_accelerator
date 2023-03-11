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
	cordic_pipeline unit(
			.aclr(reset),
			.clk_en(clk_en),
			.clock(clk),
			.dataa(dataa),
			.result(result)
		);
	
	//Create a 50MHz clock
	always
		#10 clk = ~clk;

	reg [31:0] inputs [10:0];
	initial begin
		inputs[0] = 32'b00000000000000000000000000000000; 	 // in: 0.0 	 out: 1.00000095367431640625 
		inputs[1] = 32'b00111101110011001100110011001101; 	 // in: 0.1 	 out: 0.99500274658203125000 
		inputs[2] = 32'b00111110010011001100110011001101; 	 // in: 0.2 	 out: 0.98006725311279296875 
		inputs[3] = 32'b00111110100110011001100110011010; 	 // in: 0.3 	 out: 0.95533657073974609375 
		inputs[4] = 32'b00111110110011001100110011001101; 	 // in: 0.4 	 out: 0.92105865478515625000 
		inputs[5] = 32'b00111111000000000000000000000000; 	 // in: 0.5 	 out: 0.87757778167724609375 
		inputs[6] = 32'b00111111000110011001100110011010; 	 // in: 0.6 	 out: 0.82532501220703125000 
		inputs[7] = 32'b00111111001100110011001100110011; 	 // in: 0.7 	 out: 0.76482963562011718750 
		inputs[8] = 32'b00111111010011001100110011001101; 	 // in: 0.8 	 out: 0.69670677185058593750 
		inputs[9] = 32'b00111111011001100110011001100110; 	 // in: 0.9 	 out: 0.62161064147949218750 
		inputs[10] = 32'b00111111100000000000000000000000; 	 // in: 1.0 	 out: 0.54029560089111328125 
	end

	integer i;

	initial
	begin
		$dumpfile("cordic_tb_waves_v.vcd");
    	$dumpvars(0,tb);
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b1;

		@(negedge clk);
		
		for (i = 0; i <= 10; i=i+1) begin
			clk_en = 1'b1;
			reset = 1'b0;
			dataa = {1'b1, inputs[i][30:0]};
			// dataa = inputs[i];
			@(negedge clk);
		end

        repeat (20) begin
            @(negedge clk);
		    $display("%h", result);
        end

		@(negedge clk);

		$display($time, "<< Simulation Complete >>");

		// // //TODO: Conversion from fixed-point to floating-point
		// // $display("float: %b", dataa);
		$stop;
	end

endmodule

