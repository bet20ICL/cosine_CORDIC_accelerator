module cordic_unroll8_var(
    aclr,
	clk_en,
	clock,
    start,
	dataa,
	result,
    done
    );

    parameter UNROLLS = 8;

	input	        aclr;
	input	        clk_en;
	input	        clock;
    input           start;
	input	[31:0]  dataa; // this is the floating point input
	output	[31:0]  result;
    output          done;

    //-------------------------------------------------------------
    // FP to fixed-point
    //-------------------------------------------------------------
    // ignore the sign of the input as we know cosine is even
    wire [20:0] fixed_point_input;
    floating_to_fixed floating_to_fixed_unit(.dataa(dataa), .fixed_point_input(fixed_point_input));


    //-------------------------------------------------------------
    // CORDIC
    //-------------------------------------------------------------
    reg signed [20:0] x_reg;
    reg signed [20:0] y_reg;
    reg signed [20:0] z_reg;

    wire signed [20:0] x [UNROLLS:0];
    wire signed [20:0] y [UNROLLS:0];
    wire signed [20:0] z [UNROLLS:0];

    assign x[0] = x_reg;
    assign y[0] = y_reg;
    assign z[0] = z_reg;

    reg [4:0] rotate_index_reg;
    reg [3:0] rotate_index [UNROLLS-1:0];
    reg signed [20:0] rotate_angle [UNROLLS-1:0]; // in radian
    
    integer j;
    always @(*) begin
        rotate_index[0] = rotate_index_reg[3:0];
        for (j = 0; j < UNROLLS-1; j = j + 1) begin
            rotate_index[j + 1] = rotate_index[j] + 1'b1;
        end
    end

    assign done = (rotate_index_reg == 5'd16);
    
    genvar i;
    generate
        for (i = 0; i < UNROLLS; i = i + 1) begin: unroll
            cordic_rot cr_0( .x(x[i]), .y(y[i]), .z(z[i]), .rot_x(x[i+1]), .rot_y(y[i+1]), .rot_z(z[i+1]), .rotate_index(rotate_index[i]), .rotate_angle(rotate_angle[i]));
        end
    endgenerate

    always @(*) begin
        case(rotate_index_reg[3])             
            1'd0    : 
            begin 
                rotate_angle[0] = 21'h0c90fe;
                rotate_angle[1] = 21'h076b1a;
                rotate_angle[2] = 21'h03eb6f;
                rotate_angle[3] = 21'h01fd5c;
                rotate_angle[4] = 21'h00ffab;
                rotate_angle[5] = 21'h007ff5;
                rotate_angle[6] = 21'h003fff;
                rotate_angle[7] = 21'h002000;
            end
            1'd1    : 
            begin 
                rotate_angle[0] = 21'h001000;
                rotate_angle[1] = 21'h000800;
                rotate_angle[2] = 21'h000400;
                rotate_angle[3] = 21'h000200;
                rotate_angle[4] = 21'h000100;
                rotate_angle[5] = 21'h000080;
                rotate_angle[6] = 21'h000040;
                rotate_angle[7] = 21'h000020;
            end
            default : 
            begin
                rotate_angle[0] = 21'h0;
                rotate_angle[1] = 21'h0;
                rotate_angle[2] = 21'h0;
                rotate_angle[3] = 21'h0;
                rotate_angle[4] = 21'h0;
                rotate_angle[5] = 21'h0;
                rotate_angle[6] = 21'h0;
                rotate_angle[7] = 21'h0;
            end		
        endcase
    end

    always @(posedge clock) begin
        if (aclr) begin
            rotate_index_reg <= 3'b0;
            x_reg <= 21'b010011011011101001110;
            y_reg <= 21'b0;
            z_reg <= 21'b0;
        end 
        else if (clk_en) begin
            if (start) begin
                rotate_index_reg <= 3'b0;
                x_reg <= 21'b010011011011101001110;
                y_reg <= 21'b0;
                z_reg <= fixed_point_input;
            end
            else begin
                rotate_index_reg <= rotate_index[UNROLLS-1] + 1'b1;
                x_reg <= x[UNROLLS];
                y_reg <= y[UNROLLS];
                z_reg <= z[UNROLLS];
            end
        end
    end
    // always@(*) begin
    //     $display("rotate_index ", rotate_index_reg);
    //     $display("x: ", x_reg);
    //     $display("y: ", y_reg);
    //     $display("z: ", z_reg);
    // end

    //-------------------------------------------------------------
    // Fixed point to floating point
    //-------------------------------------------------------------

    wire [20:0] fixed_point_result;
    wire [31:0] result_fp;

    assign fixed_point_result = x_reg;
    
    fixed_to_float fixed_to_float_unit( fixed_point_result, result_fp );
    
    assign result = result_fp;

endmodule
