module custom(
    aclr,
	clk_en,
	clk,
	dataa,
    datab,
	result);

    input	  aclr;
	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa; // this is the floating point input
    input	[31:0]  datab; // unused, requried for custom slave interface
	output	[31:0]  result;



endmodule