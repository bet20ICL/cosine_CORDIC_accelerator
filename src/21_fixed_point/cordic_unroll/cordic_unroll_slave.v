module cordic(
    aclr,
	clk_en,
	clock,
	dataa,
	result
    );

	input	        aclr;
	input	        clk_en;
	input	        clock;
	input	[31:0]  dataa;
	output	[31:0]  result;

    //-------------------------------------------------------------
    // FP to fixed-point
    //-------------------------------------------------------------
    wire [20:0] fixed_point_input;
    floating_to_fixed floating_to_fixed_unit(.dataa(dataa), .fixed_point_input(fixed_point_input));
    // always@(*)  begin
    //     $display("dataa: %b", dataa);
    //     $display("fixed_point_input: %b", fixed_point_input);
    // end

    //-------------------------------------------------------------
    // CORDIC
    //-------------------------------------------------------------
    reg signed [20:0] x;
    reg signed [20:0] y;
    reg signed [20:0] z;

    reg  [20:0] offsetX;
    reg  [20:0] offsetY;
    reg  [20:0] offsetZ;

    reg [4:0] rotate_index;
    reg signed [20:0] rotateAngle; // in radian
    

    always@(*) begin
        case(rotate_index)             
            4'd0    : rotateAngle = 21'b011001001000011111101;
            4'd1    : rotateAngle = 21'b001110110101100011001;
            4'd2    : rotateAngle = 21'b000111110101101101110;
            4'd3    : rotateAngle = 21'b000011111110101011011;
            4'd4    : rotateAngle = 21'b000001111111110101010;
            4'd5    : rotateAngle = 21'b000000111111111110101;
            4'd6    : rotateAngle = 21'b000000011111111111110;
            4'd7    : rotateAngle = 21'b000000001111111111111;
            4'd8    : rotateAngle = 21'b000000000111111111111;
            4'd9    : rotateAngle = 21'b000000000011111111111;
            4'd10   : rotateAngle = 21'b000000000001111111111;
            4'd11   : rotateAngle = 21'b000000000000111111111;
            4'd12   : rotateAngle = 21'b000000000000011111111;
            4'd13   : rotateAngle = 21'b000000000000001111111;
            4'd14   : rotateAngle = 21'b000000000000000111111;
            4'd15   : rotateAngle = 21'b000000000000000011111;
            default : rotateAngle = 0; 		
        endcase
    end
    
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
    end

    always @(posedge clock) begin
        if (aclr) begin
            rotate_index <= 4'b0;
            x <= 21'b010011011011101001110;
            y <= 21'b0;
            z <= fixed_point_input;
        end 
        else if (clk_en) begin
            rotate_index <= rotate_index + 1'b1;
            x <= x + offsetX;
            y <= y + offsetY;
            z <= z + offsetZ;
        end
    end

    //-------------------------------------------------------------
    // Fixed point to floating point
    //-------------------------------------------------------------
    // TODO: We can get rip off the last cycle if wanted.

    wire [20:0] fixed_point_result;
    wire [31:0] result_fp;

    assign fixed_point_result = (rotate_index==16 && !aclr) ? x : 21'b0;   // TODO: assign fixed_point_result = (rotate_index==15 && !aclr) ? x+offsetX : 21'b0;
   
    fixed_to_float fixed_to_float_unit( fixed_point_result, result_fp );
    
    assign result = (rotate_index==16 && !aclr) ?  result_fp : 32'b0;   // TODO: assign result = (rotate_index==15 && !aclr) ?  result_fp : 32'b0

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