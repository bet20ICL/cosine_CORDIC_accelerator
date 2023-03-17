module cordic_ppl_1cyc(
    aclr,
	clk_en,
	clock,
	dataa,
	result);

	input	  aclr;
	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa; // this is the floating point input
	output	[31:0]  result;

    //-------------------------------------FP to fixed-point------------------------
    wire [20:0] fixed_point_input;
    floating_to_fixed floating_to_fixed_unit(.dataa(dataa), .fixed_point_input(fixed_point_input));


    //-------------------------------------cordic------------------------------------
    reg signed [20:0] x_reg;
    reg signed [20:0] y_reg;
    reg signed [20:0] z_reg;
	// reg [20:0] fixed_point_result;

    wire signed [20:0] x0_out,x1_out,x2_out,x3_out,x4_out,x5_out,x6_out,x7_out,x8_out,x9_out,x10_out,x11_out,x12_out,x13_out,x14_out,x15_out;
    wire signed [20:0] y0_out,y1_out,y2_out,y3_out,y4_out,y5_out,y6_out,y7_out,y8_out,y9_out,y10_out,y11_out,y12_out,y13_out,y14_out,y15_out;
    wire signed [20:0] z0_out,z1_out,z2_out,z3_out,z4_out,z5_out,z6_out,z7_out,z8_out,z9_out,z10_out,z11_out,z12_out,z13_out,z14_out,z15_out;

    cordic_rot_param #(.rotate_index(4'd0), .rotate_angle(21'h0c90fe)) rotation0 ( 21'b010011011011101001110, 21'b0, fixed_point_input, x0_out, y0_out, z0_out); // s1 start
    cordic_rot_param #(.rotate_index(4'd1), .rotate_angle(21'h076b1a)) rotation1 ( x0_out, y0_out, z0_out, x1_out, y1_out, z1_out); 
    cordic_rot_param #(.rotate_index(4'd2), .rotate_angle(21'h03eb6f)) rotation2 ( x1_out, y1_out, z1_out, x2_out, y2_out, z2_out); 
    cordic_rot_param #(.rotate_index(4'd3), .rotate_angle(21'h01fd5c)) rotation3 ( x2_out, y2_out, z2_out, x3_out, y3_out, z3_out); 
    cordic_rot_param #(.rotate_index(4'd4), .rotate_angle(21'h00ffab)) rotation4 ( x3_out, y3_out, z3_out, x4_out, y4_out, z4_out);
    cordic_rot_param #(.rotate_index(4'd5), .rotate_angle(21'h007ff5)) rotation5 ( x4_out, y4_out, z4_out, x5_out, y5_out, z5_out); 
    cordic_rot_param #(.rotate_index(4'd6), .rotate_angle(21'h003fff)) rotation6 ( x5_out, y5_out, z5_out, x6_out, y6_out, z6_out); 
    cordic_rot_param #(.rotate_index(4'd7), .rotate_angle(21'h002000)) rotation7 ( x6_out, y6_out, z6_out, x7_out, y7_out, z7_out); // s1 end
    cordic_rot_param #(.rotate_index(4'd8), .rotate_angle(21'h001000)) rotation8 ( x_reg, y_reg, z_reg, x8_out, y8_out, z8_out); // s2 start
    cordic_rot_param #(.rotate_index(4'd9), .rotate_angle(21'h000800)) rotation9 ( x8_out, y8_out, z8_out, x9_out, y9_out, z9_out); 
    cordic_rot_param #(.rotate_index(4'd10), .rotate_angle(21'h000400)) rotation10 ( x9_out, y9_out, z9_out, x10_out, y10_out, z10_out); 
    cordic_rot_param #(.rotate_index(4'd11), .rotate_angle(21'h000200)) rotation11 ( x10_out, y10_out, z10_out, x11_out, y11_out, z11_out); 
    cordic_rot_param #(.rotate_index(4'd12), .rotate_angle(21'h000100)) rotation12 ( x11_out, y11_out, z11_out, x12_out, y12_out, z12_out); 
    cordic_rot_param #(.rotate_index(4'd13), .rotate_angle(21'h000080)) rotation13 ( x12_out, y12_out, z12_out, x13_out, y13_out, z13_out); 
    cordic_rot_param #(.rotate_index(4'd14), .rotate_angle(21'h000040)) rotation14 ( x13_out, y13_out, z13_out, x14_out, y14_out, z14_out); 
    cordic_rot_param #(.rotate_index(4'd15), .rotate_angle(21'h000020)) rotation15 ( x14_out, y14_out, z14_out, x15_out, y15_out, z15_out); // s2 end

	
    integer i;
    always@(posedge clock) begin
        if (aclr) begin

            for (i = 0; i < 2; i = i + 1) begin
                x_reg[i] <= 21'b0;
                y_reg[i] <= 21'b0;
                z_reg[i] <= 21'b0;
            end
			// fixed_point_result <= 21'b0;

        end else if(clk_en) begin
            x_reg <= x7_out;
            y_reg <= y7_out;
            z_reg <= z7_out;

        end 
    end

    //-----------------------------------convert to floating point--------------------------------
    // fixed_to_float fixed_to_float_unit( fixed_point_result, result );
	fixed_to_float fixed_to_float_unit( x15_out, result );

endmodule