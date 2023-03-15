module test_timing(
	reset,
	clk_en,
	clock,
	start,
	result,
	dataa,
	done
);

	input reset;
   input clk_en;
   input clock;
   input start;
   input [31:0] dataa;
   output [31:0] result;
   output done;
		  


	//Inputs to DUT are reg type

	//Output from DUT is wire type
	wire done;
	wire [31:0] result;

	
	// cordic_pipeline dut(
	// 	.aclr(reset),
	// 	.clk_en(clk_en),
	// 	.clock(clk),
	// 	.dataa(dataa),
	// 	.result(result));
	
	reg [31:0] dataa_reg;
	wire [31:0] out;
	
	reg [31:0] result_intermediate;
//	cordic_unroll1_var cordic_unit(
//        .aclr(reset),
//        .clk_en(clk_en),
//        .clock(clock),
//        .start(start),
//        .dataa(dataa_reg),
//        .result(out),
//        .done(done)
//    );
		
	fixed_to_float fixed_to_float_unit( dataa_reg, out );
		
	always @(posedge clock) begin
		dataa_reg <= dataa;
		result_intermediate <= out;
	end
	assign result = result_intermediate;
		

endmodule