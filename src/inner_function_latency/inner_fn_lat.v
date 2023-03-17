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
    parameter cordic_latency = 5;
    parameter fp_add_latency = 3;
    parameter fp_mult_latency = 2;

	input	        aclr;
	input	        clk_en;
	input	        clock;
    input           start;
    output          done;
	input	   [31:0]  dataa; // this is the floating point input
	output	[31:0]  result;


    parameter total_clk_cycles = fp_mult_latency*2 + fp_add_latency * 2 + cordic_latency;
    reg startShifted [total_clk_cycles-1:0];
    integer i;


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
	fp_addsub_3cyc sub_x_128(
		.areset(aclr),
		.en(clk_en),
		.clk(clock),
		.a(dataa),
		.b(flt_128), 
		.q(subtract_128),
		.opSel(0) 
	);

    // (x - 128)/128
    // combinitorial
    // fp_div_128 fp_div_128_unit(
    //     .dataa(subtract_128),
    //     .result(divide_128)
    // );

    fp_mult_2cyc fp_div_128_unit(
			.areset(aclr),
			.en(clk_en),
			.clk(clock),
			.a(subtract_128),
			.b(flt_recip_128),
			.q(divide_128)
    );

    // cos((x-128)/128) 
    // 17 cycles
    wire startCordic;
    wire cordic_done;
    wire [31:0] cordic_result;

    assign startCordic = startShifted[fp_add_latency+fp_mult_latency-1];
    cordic_unroll4_var cordic_unit(
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
	  fp_mult_2cyc square_unit(
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
    fp_mult_2cyc fp_mult_custom_unit2(
			.areset(aclr),
			.en(clk_en),
			.clk(clock),
			.a(square),
			.b(cordic_result),
			.q(mult_square_cordic)
    );

    // 0.5*x + x^2 * cos((x-128)/128)
    // fp_mult_latency + cordic_latency + fp_add_latency= 17 + 5 + 11;
    fp_addsub_3cyc fp_addsub_custom_unit2(
		.areset(aclr),
		.en(clk_en),
		.clk(clock),
		.a(input_half),
		.b(mult_square_cordic), 
		.q(result),
		.opSel(1) 
    );





    //--------------------------------------------------------
    // control
    //--------------------------------------------------------
	always @(posedge clock) begin
		if (aclr) begin
             $display("reset %d %h, %h", i, startShifted[i], start);
			for (i = 0; i <  total_clk_cycles; i = i + 1) begin
				startShifted[i] <= 1'd0;
			end
		end
		else if (clk_en) begin
			startShifted[0] <= start;
            for (i = 0; i < total_clk_cycles-1; i = i + 1) begin
                //$display("startShifted[%d] %h, %h", i, startShifted[i], start);
                startShifted[i+1] <= startShifted[i];
            end       
		end
	end

   always@(posedge clock) begin
//         
//			$display("subtract[], %d", startShifted[fp_add_latency-1]);
//         $display("subtract_128 %h, %h", dataa, subtract_128);
//			$display("startShifted[], %d", startShifted[fp_add_latency+fp_mult_latency-1]);
//         $display("div_x_128 %h, %h", subtract_128, divide_128);
//         $display("startCordic %d", startCordic);
//
//         $display("cordic time[%d], %d", fp_add_latency+fp_mult_latency+cordic_latency-1, startShifted[fp_add_latency+fp_mult_latency+cordic_latency-1]);
//         $display("cordic_done %d, %h", cordic_done, cordic_result);

//         $display("startShifted[32], %d", startShifted[32]);
//         $display("startShifted[33], %d", startShifted[33]);
//         $display("mult_square_cordic, %h", mult_square_cordic); //43d8aa4f

    //     $display("startShifted[42], %d", startShifted[42]);
    //     $display("startShifted[43], %d", startShifted[43]);
    //     $display("result, %h", result); //43d8aa4f
    
    end
    
    // TODO: optimization
    assign done = (startShifted[total_clk_cycles-1]);
endmodule