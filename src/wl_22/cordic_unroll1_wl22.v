module cordic_unroll1_var(
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

    //-------------------------------------------------------------
    // FP to fixed-point
    //-------------------------------------------------------------
    // ignore the sign of the input as we know cosine is even
    wire [21:0] fixed_point_input;
    floating_to_fixed floating_to_fixed_unit(.dataa(dataa), .fixed_point_input(fixed_point_input));


    //-------------------------------------------------------------
    // CORDIC
    //-------------------------------------------------------------
    reg signed [21:0] x;
    reg signed [21:0] y;
    reg signed [21:0] z;

    wire signed [21:0] rot_x;
    wire signed [21:0] rot_y;
    wire signed [21:0] rot_z;

    reg [4:0] rotate_index;
    reg signed [21:0] rotateAngle; // in radian
    
    // LUT
    always@(*) begin
        case(rotate_index)             
            4'd0    : rotateAngle = 22'h0c90fe;
            4'd1    : rotateAngle = 22'h076b1a;
            4'd2    : rotateAngle = 22'h03eb6f;
            4'd3    : rotateAngle = 22'h01fd5c;
            4'd4    : rotateAngle = 22'h00ffab;
            4'd5    : rotateAngle = 22'h007ff5;
            4'd6    : rotateAngle = 22'h003fff;
            4'd7    : rotateAngle = 22'h002000;
            4'd8    : rotateAngle = 22'h001000;
            4'd9    : rotateAngle = 22'h000800;
            4'd10   : rotateAngle = 22'h000400;
            4'd11   : rotateAngle = 22'h000200;
            4'd12   : rotateAngle = 22'h000100;
            4'd13   : rotateAngle = 22'h000080;
            4'd14   : rotateAngle = 22'h000040;
            4'd15   : rotateAngle = 22'h000020;
            default : rotateAngle = 0; 		
        endcase
    end

    assign done = (rotate_index == 5'd16);

    cordic_rot cr_0( .x(x), .y(y), .z(z), .rot_x(rot_x), .rot_y(rot_y), .rot_z(rot_z), .rotate_index(rotate_index), .rotate_angle(rotateAngle));

    always @(posedge clock) begin
        if (aclr) begin
            rotate_index <= 4'b0;
            x <= 22'b0010011011011101001110;
            y <= 22'b0;
            z <= 22'b0;
        end 
        else if (clk_en) begin
            if (start) begin
                rotate_index <= 4'b0;
                x <= 22'b0010011011011101001110;
                y <= 22'b0;
                z <= fixed_point_input;
            end
            else begin
                rotate_index <= rotate_index + 1'b1;
                x <= rot_x;
                y <= rot_y;
                z <= rot_z;
            end
        end
    end
    // always@(*) begin
    //     $display("rotate_index ", rotate_index);
    //     $display("x: ", x);
    //     $display("y: ", y);
    //     $display("z: ", z);
    // end

    //-------------------------------------------------------------
    // Fixed point to floating point
    //-------------------------------------------------------------

    wire [21:0] fixed_point_result;
    wire [31:0] result_fp;

    assign fixed_point_result = x;

    // fixed_to_float fixed_to_float_unit( x, result_fp );
    fixed_to_float fixed_to_float_unit( x[20:0], result_fp );
    
    assign result = result_fp;

endmodule


module cordic_rot(
    x,
    y,
    z,
    rot_x,
    rot_y,
    rot_z,
    rotate_index,
    rotate_angle
);
    input signed [21:0] x;
    input signed [21:0] y;
    input signed [21:0] z;
    input unsigned [3:0] rotate_index;
    input signed [21:0] rotate_angle;

    output reg [21:0] rot_x;
    output reg [21:0] rot_y;
    output reg [21:0] rot_z;

    reg [21:0] z_replicated; 
    reg [21:0] x_shift;
    reg [21:0] y_shift;
    always@(*) begin 
        z_replicated = {22{z[21]}};
        y_shift = (y>>>rotate_index);
        x_shift = (x>>rotate_index);
        rot_x = x + (y_shift ^ ~z_replicated) + !z[21]; 
        rot_y = y + (x_shift ^ z_replicated) + z[21]; 
        rot_z = z + (rotate_angle ^ ~z_replicated) + !z[21]; 
    end
endmodule



module floating_to_fixed(
    dataa,
    fixed_point_input
);
    // convert the 32bits floating point input to 21bits fixed point.
    input	[31:0]  dataa; 
    output  [21:0] fixed_point_input;  

    wire [7:0] exponent; 
    wire [22:0] significand;
    
    assign exponent = dataa[30:23];
    assign significand = dataa[22:0];
    
    assign fixed_point_input = {2'b01, significand[22:3]} >> (7'd127-exponent);

endmodule


module fixed_to_float(
    fixed_point_result,
    result_fp
);
    // convert the 22-bit fixed point input to 32-bit floating point input.
    // input [21:0] fixed_point_result;
    input [20:0] fixed_point_result;
    output reg [31:0] result_fp;

    wire [4:0] leadingOneIndex;
    wire containOne_valid;

    //append 20-bit fixed point to 32-bit fixed point
    wire [31:0] fixed_point_result_appended_to_32_bits;
    // assign fixed_point_result_appended_to_32_bits = {fixed_point_result, 10'b0};
    assign fixed_point_result_appended_to_32_bits = {fixed_point_result, 11'b0};

    priority_encoder32 encoder32( fixed_point_result_appended_to_32_bits, leadingOneIndex, containOne_valid);

    // reg [21:0] intermediate_result;
    reg [20:0] intermediate_result;
    reg [7:0] result_exponent;
    reg [22:0] result_significant;

    always@(*) begin
        result_exponent = 7'd127 - leadingOneIndex;
        intermediate_result = fixed_point_result << leadingOneIndex;
        // result_significant = {intermediate_result[20:0],2'b0};
        result_significant = {intermediate_result[19:0],3'b0};
        result_fp = {1'b0, result_exponent ,result_significant}; // only output positive number   
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
    output valid; 

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
    output reg [2:0] encoder_output;
    output reg valid;

    reg [3:0] encoder_input8_0,encoder_input8_1;
    wire [1:0] encoder_output8_0,encoder_output8_1;
    wire valid8_0,valid8_1;

    priority_encoder encoder8_0( encoder_input8_0, encoder_output8_0, valid8_0 );
    priority_encoder encoder8_1( encoder_input8_1, encoder_output8_1, valid8_1 );

    always@(*)begin
        encoder_input8_1 = encoder_input[3:0];
        encoder_input8_0 = encoder_input[7:4];
        encoder_output = (valid8_0==1)? {1'b0,encoder_output8_0} : {1'b1,encoder_output8_1};
        valid = valid8_0 | valid8_1;
    end

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
        encoder_output[0] = ((!encoder_input[3]) & encoder_input[2]) | ((!encoder_input[3]) & (!encoder_input[1]) & (encoder_input[0]));
        encoder_output[1] = (!encoder_input[2]) & (!encoder_input[3]);
        valid = encoder_input[0] | encoder_input[1] | encoder_input[3] | encoder_input[2];
    end 

endmodule