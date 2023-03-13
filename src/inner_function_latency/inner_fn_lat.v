module inner_fn_lat(
    aclr,
	clk_en,
	clock,
    start,
	dataa,
	result,
    done
    );
    parameter [31:0] flt_128 = 32'h43000000; 		
    parameter [31:0] flt_recip_128 = 32'h3c000000;		// 1.0/128.0
	parameter [31:0] flt_recip_2 = 32'h3f000000;        // 0.5
    parameter fp_mult_latency = 4;
	parameter fp_add_latency = 8;
	parameter cordic_latency = 17;

	input	        aclr;
	input	        clk_en;
	input	        clock;
   input           start;
   output          done;
	input	   [31:0]  dataa; // this is the floating point input
	output	[31:0]  result;


    //--------------------------------------------------------
    // control
    //--------------------------------------------------------
    parameter total_clk_cycles = fp_mult_latency + fp_add_latency + cordic_latency;
    reg startShifted [total_clk_cycles];

    integer i;
    always @(posedge clock) begin
        startShifted[0] <= start;
        for (i = 0; i < total_clk_cycles-1; i = i + 1) begin
            startShifted[i+1] <= startShifted[i];
        end
    end

    assign done = startShifted[total_clk_cycles-1];


    //--------------------------------------------------------
    // first branch || 0.5*x
    //--------------------------------------------------------
    // 0.5*x
    // combinitorial
    wire [31:0] input_half;
    fp_half fp_half_unit(
        .dataa(dataa),
        .result(input_half)
    );


    //--------------------------------------------------------
    // second branch || cos((x-128)/128)
    //--------------------------------------------------------
    wire [31:0] subtract_128;
    wire [31:0] divide_128;
    // x-128
    // 8 cycles
	 fp_sub_ppl sub_x_128(
		.areset(aclr),
		.en(clk_en),
		.clk(clk),
		.a(dataa),
		.b(flt_128), 
		.q(subtract_128)
	);

    // (x - 128)/128
    // combinitorial
    fp_div_128 fp_div_128_unit(
        .dataa(subtract_128),
        .result(divide_128)
    );

    // cos((x-128)/128) 
    // 17 cycles
    wire startCordic;
    wire cordic_done;
    wire [31:0] cordic_result;

    assign startCordic = startShifted[fp_mult_latency];
    cordic_unroll1_var cordic_unit(
        .aclr(aclr),
        .clk_en(clk_en),
        .clock(clock),
        .start(startCordic),
        .dataa(divide_128),
        .result(cordic_result),
        .done(cordic_done)
    );

    //--------------------------------------------------------
    // third branch   || x^2
    //--------------------------------------------------------
    // x^2 
    // 5 cycles
    wire [31:0] square; 
	 fp_mult_ppl square_unit(
		.areset(aclr),
		.en(clk_en),
		.clk(clock),
		.a(dataa),
		.b(dataa),
		.q(square)
	);


    //--------------------------------------------------------
    // merge            || 0.5*x + x^2 * cos((x-128)/128)
    //--------------------------------------------------------
    // x^2 *  cos((x-128)/128)
    // fp_mult_latency + cordic_latency = 17 + 5;
    wire [31:0] mult_square_cordic;
    fp_mult_ppl fp_mult_custom_unit2(
			.areset(aclr),
			.en(clk_en),
			.clk(clock),
			.a(square),
			.b(cordic_result),
			.q(mult_square_cordic)
    );

    // 0.5*x + x^2 * cos((x-128)/128)
    // fp_mult_latency + cordic_latency + fp_add_latency= 17 + 5 + 11;
    fp_add_ppl fp_addsub_custom_unit2(
			.areset(aclr),
			.en(clk_en),
			.clk(clock),
			.a(input_half),
			.b(mult_square_cordic), 
			.q(result)
    );

endmodule