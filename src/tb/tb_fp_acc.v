`timescale 1 ns / 100 ps
module tb_fp_acc ();

	//Inputs to DUT are reg type
    reg clk;
	reg reset;
	reg [31:0] dataa;
    reg n_reg;
	reg clk_en;

	//Output from DUT is wire type
	wire [31:0] result;
    wire xo_out;
	wire xu_out;
	wire ao_out;

	parameter latency = 8;
   	fp_acc dut(
		.clk(clk),
		.areset(reset),
		.x(dataa),
		.n(n_reg),
		.en(clk_en),
		.r(result),
		.xo(xo_out),
		.xu(xu_out),
		.ao(ao_out)
	);

	//Create a 50MHz clock
	always
		#10 clk = ~clk;

   	parameter num_tests = 4;

	reg [31:0] inputs [11:0];
   	reg [31:0] outputs [11:0];
	initial begin
		inputs[1] = 32'h00000000;  //0.000000 
        inputs[0] = 32'h41c80000;  //25.000000 
        inputs[2] = 32'h42480000;  //50.000000 
        inputs[3] = 32'h42960000;  //75.000000 
        // inputs[4] = 32'h42c80000;  //100.000000 
        // inputs[5] = 32'h42fa0000;  //125.000000 
        // inputs[6] = 32'h43160000;  //150.000000 
        // inputs[7] = 32'h432f0000;  //175.000000 
        // inputs[8] = 32'h43480000;  //200.000000 
        // inputs[9] = 32'h43610000;  //225.000000 
        // inputs[10] = 32'h437a0000; //250.000000 
        // inputs[11] = 32'h437f0000; //255.000000 

        outputs[0] = 32'h00000000; //0.000000 
        outputs[1] = 32'h43deea9d; //445.832916 
        outputs[2] = 32'h4501b0c0; //2075.046875 
        outputs[3] = 32'h45a219d4; //5187.228516 
        outputs[4] = 32'h46194f03; //9811.752930 
        outputs[5] = 32'h46750d13; //15683.268555 
        outputs[6] = 32'h46adc721; //22243.564453 
        outputs[7] = 32'h46dffe6e; //28671.214844 
        outputs[8] = 32'h4704912a; //33937.164062 
        outputs[9] = 32'h471013f6; //36883.960938 
        outputs[10] = 32'h470de056; //36320.335938 
        outputs[11] = 32'h470b667f; //35686.496094
	end 
	
//	outputs[0] = 32'h00000000; //0.000000 
//	outputs[1] = 32'h43a28000; //325.000000 
//	outputs[2] = 32'h449f6000; //1275.000000 
//	outputs[3] = 32'h45322000; //2850.000000 
//	outputs[4] = 32'h459dd000; //5050.000000 
//	outputs[5] = 32'h45f61800; //7875.000000 
//	outputs[6] = 32'h4630f400; //11325.000000 
//	outputs[7] = 32'h4670a000; //15400.000000 
//	outputs[8] = 32'h469d0800; //20100.000000 
//	outputs[9] = 32'h46c6a200; //25425.000000 
//	outputs[10] = 32'h46f51e00; //31375.000000 
//	outputs[11] = 32'h46ff0000; //32640.000000 

	integer i;
	initial
	begin
		// $dumpfile("cordic_tb_waves_v.vcd");
    	// $dumpvars(0,tb);
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		clk = 1'b0;
		clk_en = 1'b0;
		reset = 1'b1;

		@(negedge clk);
		clk_en = 1'b1;
        reset = 1'b0;
        n_reg = 1'b1;
        dataa = inputs[0];

        @(negedge clk);

		for (i = 1; i < num_tests; i = i + 1) begin
            n_reg = 1'b0;
			dataa = inputs[i];
			@(negedge clk);
		end

		repeat (latency-num_tests-2) begin
            dataa = 32'b0;
			@(negedge clk);
		end
		
	   repeat (num_tests+10) begin
			@(negedge clk);
			$display("%h", result);
	   end

		@(negedge clk);

		$display($time, "<< Simulation Complete >>");

		// //TODO: Conversion from fixed-point to floating-point
		// $display("float: %b", dataa);
		$stop;
	end

endmodule

