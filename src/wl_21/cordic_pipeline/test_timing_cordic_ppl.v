module test_timing_cordic_ppl(
	reset,
	clk_en,
	clock,
	dataa,
	result
);

	input reset;
	input clk_en;
	input clock;
	input [31:0] dataa;
	output [31:0] result;
	
	reg [31:0] dataa_reg;
	reg [31:0] result_reg;
	wire [31:0] out;

	cordic_pipeline unit(
		.aclr(reset),
		.clk_en(clk_en),
		.clock(clock),
		.dataa(dataa_reg),
		.result(out)
	);
		
	// fixed_to_float fixed_to_float_unit( dataa_reg, out );
		
	always @(posedge clock) begin
		dataa_reg <= dataa;
		result_reg <= out;
	end
	assign result = result_reg;
		

endmodule