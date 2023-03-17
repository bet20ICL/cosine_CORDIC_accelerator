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


	 wire [27:0] fixed_point_8_13;
	 wire [20:0] result_div; 
	 floating_to_fixed_8_13 floating_to_fixed(
        .dataa(dataa),
        .fixed_point_input(fixed_point_8_13)
    );


    fixed_subtract_128 fixed_subtract_128_unit(
        .fixed_point_input_8_13(fixed_point_8_13),
        .divide_128(result_div)
    );

	// always@(fixed_point_8_13) begin
	// 	$display("dataa            %b", dataa);
	// 	$display("fixed_point_8_13 %b", fixed_point_8_13);
	// 	//$display("result_div       %h", result_div);
        
	// end
	
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