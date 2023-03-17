module full_fn_fake_ppl(
    reset,
	 clk_en,
	 clock,
    start,
	 dataa,
    datab,
	 result,
    done
    );

	input	        reset;
	input	        clk_en;
	input	        clock;
    input           start;
	input	[31:0]  dataa; // this is the floating point input
    input   [31:0]  datab; // used to signal accumulate start
	output	[31:0]  result;
    output          done;

    parameter inner_fn_latency = 43;
    parameter fp_acc_latency = 8;

    parameter inner_buffer_len = inner_fn_latency;
    reg inner_fn_buffer [inner_buffer_len-1:0];
    
    wire [31:0] inner_result;
    inner_fn_ppl_fp_func unit0(
        .aclr(reset),
        .clk_en(clk_en),
        .clk(clock),
        .dataa(dataa),
        .result(inner_result)
    );
   
    wire xo_out;
	wire xu_out;
	wire ao_out;
    fp_acc unit1(
		.clk(clock),
		.areset(reset),
		.x(inner_result),
		.n(inner_fn_buffer[inner_buffer_len-1]),
		.en(clk_en),
		.r(result),
		.xo(xo_out),
		.xu(xu_out),
		.ao(ao_out)
	);

    reg done_reg;
    assign done = done_reg;

    integer i;
    always @(posedge clock) begin
        if (reset) begin

            done_reg <= 1'b0;

            for (i = 0; i < inner_buffer_len; i = i + 1) begin
                inner_fn_buffer[i] <= 1'b0;
            end

        end
        else begin
            if (start & clk_en) begin

                done_reg <= 1'b1;

                inner_fn_buffer[0] <= datab[0];
                for (i = 1; i < inner_buffer_len; i = i + 1) begin
                    inner_fn_buffer[i] <= inner_fn_buffer[i-1];
                end

            end
        end
    end

endmodule