`timescale 1 ns / 100 ps
module tb_cordic_rd_file ();
	parameter RAM_INIT_FILE = "../test/input/small_inputs.txt";
	parameter OUT_FILE = "../test/output/outputs1.txt";
	parameter num_samples = 5000;

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
	cordic_unroll1_var unit(
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

    reg [31:0] file_in [num_samples-1:0];

    integer fd;
	integer fd_out;
	
	integer i;
	initial
	begin
		// $dumpfile("cordic_tb_waves_v.vcd");
    	// $dumpvars(0,tb_cordic_rd_file);
		// $display($time, " << Starting Simulation >> ");
		fd_out = $fopen(OUT_FILE, "w");

		if (RAM_INIT_FILE != "") begin
            // $display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);
            $readmemh(RAM_INIT_FILE, file_in, 0, num_samples-1);
        end
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b1;
		start = 1'b0;
		@(negedge clk);

		
		for (i = 0; i <= num_samples-1; i = i + 1) begin
			clk_en = 1'b1;
			reset = 1'b0;
			start = 1'b1;
			dataa = file_in[i];
			$display("RAM : INFO : addr = %h, mem=%h", i, file_in[i]);

			@(negedge clk);
			start = 1'b0;
			while (done == 1'b0) begin
				@(negedge clk);
			end

			$display("%d, %h", i, result);
			$fdisplay(fd_out, "%0h", result);
		end	

		// $display($time, " << Simulation Complete >>");

		// TODO: Conversion from fixed-point to floating-point
		// $display("float: %b", dataa);
		$fclose(fd_out);
		$stop;
	end

endmodule
