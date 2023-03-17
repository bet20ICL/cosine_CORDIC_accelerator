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

	//Instantiate the DUT
	// wire [20:0] divide_128;
    wire [20:0] fixed_point_8_13;
    floating_to_fixed_8_13 floating_to_fixed(
        .dataa(dataa),
        .fixed_point_input(fixed_point_8_13)
    );

    fixed_subtract_128 fixed_subtract_128_unit(
        .fixed_point_input_8_13(fixed_point_8_13),
        .divide_128(result)
    );



	//Create a 50MHz clock
	always
		#10 clk = ~clk;

	reg [31:0] inputs [11:0]; 
   reg [20:0] outputs [11:0];
		 //inputs[0] = 32'h3e82fff3;
	initial begin
    inputs[0] = 32'h00000000; //0.000000 
    inputs[1] = 32'h41c80000; //25.000000 
    inputs[2] = 32'h42480000; //50.000000 
    inputs[3] = 32'h42960000; //75.000000 
    inputs[4] = 32'h42c80000; //100.000000 
    inputs[5] = 32'h42fa0000; //125.000000 
    inputs[6] = 32'h43160000; //150.000000 
    inputs[7] = 32'h432f0000; //175.000000 
    inputs[8] = 32'h43480000; //200.000000 
    inputs[9] = 32'h43610000; //225.000000 
    inputs[10] = 32'h437a0000; //250.000000 
    inputs[11] = 32'h437f0000; //255.000000 

    outputs[0] = 21'h000000; 
    outputs[1] = 21'h100000; 
    outputs[2] = 21'h0ce000;
    outputs[3] = 21'h09c000;
    outputs[4] = 21'h06a000; 
    outputs[5] = 21'h038000; 
    outputs[6] = 21'h006000;
    outputs[7] = 21'h02c000; 
    outputs[8] = 21'h05e000; 
    outputs[9] = 21'h090000; 
    outputs[10] = 21'h0c2000; 
    outputs[11] = 21'h0f4000; 
    
	end
	
	integer i;
	
	initial
	begin
		// $dumpfile("inner_function.vcd");  
    	// $dumpvars(0,tb);
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b1;
		start = 1'b0;
		
		@(negedge clk);
        for (i = 0; i <= 10; i = i+1) begin
			dataa = inputs[i];

			@(negedge clk);
			start = 1'b0;
			$display("%d, %h", i, result);
            $display("%d, %h", i, outputs[i]);
            
		end

		$display($time, " << Simulation Complete >>");
		$stop;
	end

endmodule
