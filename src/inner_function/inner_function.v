module inner_function(
    aclr,
	clk_en,
	clock,
    start,
	dataa,
	result,
    done
    );

	input	        aclr;
	input	        clk_en;
	input	        clock;
    input           start;
	input	[31:0]  dataa; // this is the floating point input
	output	[31:0]  result;
    output          done;


    //--------------------------------------------------------
    // control
    //--------------------------------------------------------
    reg startShifted [38];

    integer i;
    always @(posedge clk) begin
        startShifted[0] <= start;
        for (i = 1; i < 38; i = i + 1) begin
            startShifted[i+1] <= startShifted[i];
        end
    end

    assign done = (startShifted[38])? 1'b1 : 1'b0;


    //--------------------------------------------------------
    // first branch 
    //--------------------------------------------------------
    wire [31:0] input_half;
    fp_half fp_half_unit(
        .dataa(dataa),
        .result(input_half)
    );


    //--------------------------------------------------------
    // second branch
    //--------------------------------------------------------
    wire [31:0] subtract_128;
    wire [31:0] divide_128;
    // 7 cycles
    fp_addsub_custom fp_addsub_custom_unit(
        .aclr(aclr),
        .add_sub(0),
        .clk_en(clk_en),
        .clock(clock),
        .dataa(dataa),
        .datab(32'b01000011000000000000000000000000),
        .result(subtract_128)
    );

    fp_div_128 fp_div_128_unit(
        .dataa(subtract_128),
        .result(divide_128)
    );

    // cordic input
    reg startCordic;
    // cordic output 
    wire cordic_done;
    wire [31:0] cordic_result;

    assign startCordic = startShifted[7];
    cordic cordic_unit(
        .aclr(aclr),
        .clk_en(clk_en),
        .clock(clock),
        .start(startCordic),
        .dataa(divide_128),
        .result(cordic_result),
        .done(cordic_done)
    );

    //--------------------------------------------------------
    // third branch
    //--------------------------------------------------------
    wire [31:0] square; 
    fp_mult_custom fp_mult_custom_unit(
        .aclr(aclr),
        .clk_en(clk_en),
        .clock(clock),
        .dataa(dataa),
        .datab(dataa),
        .result(square)
    );


    //--------------------------------------------------------
    // merge 
    //--------------------------------------------------------
    wire [31:0] mult_square_cordic;
    fp_mult_custom fp_mult_custom_unit2(
        .aclr(aclr),
        .clk_en(clk_en),
        .clock(clock),
        .dataa(square),
        .datab(cordic_result),
        .result(mult_square_cordic)
    );

    fp_addsub_custom fp_addsub_custom_unit2(
        .aclr(aclr),
        .add_sub(0),
        .clk_en(clk_en),
        .clock(clock),
        .dataa(input_half),
        .datab(mult_square_cordic),
        .result(result)
    );

endmodule