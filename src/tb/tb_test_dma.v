`timescale 1 ns / 100 ps
module tb_test_dma ();

	//Inputs to DUT are reg type
    reg clk;
	reg reset;
	// reg clk_en;
	reg read;
	reg write;
	reg [1:0] address;
	reg [31:0] writedata;


	//Output from DUT is wire type
	wire [31:0] readdata;

	//Instantiate the DUT
	full_fn_msgdma unit(
			.clk(clk),
			.aclr(reset),
			.read(read),
			.write(write),
			.address(address),
			.readdata(readdata),
			.writedata(writedata)
		);
	
	//Create a 50MHz clock
	always
		#10 clk = ~clk;

	integer i;

	initial
	begin
		$dumpfile("tb_test_dma.vcd");
    	$dumpvars(0,tb_test_dma);
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		// clk_en = 1'b0;
		reset = 1'b1;

		@(negedge clk);
        $display("%h", readdata);

        reset = 1'b0;
		address = 2'b10;
		read = 1'b1;
		write = 1'b0;
        //-------------------

        @(negedge clk);
        $display("%h", readdata);

        reset = 1'b0;
		address = 2'b11;
		read = 1'b1;
		write = 1'b0;
        //-------------------

        @(negedge clk);
        $display("%h", readdata);

        reset = 1'b0;
		address = 2'b0;
		read = 1'b0;
		write = 1'b1;
		writedata = 32'haaaabbbb;
        //-------------------
		
		@(negedge clk);
        $display("%h", readdata);

		reset = 1'b0;
		address = 2'b0;
		read = 1'b1;
		write = 1'b0;
        //-------------------
		
		@(negedge clk);
        $display("%h", readdata);

		$display($time, "<< Simulation Complete >>");

		$stop;
	end

endmodule

