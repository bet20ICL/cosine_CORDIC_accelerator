module test_timing_fp_acc(
	reset,
	clk_en,
	clock,
	dataa,
	n,
	result,
	xo,
	xu,
	ao
);

	input reset;
	input clk_en;
	input clock;
	input [31:0] dataa;
	input n;
	output [31:0] result;
	output xo;
	output xu;
	output ao;
	
	reg [31:0] dataa_reg;
	reg n_reg;

	reg [31:0] result_reg;
	reg xo_reg;
	reg xu_reg;
	reg ao_reg;

	wire [31:0] out;
	wire xo_out;
	wire xu_out;
	wire ao_out;

	fp_acc_target fp_acc(
		.clk(clock),
		.areset(reset),
		.x(dataa_reg),
		.n(n_reg),
		.en(clk_en),
		.r(out),
		.xo(xo_out),
		.xu(xu_out),
		.ao(ao_out)
	);
		
	// fixed_to_float fixed_to_float_unit( dataa_reg, out );
		
	always @(posedge clock) begin
		dataa_reg <= dataa;
		n_reg <= n;
		result_reg <= out;
		xo_reg <= xo_out;
		xu_reg <= xu_out;
		ao_reg <= ao_out;
	end
	assign result = result_reg;
	assign xo = xo_reg;
	assign xu = xu_reg;
	assign ao = ao_reg;

endmodule