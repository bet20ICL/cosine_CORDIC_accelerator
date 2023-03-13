module test_timing(
	clk
);
	input clk;

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg reset;
	reg clk_en;

	//Output from DUT is wire type
	wire [31:0] result;

	
	cordic_pipeline dut(
		.aclr(reset),
		.clk_en(clk_en),
		.clock(clk),
		.dataa(dataa),
		.result(result));
		
	reg [31:0] out;
		
	always @(posedge clk) begin
		reset <= 1'b0;
		clk_en <= 1'b0;
		dataa <= 32'b0;
		out <= result;
	end
		

endmodule