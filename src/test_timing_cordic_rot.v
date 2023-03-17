module test_timing_cordic_rot(
	reset,
	clk_en,
	clock,
	start,
	dataa,
	x,
	y,
	z,
	nx,
	ny,
	nz,
	result,
	done
);

	input reset;
	input clk_en;
	input clock;
	input start;
	input [31:0] dataa;
	input [20:0] x;
	input [20:0] y;
	input [20:0] z;
	output [31:0] result;

	output reg [20:0] nx;
	output reg [20:0] ny;
	output reg [20:0] nz;
	
	output done;
	assign done = 1'b1;
	
	reg [31:0] dataa_reg;
	wire [31:0] out;
	reg [31:0] result_reg;

	reg [20:0] x_reg;
	reg [20:0] y_reg;
	reg [20:0] z_reg;

	wire [20:0] x_out;
	wire [20:0] y_out;
	wire [20:0] z_out; 
	
	cordic_rot_param #(.rotate_index(4'd14), .rotate_angle(21'h000040)) rotation14 ( x_reg, y_reg, z_reg, x_out, y_out, z_out); 
		
	// fixed_to_float fixed_to_float_unit( dataa_reg, out );
	floating_to_fixed(dataa_reg, out);
		
	always @(posedge clock) begin
		dataa_reg <= dataa;
		result_reg <= out;
		x_reg <= x;
		y_reg <= y;
		z_reg <= z;
		nx <= x_out;
		ny <= y_out;
		nz <= z_out;
	end
	assign result = result_reg;

endmodule