module cordic(
    aclr,
	clk_en,
	clock,
	dataa,
	result,
    rotate_index_debug,
    x_debug,
    z_debug,
    fixed_point_input_debug,
    exponent_debug,
    inter_sig_debug,
    fixed_point_result_debug);

	input	  aclr;
	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa; // this is the floating point input
	output	[31:0]  result;
    output [4:0] rotate_index_debug;
    output [20:0] x_debug;
    output [20:0] z_debug;
    output [20:0] fixed_point_input_debug;
    output [7:0] exponent_debug;
    output [31:0] inter_sig_debug;
    output [20:0] fixed_point_result_debug;

    //-------------------------------------Debug Signal-----------------------------
    // assign rotate_index_debug = rotate_index;
    // assign x_debug = x;
    // assign z_debug = z;
    // assign fixed_point_input_debug = fixed_point_input;
    // assign exponent_debug = exponent;
    // assign fixed_point_result_debug = fixed_point_result;

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
    
    cordic_operation rotation_0( x0, y0, z0, x0_out, y0_out, z0_out, 5'd0, 21'b011001001000011111101);
    cordic_operation rotation_1( x1, y1, z1, x1_out, y1_out, z1_out, 5'd1, 21'b001110110101100011001);
    cordic_operation rotation_2( x2, y2, z2, x2_out, y2_out, z2_out, 5'd2, 21'b000111110101101101110);
    cordic_operation rotation_3( x3, y3, z3, x3_out, y3_out, z3_out, 5'd3, 21'b000011111110101011011);
    cordic_operation rotation_4( x4, y4, z4, x4_out, y4_out, z4_out, 5'd4, 21'b000001111111110101010);
    cordic_operation rotation_5( x5, y5, z5, x5_out, y5_out, z5_out, 5'd5, 21'b000000111111111110101);
    cordic_operation rotation_6( x6, y6, z6, x6_out, y6_out, z6_out, 5'd6, 21'b000000011111111111110);
    cordic_operation rotation_7( x7, y7, z7, x7_out, y7_out, z7_out, 5'd7, 21'b000000001111111111111);
    cordic_operation rotation_8( x8, y8, z8, x8_out, y8_out, z8_out, 5'd8, 21'b000000000111111111111);
    cordic_operation rotation_9( x9, y9, z9, x9_out, y9_out, z9_out, 5'd9, 21'b000000000011111111111);
    cordic_operation rotation_10( x10, y10, z10, x10_out, y10_out, z10_out, 5'd10, 21'b000000000001111111111);
    cordic_operation rotation_11( x11, y11, z11, x11_out, y11_out, z11_out, 5'd11, 21'b000000000000111111111);
    cordic_operation rotation_12( x12, y12, z12, x12_out, y12_out, z12_out, 5'd12, 21'b000000000000011111111);
    cordic_operation rotation_13( x13, y13, z13, x13_out, y13_out, z13_out, 5'd13, 21'b000000000000001111111);
    cordic_operation rotation_14( x14, y14, z14, x14_out, y14_out, z14_out, 5'd14, 21'b000000000000000111111);
    cordic_operation rotation_15( x15, y15, z15, x15_out, y15_out, z15_out, 5'd15, 21'b000000000000000011111);

    always@(posedge clock) begin
        x0 <= 21'b010011011011101001110;
        y0 <= 21'b0;
        z0 <= fixed_point_input;
        if (aclr) begin
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
        end else if(clk_en) begin
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
        end 
    end

    //-----------------------------------convert to floating point--------------------------------
    fixed_to_float fixed_to_float_unit( x15, result );
    

endmodule




module cordic_operation(
    x,
    y,
    z,
    x_out,
    y_out,
    z_out,
    rotate_index,
    rotateAngle // in radian
);
    input signed [20:0] x;
    input signed [20:0] y;
    input signed [20:0] z;

    output reg signed [20:0] x_out;
    output reg signed [20:0] y_out;
    output reg signed [20:0] z_out;

    input  [4:0] rotate_index;
    input  [20:0] rotateAngle;

    reg  [20:0] offsetX;
    reg  [20:0] offsetY;
    reg  [20:0] offsetZ;

    always @(*) begin
        if(z[20]==0) begin
            offsetX = ~(y >>> rotate_index) + 21'sb1;
            offsetY = x >>> rotate_index;
            offsetZ = ~(rotateAngle) + 1'sb1;
        end 
        else begin
            offsetX = y >>> rotate_index;
            offsetY = ~(x >>> rotate_index) + 1'sb1;
            offsetZ = rotateAngle;
        end

        x_out = x + offsetX;
        y_out = y + offsetY;
        z_out = z + offsetZ;
    end
endmodule

module floating_to_fixed(
    dataa,
    fixed_point_input
);
    // convert the 32bits floating point input to 21bits fixed point.
    input	[31:0]  dataa; 
    output  [20:0] fixed_point_input;  

    wire [7:0] exponent; 
    wire [22:0] significand;
    
    assign exponent = dataa[30:23];
    assign significand = dataa[22:0];
    
 // assign fixed_point_input = (exponent == 8'b0) ? 32'b0 : (({1'b1, significand, 8'b0}) >> (7'd127-exponent));
    assign fixed_point_input = (exponent == 8'b0) ? 21'b0 : (({1'b1, significand[22:3]}) >> (7'd127-exponent));

endmodule


module fixed_to_float(
    fixed_point_result,
    result_fp
);
    // convert the 21-bit floating point input to 32-bit fixed point.
    input [20:0] fixed_point_result;
    output reg [31:0] result_fp;

    wire [4:0] leadingOneIndex;
    wire containOne_valid;

    //append 20-bit fixed point to 32-bit fixed point
    wire [31:0] fixed_point_result_appended_to_32_bits;
    assign fixed_point_result_appended_to_32_bits = {fixed_point_result, 11'b0};

    priority_encoder32 encoder32( fixed_point_result_appended_to_32_bits, leadingOneIndex, containOne_valid);

    reg [20:0] intermediate_result;
    reg [7:0] result_exponent;
    reg [22:0] result_significant;

    always@(*) begin
        result_exponent = 127 - leadingOneIndex;
        intermediate_result = fixed_point_result << leadingOneIndex;
        result_significant = {intermediate_result[19:0],3'b0};
        result_fp = {1'b0,result_exponent ,result_significant}; // only output positive number   
    end
endmodule


module priority_encoder32(
    encoder_input,
    encoder_output,
    valid 
);
    // High level
    input [31:0] encoder_input;
    output reg [4:0] encoder_output;
    output wire valid; 

    // Intermediate block variable
    reg [3:0] encoder_input0,encoder_input1,encoder_input2,encoder_input3,encoder_input4,encoder_input5,encoder_input6,encoder_input7;
    wire [1:0] encoder_output0,encoder_output1,encoder_output2,encoder_output3,encoder_output4,encoder_output5,encoder_output6,encoder_output7;
    wire valid0,valid1,valid2,valid3,valid4,valid5,valid6,valid7;
    
    always@(*) begin
        encoder_input7 = encoder_input[3:0];
        encoder_input6 = encoder_input[7:4];
        encoder_input5 = encoder_input[11:8];
        encoder_input4 = encoder_input[15:12];

        encoder_input3 = encoder_input[19:16];
        encoder_input2 = encoder_input[23:21];
        encoder_input1 = encoder_input[27:24];
        encoder_input0 = encoder_input[31:28];
    end 

    priority_encoder encoder0( encoder_input0, encoder_output0, valid0 );
    priority_encoder encoder1( encoder_input1, encoder_output1, valid1 );
    priority_encoder encoder2( encoder_input2, encoder_output2, valid2 );
    priority_encoder encoder3( encoder_input3, encoder_output3, valid3 );
    priority_encoder encoder4( encoder_input4, encoder_output4, valid4 );
    priority_encoder encoder5( encoder_input5, encoder_output5, valid5 );
    priority_encoder encoder6( encoder_input6, encoder_output6, valid6 );
    priority_encoder encoder7( encoder_input7, encoder_output7, valid7 );

    wire [7:0] encoder_input8;
    wire [2:0] encoder_output8;
    assign encoder_input8 = {valid0,valid1,valid2,valid3,valid4,valid5,valid6,valid7};

    priority_encoder8 encoder8( encoder_input8, encoder_output8, valid );

    always@(valid) begin
        if(valid == 1) begin
            case (encoder_output8)
                0 : encoder_output = {encoder_output8, encoder_output0};
                1 : encoder_output = {encoder_output8, encoder_output1};
                2 : encoder_output = {encoder_output8, encoder_output2};
                3 : encoder_output = {encoder_output8, encoder_output3};
                4 : encoder_output = {encoder_output8, encoder_output4};
                5 : encoder_output = {encoder_output8, encoder_output5};
                6 : encoder_output = {encoder_output8, encoder_output6};
                7 : encoder_output = {encoder_output8, encoder_output7};
                default :  encoder_output = 5'b0;
            endcase
        end
    end 
endmodule


// 8-to-3 priority encoder
module priority_encoder8(
    encoder_input,
    encoder_output,
    valid
);
    input [7:0] encoder_input;
    output wire [2:0] encoder_output;
    output wire valid;


    reg [3:0] encoder_input8_0,encoder_input8_1;
    wire [1:0] encoder_output8_0,encoder_output8_1;
    wire valid8_0,valid8_1;

    always@(*)begin
        encoder_input8_1 = encoder_input[3:0];
        encoder_input8_0 = encoder_input[7:4];
    end

    priority_encoder encoder8_0( encoder_input8_0, encoder_output8_0, valid8_0 );
    priority_encoder encoder8_1( encoder_input8_1, encoder_output8_1, valid8_1 );

    assign encoder_output = (valid8_0==1)? {1'b0,encoder_output8_0} : {1'b1,encoder_output8_1};
    assign valid = valid8_0 | valid8_1;
endmodule


// 4-to-2 priority encoder
module priority_encoder(
    encoder_input,
    encoder_output,
    valid
);
    input [3:0] encoder_input;
    output reg [1:0] encoder_output;
    output reg valid;

    always@(*) begin
        encoder_output[0] = ((!encoder_input[3]) & encoder_input[2]) | ((!encoder_input[3])&(!encoder_input[1])&(encoder_input[0]));
        encoder_output[1] = (!encoder_input[2]) & (!encoder_input[3]);
        valid = encoder_input[0] | encoder_input[1] | encoder_input[3] | encoder_input[2];
    end 
endmodule