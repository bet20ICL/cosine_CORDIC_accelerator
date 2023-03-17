module test_timing(
	reset,
	clk_en,
	clock,
	start,
	dataa,
	result,
	done
);

	input reset;
	input clk_en;
	input clock;
	input start;
	input [31:0] dataa;
	output [20:0] result;
	output done;
	
//	assign done = 1'b1;
	
	reg  [31:0] dataa_reg;
	wire [31:0] out;
	reg  [31:0] result_reg;
	
//	cordic_ppl_3cyc_ub dut(
//		.aclr(reset),
//		.clk_en(clk_en),
//		.clock(clock),
//		.dataa(dataa_reg),
//		.result(out));

	cordic_ppl_3cyc dut(
		.aclr(reset),
		.clk_en(clk_en),
		.clock(clock),
		.dataa(dataa_reg),
		.result(out));
	
	
	// cordic_unroll1_var cordic_unit(
	//        .aclr(reset),
	//        .clk_en(clk_en),
	//        .clock(clock),
	//        .start(start),
	//        .dataa(dataa_reg),
	//        .result(out),
	//        .done(done)
	// );
		
//	fixed_to_float fixed_to_float_unit( dataa_reg, out );
	// floating_to_fixed(dataa_reg, out);
		
//	always @(posedge clock) begin
//		dataa_reg <= dataa;
//		result_reg <= out;
//	end

	assign result = result_div;

endmodule