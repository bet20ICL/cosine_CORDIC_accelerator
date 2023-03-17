`timescale 1 ns / 100 ps
module tb_fixed_point_128 ();

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg reset;
   reg clk;
	reg clk_en;
	reg start;

	//Output from DUT is wire type
	wire done;
    wire [31:0] diff_result1;
    wire [20:0] result;

	//Instantiate the DUT
	 test_timing unit (
		.reset(reset),
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

	reg [31:0] inputs [11:0]; 
   reg [20:0] outputs [11:0];
		 //inputs[0] = 32'h3e82fff3;
	initial begin
    // inputs[0] = 32'h00000000; //0.000000 
    // inputs[1] = 32'h41c80000; //25.000000 
    // inputs[2] = 32'h42480000; //50.000000 
    // inputs[3] = 32'h42960000; //75.000000 
    // inputs[4] = 32'h42c80000; //100.000000 
    // inputs[5] = 32'h42fa0000; //125.000000 
    // inputs[6] = 32'h43160000; //150.000000 
    // inputs[7] = 32'h432f0000; //175.000000 
    // inputs[8] = 32'h43480000; //200.000000 
    // inputs[9] = 32'h43610000; //225.000000 
    // inputs[10] = 32'h437a0000; //250.000000 
    // inputs[11] = 32'h437f0000; //255.000000 


	inputs[0] = 32'h00000000; //0.000000 
	inputs[1] = 32'h41c8cccd; //25.100000 
	inputs[2] = 32'h4248cccd; //50.200001 
	inputs[3] = 32'h4296999a; //75.300003 
	inputs[4] = 32'h42c8cccd; //100.400002 
	inputs[5] = 32'h42fb0000; //125.500000 
	inputs[6] = 32'h4316999a; //150.600006 
	inputs[7] = 32'h432fb333; //175.699997 
	inputs[8] = 32'h4348cccd; //200.800003 
	inputs[9] = 32'h4361e666; //225.899994 
	inputs[10] = 32'h437b0000; //251.000000 
	inputs[11] = 32'h437f0000; //255.000000
	
    // outputs[0] = 21'h000000; 
    // outputs[1] = 21'h100000; 
    // outputs[2] = 21'h0ce000;
    // outputs[3] = 21'h09c000;
    // outputs[4] = 21'h06a000; 
    // outputs[5] = 21'h038000; 
    // outputs[6] = 21'h006000;
    // outputs[7] = 21'h02c000; 
    // outputs[8] = 21'h05e000; 
    // outputs[9] = 21'h090000; 
    // outputs[10] = 21'h0c2000; 
    // outputs[11] = 21'h0f4000; 

	outputs[0] = 21'h100000; //1.000000 
	outputs[1] = 21'h0cdccd; //0.803906 
	outputs[2] = 21'h09b99a; //0.607813 
	outputs[3] = 21'h069666; //0.411718 
	outputs[4] = 21'h037333; //0.215625 
	outputs[5] = 21'h005000; //0.019531 
	outputs[6] = 21'h02d333; //0.176562 
	outputs[7] = 21'h05f666; //0.372656 
	outputs[8] = 21'h09199a; //0.568750 
	outputs[9] = 21'h0c3ccd; //0.764844 
	outputs[10] = 21'h0f6000; //0.960938 
	outputs[11] = 21'h0fe000; //0.992188
		
	end
	
	// 0.80546855926513671875
	// 0.80390644073486328125
	integer i;
	
	initial
	begin
		// $dumpfile("inner_function.vcd");  
    	// $dumpvars(0,tb);
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		// reset = 1'b1;
		// start = 1'b0;
		
		@(negedge clk);
        for (i = 0; i <= 10; i = i+1) begin
			dataa = inputs[i];

			@(negedge clk);
			 $display("%d, %b", i, result);
          $display("%d, %b", i, outputs[i]);
            
		end

		$display($time, " << Simulation Complete >>");
		$stop;
	end

endmodule
