`timescale 1 ns / 100 ps
module tb ();
    reg clk;

	//Inputs to DUT are reg type
	reg [31:0] dataa;

	//Output from DUT1 is wire type
	wire [31:0] result1;
    wire [31:0] diff_result1;

    //Output from DUT2 is wire type
    wire [31:0] result2;
    wire [31:0] diff_result2;

	//Instantiate the DUT
	fp_half unit0(
		.dataa(dataa),
        .result(result1)
		);
    
    fp_div_128 unit1(
		.dataa(dataa),
        .result(result2)
		);

	//Create a 50MHz clock
	always
		#10 clk = ~clk;

	reg [31:0] inputs [13];
    reg [31:0] half [13];
    reg [31:0] div128 [13];
	initial begin
        inputs[0] = 32'b00000000000000000000000000000000;
        inputs[1] = 32'b01000001101000000000000000000000;
        inputs[2] = 32'b01000010001000000000000000000000;
        inputs[3] = 32'b01000010011100000000000000000000;
        inputs[4] = 32'b01000010101000000000000000000000;
        inputs[5] = 32'b01000010110010000000000000000000;
        inputs[6] = 32'b01000010111100000000000000000000;
        inputs[7] = 32'b01000011000011000000000000000000;
        inputs[8] = 32'b01000011001000000000000000000000;
        inputs[9] = 32'b01000011001101000000000000000000;
        inputs[10] = 32'b01000011010010000000000000000000;
        inputs[11] = 32'b01000011010111000000000000000000;
        inputs[12] = 32'b01000011011100000000000000000000;

        half[0] = 32'b00000000000000000000000000000000;
        half[1] = 32'b01000001001000000000000000000000;
        half[2] = 32'b01000001101000000000000000000000;
        half[3] = 32'b01000001111100000000000000000000;
        half[4] = 32'b01000010001000000000000000000000;
        half[5] = 32'b01000010010010000000000000000000;
        half[6] = 32'b01000010011100000000000000000000;
        half[7] = 32'b01000010100011000000000000000000;
        half[8] = 32'b01000010101000000000000000000000;
        half[9] = 32'b01000010101101000000000000000000;
        half[10] = 32'b01000010110010000000000000000000;
        half[11] = 32'b01000010110111000000000000000000;
        half[12] = 32'b01000010111100000000000000000000;

        div128[0] = 32'b00000000000000000000000000000000;
        div128[1] = 32'b00111110001000000000000000000000;
        div128[2] = 32'b00111110101000000000000000000000;
        div128[3] = 32'b00111110111100000000000000000000;
        div128[4] = 32'b00111111001000000000000000000000;
        div128[5] = 32'b00111111010010000000000000000000;
        div128[6] = 32'b00111111011100000000000000000000;
        div128[7] = 32'b00111111100011000000000000000000;
        div128[8] = 32'b00111111101000000000000000000000;
        div128[9] = 32'b00111111101101000000000000000000;
        div128[10] = 32'b00111111110010000000000000000000;
        div128[11] = 32'b00111111110111000000000000000000;
        div128[12] = 32'b00111111111100000000000000000000;
	end
	
	initial
	begin
		$dumpfile("fp_half.vcd");  
    	$dumpvars(0,tb);
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		@(negedge clk);

        $display(" << Simulation Half >>");
		for (integer i = 0; i <= 12; i++) begin
			dataa = inputs[i];

			@(negedge clk);
			$display("%d, %h", i, result1);
            $display("%d, %h", i, half[i]);
            
            

		end

		$display($time, " << Simulation Complete >>");
	

		$dumpfile("fp_div_128.vcd");  
    	$dumpvars(0,tb);
		$display($time, " << 128 Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		@(negedge clk);

		for (integer i = 0; i <= 12; i++) begin
			dataa = inputs[i];

			@(negedge clk);
			$display("%d, %h", i, result2);
            $display("%d, %h", i, div128[i]);
            // div128[i] = result2;

		end

		$display($time, " << Simulation Complete >>");
		$stop;
	end

endmodule
