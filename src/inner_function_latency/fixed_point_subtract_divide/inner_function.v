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
    // 31 cycles (x-128)/128 is now combinitorial
    // Assuming fp_add:8 cycles fp_mult:6 cycles 
    // 17+6+8 = 31
    reg startShifted [31];

    integer i;
    always @(posedge clk) begin
        startShifted[0] <= start;
        for (i = 1; i < 31; i = i + 1) begin
            startShifted[i+1] <= startShifted[i];
        end
    end

    assign done = (startShifted[31])? 1'b1 : 1'b0;


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
    // This might be now on the critical path

    
    reg [20:0] subtract_128;
    reg [20:0] divide_128;
    wire signed [21:0] fixed_point_input_9_13;

    floating_to_fixed_9_13 floating_to_fixed_9_13_unit(
        .dataa(dataa),
        .fixed_point_input(fixed_point_input_9_13)
    );

    always@(*) begin 
        if(fixed_point_input_9_13[21]==0) subtract_128 = fixed_point_input_9_13 - 21'sd128; 
        else   subtract_128 = 21'sd128 - fixed_point_input_9_13; 
        divide_128 = subtract_128 >> 7;
    end




    reg startCordic;
    wire cordic_done;
    wire [31:0] cordic_result;

    // start immediately cuz (x-128)/128 are now combinitorial
    assign startCordic = start;

    // this cordic inner_function/fixed_point_subtract_divide/cordic_unroll1_var_fixed_point_input.v
    // directly takes a 21 bit fixed point input
    cordic cordic_fixed_point_input_unit(
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