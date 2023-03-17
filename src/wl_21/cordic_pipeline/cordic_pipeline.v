module cordic_pipeline(
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
    // TODO: clock logic not added
    reg signed [20:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15;
    reg signed [20:0] y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15;
    reg signed [20:0] z0,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15;
    wire signed [20:0] x0_out,x1_out,x2_out,x3_out,x4_out,x5_out,x6_out,x7_out,x8_out,x9_out,x10_out,x11_out,x12_out,x13_out,x14_out,x15_out;
    wire signed [20:0] y0_out,y1_out,y2_out,y3_out,y4_out,y5_out,y6_out,y7_out,y8_out,y9_out,y10_out,y11_out,y12_out,y13_out,y14_out,y15_out;
    wire signed [20:0] z0_out,z1_out,z2_out,z3_out,z4_out,z5_out,z6_out,z7_out,z8_out,z9_out,z10_out,z11_out,z12_out,z13_out,z14_out,z15_out;

    cordic_operation #(.rotate_index(4'd0), .rotate_angle(21'h0c90fe)) rotation0 ( x0, y0, z0, x0_out, y0_out, z0_out); 
    cordic_operation #(.rotate_index(4'd1), .rotate_angle(21'h076b1a)) rotation1 ( x1, y1, z1, x1_out, y1_out, z1_out); 
    cordic_operation #(.rotate_index(4'd2), .rotate_angle(21'h03eb6f)) rotation2 ( x2, y2, z2, x2_out, y2_out, z2_out); 
    cordic_operation #(.rotate_index(4'd3), .rotate_angle(21'h01fd5c)) rotation3 ( x3, y3, z3, x3_out, y3_out, z3_out); 
    cordic_operation #(.rotate_index(4'd4), .rotate_angle(21'h00ffab)) rotation4 ( x4, y4, z4, x4_out, y4_out, z4_out); 
    cordic_operation #(.rotate_index(4'd5), .rotate_angle(21'h007ff5)) rotation5 ( x5, y5, z5, x5_out, y5_out, z5_out); 
    cordic_operation #(.rotate_index(4'd6), .rotate_angle(21'h003fff)) rotation6 ( x6, y6, z6, x6_out, y6_out, z6_out); 
    cordic_operation #(.rotate_index(4'd7), .rotate_angle(21'h002000)) rotation7 ( x7, y7, z7, x7_out, y7_out, z7_out); 
    cordic_operation #(.rotate_index(4'd8), .rotate_angle(21'h001000)) rotation8 ( x8, y8, z8, x8_out, y8_out, z8_out); 
    cordic_operation #(.rotate_index(4'd9), .rotate_angle(21'h000800)) rotation9 ( x9, y9, z9, x9_out, y9_out, z9_out); 
    cordic_operation #(.rotate_index(4'd10), .rotate_angle(21'h000400)) rotation10 ( x10, y10, z10, x10_out, y10_out, z10_out); 
    cordic_operation #(.rotate_index(4'd11), .rotate_angle(21'h000200)) rotation11 ( x11, y11, z11, x11_out, y11_out, z11_out); 
    cordic_operation #(.rotate_index(4'd12), .rotate_angle(21'h000100)) rotation12 ( x12, y12, z12, x12_out, y12_out, z12_out); 
    cordic_operation #(.rotate_index(4'd13), .rotate_angle(21'h000080)) rotation13 ( x13, y13, z13, x13_out, y13_out, z13_out); 
    cordic_operation #(.rotate_index(4'd14), .rotate_angle(21'h000040)) rotation14 ( x14, y14, z14, x14_out, y14_out, z14_out); 
    cordic_operation #(.rotate_index(4'd15), .rotate_angle(21'h000020)) rotation15 ( x15, y15, z15, x15_out, y15_out, z15_out); 

	reg [20:0] fixed_point_result;
	 
    always@(posedge clock) begin
        if (aclr) begin
            x0 <= 21'b0; y0 <= 21'b0; z0 <= 21'b0;
            x1 <= 21'b0; y1 <= 21'b0; z1 <= 21'b0;
            x2 <= 21'b0; y2 <= 21'b0; z2 <= 21'b0;
            x3 <= 21'b0; y3 <= 21'b0; z3 <= 21'b0;
            x4 <= 21'b0; y4 <= 21'b0; z4 <= 21'b0;
            x5 <= 21'b0; y5 <= 21'b0; z5 <= 21'b0;
            x6 <= 21'b0; y6 <= 21'b0; z6 <= 21'b0;
            x7 <= 21'b0; y7 <= 21'b0; z7 <= 21'b0;
            x8 <= 21'b0; y8 <= 21'b0; z8 <= 21'b0;
            x9 <= 21'b0; y9 <= 21'b0; z9 <= 21'b0;
            x10 <= 21'b0; y10 <= 21'b0; z10 <= 21'b0;
            x11 <= 21'b0; y11 <= 21'b0; z11 <= 21'b0;
            x12 <= 21'b0; y12 <= 21'b0; z12 <= 21'b0;
            x13 <= 21'b0; y13 <= 21'b0; z13 <= 21'b0;
            x14 <= 21'b0; y14 <= 21'b0; z14 <= 21'b0;
            x15 <= 21'b0; y15 <= 21'b0; z15 <= 21'b0;
			fixed_point_result <= 21'b0;
        end else if(clk_en) begin
            x0 <= 21'b010011011011101001110;
            y0 <= 21'b0;
            z0 <= fixed_point_input;
            x1 <= x0_out; y1 <= y0_out; z1 <= z0_out;
            x2 <= x1_out; y2 <= y1_out; z2 <= z1_out;
            x3 <= x2_out; y3 <= y2_out; z3 <= z2_out;
            x4 <= x3_out; y4 <= y3_out; z4 <= z3_out;
            x5 <= x4_out; y5 <= y4_out; z5 <= z4_out;
            x6 <= x5_out; y6 <= y5_out; z6 <= z5_out;
            x7 <= x6_out; y7 <= y6_out; z7 <= z6_out;
            x8 <= x7_out; y8 <= y7_out; z8 <= z7_out;
            x9 <= x8_out; y9 <= y8_out; z9 <= z8_out;
            x10 <= x9_out; y10 <= y9_out; z10 <= z9_out;
            x11 <= x10_out; y11 <= y10_out; z11 <= z10_out;
            x12 <= x11_out; y12 <= y11_out; z12 <= z11_out;
            x13 <= x12_out; y13 <= y12_out; z13 <= z12_out;
            x14 <= x13_out; y14 <= y13_out; z14 <= z13_out;
            x15 <= x14_out; y15 <= y14_out; z15 <= z14_out;
			fixed_point_result <= x15_out;
        end 
    end

    //-----------------------------------convert to floating point--------------------------------
    
	fixed_to_float fixed_to_float_unit( fixed_point_result, result );

endmodule

module cordic_operation(
     x,
     y,
     z,
     x_out,
     y_out,
     z_out
 );
     parameter   [3:0]       rotate_index = 4'b1;
     parameter   [20:0]      rotate_angle = 21'b0;
                
     input signed [20:0] x;
     input signed [20:0] y;
     input signed [20:0] z;

     output reg signed [20:0] x_out;
     output reg signed [20:0] y_out;
     output reg signed [20:0] z_out;

     reg [20:0] z_replicated; 
     reg [20:0] x_shift;
     reg [20:0] y_shift;

     always@(*) begin 
         z_replicated = {21{z[20]}};
         y_shift = (y>>>rotate_index);
         x_shift = (x>>rotate_index);
         x_out = x + (y_shift ^ ~z_replicated) + !z[20]; 
         y_out = y + (x_shift ^ z_replicated) + z[20]; 
         z_out = z + (rotate_angle ^ ~z_replicated) + !z[20]; 
     end

 endmodule