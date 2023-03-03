// `timescale 1 ns / 100 ps
module tb_cos ();
	parameter INPUT = 32'hFF;
    parameter TIMEOUT_CYCLES = 10000;
	parameter REALNUM = 0.25;


	// Inputs to DUT are reg type
	reg [31:0] dataa;
	reg reset;

	// Output from DUT is wire type
	wire [31:0] result;
	
	// clock
	reg clk;
	reg clk_en;
	reg start;
	wire done;

	// Instantiate the DUT
	cos_cordic unit(
			.aclr(reset),
			.clk_en(clk_en),
			.clk(clk),
			.start(start),
			.dataa(dataa),
			.result(result)
	);

	// reading files
	parameter RAM_INIT_FILE = "test/input/random_numbers_binary.txt";

	reg [31:0] memory [4095:0];

    initial begin
        integer i;
        /* Initialise to zero by default */
        for (i=0; i<4096; i++) begin
            memory[i]=0;
        end
        /* Load contents from file if specified */
        if (RAM_INIT_FILE != "") begin
            $display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);
            $readmemb(RAM_INIT_FILE, memory);
			$display("memory[0]: ", memory[0]);
        end
    end


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

	real sr;
	reg [31:0] srbits;

	// Initial Block
	initial
	begin
		sr = REALNUM; 
		srbits = $realtobits(10);
		$display("input: ", INPUT);
		$display("real: %f", sr);
		$display("bits: ", srbits);

		// intialise/set input
		clk_en = 1'b0;
		reset = 1'b1;
		start = 1'b0;

		
		@(posedge clk); 

		@(negedge clk);
		clk_en = 1'b1;
		reset = 1'b0;
		start = 1'b1;
		dataa <= INPUT;

		while (~done) begin
			@(posedge clk);
		end

		$display("%d", result);
		
		$stop;
	end

endmodule
