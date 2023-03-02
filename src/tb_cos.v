`timescale 1 ns / 100 ps
module tb_cos ();
	parameter INPUT = 32'h0;
    parameter TIMEOUT_CYCLES = 10000;

	// Inputs to DUT are reg type
	reg [31:0] dataa;
	reg reset;

	// Output from DUT is wire type
	wire [31:0] result;
	
	// clock
	reg clk;
	reg clk_en;
	reg start;
	reg done;

	// Instantiate the DUT
	cos_cordic unit(
			.aclr(reset),
			.clk_en(clk_en),
			.clk(clk),
			.start(start),
			.done(done),
			.dataa(dataa),
			.result(result)
	);

	// Generate clock
    initial begin
        clk=0;

        repeat (TIMEOUT_CYCLES) begin
            clk = ~clk;
            #10;
        end

		$display("Error: simulation did not finish within %d cycles.", TIMEOUT_CYCLES);
        $stop;
    end

	// Initial Block
	initial
	begin
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b1;

		
		@(posedge clk); 

		@(negedge clk);
		clk_en = 1'b1;
		reset = 1'b0;
		dataa <= INPUT;

		while (~done) begin
			@(posedge clk);
		end

		$display("%d", result);
		
		$stop;
	end

endmodule
