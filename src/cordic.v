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
    output [31:0] x_debug;
    output [31:0] z_debug;
    output [31:0] fixed_point_input_debug;
    output [7:0] exponent_debug;
    output [31:0] inter_sig_debug;
    output [31:0] fixed_point_result_debug;

    // decode floating point to fix point input using 32 bit fixed point.
    wire sign; 
    wire [7:0] exponent; 
    wire [22:0] significand;
    
    assign sign = dataa[31];
    assign exponent = dataa[30:23];
    assign significand = dataa[22:0];
    
    
    wire [31:0] fixed_point_input;
    assign fixed_point_input = (exponent == 8'b0) ? 32'b0 : (({1'b1, significand, 8'b0}) >> (7'd127-exponent));

    reg signed [31:0] x;
    reg signed [31:0] y;
    reg signed [31:0] z;
    reg [4:0] rotate_index; // 5 bits so the variable is enough to cover 31 rotation.
    reg [31:0] fixed_point_result;

    assign fixed_point_result = (rotate_index==16 && !aclr) ? x : 32'b0;
    assign rotate_index_debug = rotate_index;
    assign x_debug = x;
    assign z_debug = z;
    assign fixed_point_input_debug = fixed_point_input;
    assign exponent_debug = exponent;
    assign fixed_point_result_debug = fixed_point_result;


    //-------------------------------------cordic------------------------------------
    reg signed [31:0] rotateAngle; // in radian
    always@(*) begin
        case(rotate_index)
            // 4'd0    : rotateAngle = 32'b01100100100001111110110101010000 ;
            // 4'd1    : rotateAngle = 32'b00111011010110001100111000001010 ;
            // 4'd2    : rotateAngle = 32'b00011111010110110111010111111000 ;
            // 4'd3    : rotateAngle = 32'b00001111111010101101110101001100 ;
            // 4'd4    : rotateAngle = 32'b00000111111111010101011011101101 ;
            // 4'd5    : rotateAngle = 32'b00000011111111111010101010110110 ;
            // 4'd6    : rotateAngle = 32'b00000001111111111111010101010100 ;
            // 4'd7    : rotateAngle = 32'b00000000111111111111111010101010 ;
            // 4'd8    : rotateAngle = 32'b00000000011111111111111111010101 ;
            // 4'd9    : rotateAngle = 32'b00000000001111111111111111111011 ;

            4'd0    : rotateAngle = 32'b01100100100001111110110101010001 ;
            4'd1    : rotateAngle = 32'b00111011010110001100111000001010 ;
            4'd2    : rotateAngle = 32'b00011111010110110111010111111001 ;
            4'd3    : rotateAngle = 32'b00001111111010101101110101001101 ;
            4'd4    : rotateAngle = 32'b00000111111111010101011011101101 ;
            4'd5    : rotateAngle = 32'b00000011111111111010101010110111 ;
            4'd6    : rotateAngle = 32'b00000001111111111111010101010101 ;
            4'd7    : rotateAngle = 32'b00000000111111111111111010101010 ;
            4'd8    : rotateAngle = 32'b00000000011111111111111111010101 ;
            4'd9    : rotateAngle = 32'b00000000001111111111111111111010 ;
            4'd10   : rotateAngle = 32'b00000000000111111111111111111111 ;
            4'd11   : rotateAngle = 32'b00000000000011111111111111111111 ;
            4'd12   : rotateAngle = 32'b00000000000001111111111111111111 ;
            4'd13   : rotateAngle = 32'b00000000000000111111111111111111 ;
            4'd14   : rotateAngle = 32'b00000000000000011111111111111111 ;
            4'd15   : rotateAngle = 32'b00000000000000001111111111111111 ;
            default : rotateAngle = 0; 		
        endcase
    end

    //-------------------------------------cordic------------------------------------
    
    reg  [31:0] offsetX;
    reg  [31:0] offsetX_intermediate;
    reg  [31:0] offsetY;
    reg  [31:0] offsetY_intermediate;
    reg  [31:0] offsetZ;


    always @(*) begin
        if(z[31]==0) begin
            offsetX = ~(y >>> rotate_index) + 32'sb1;
            offsetY = x >>> rotate_index;
            offsetZ = ~(rotateAngle) + 1'sb1;
        end 
        else begin
            offsetX = y >>> rotate_index;
            offsetY = ~(x >>> rotate_index) + 1'sb1;
            offsetZ = rotateAngle;
        end
    end

    // TODO: Non pipeline version, initialise condition:  every 16 clock, fixed_point_input changed ... 
    always @(posedge clock) begin
        if (aclr) begin
            rotate_index <= 4'b0;
            x <= 32'b01001101101110100111011011010100;
            y <= 32'b0;
            z <= fixed_point_input;
        end 
        else if (clk_en) begin
            rotate_index <= rotate_index + 1'b1;
            x <= x + offsetX;
            y <= y + offsetY;
            z <= z + offsetZ;
            //$display("z: %b", z + offsetZ);
            $display("<---------------rotate_index %d----------------->", rotate_index);
            $display("z: %b", z + offsetZ);
            $display("y: %b", y + offsetY);
            $display("x: %b", x + offsetX);
            $display("Offset: %b", offsetX);
        end
    end

    // TODO: Converting it back to float
    // TODO: edge cases
    // Edge case testing
    wire [4:0] leadingOneIndex;
    wire containOne_valid;
    priority_encoder32 encoder32( fixed_point_result, leadingOneIndex, containOne_valid);

    reg [31:0] result_fp,intermediate_result;
    reg [7:0] result_exponent;
    reg [22:0] result_significant;

    always@(*) begin
        result_exponent = 127 - leadingOneIndex;
        intermediate_result = fixed_point_result << leadingOneIndex;
        result_significant = intermediate_result[30:8];
        result_fp = {1'b0,result_exponent ,result_significant}; // only output positive number   
    end
    
    assign result = (rotate_index==16 && !aclr) ?  result_fp : 32'b0;

endmodule


module priority_encoder32(
    encoder_input,
    encoder_output,
    valid 
);
    // High level
    input [31:0] encoder_input;
    output reg [4:0] encoder_output;
    output reg valid; 

    // Intermediate block variable
    reg [3:0] encoder_input0,encoder_input1,encoder_input2,encoder_input3,encoder_input4,encoder_input5,encoder_input6,encoder_input7;
    reg [1:0] encoder_output0,encoder_output1,encoder_output2,encoder_output3,encoder_output4,encoder_output5,encoder_output6,encoder_output7;
    reg valid0,valid1,valid2,valid3,valid4,valid5,valid6,valid7;
    
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

    // produce selected(encoder_output8) and appended bits(encoder_output8) and valid(valid)
    // TODO: invalid case is not produced;
    reg [7:0] encoder_input8;
    reg [2:0] encoder_output8;
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


module priority_encoder(
    encoder_input,
    encoder_output,
    valid
);
// priority encoder
// 4-to-2 encoder

    input [3:0] encoder_input;
    output reg [1:0] encoder_output;
    output reg valid;

    always@(*) begin
        encoder_output[0] = ((!encoder_input[3]) & encoder_input[2]) | ((!encoder_input[3])&(!encoder_input[1])&(encoder_input[0]));
        encoder_output[1] = (!encoder_input[2]) & (!encoder_input[3]);
        valid = encoder_input[0] | encoder_input[1] | encoder_input[3] | encoder_input[2];
    end 

endmodule


module priority_encoder8(
    encoder_input,
    encoder_output,
    valid
);
// priority encoder
// 8-to-3 encoder

    input [7:0] encoder_input;
    output reg [2:0] encoder_output;
    output reg valid;


    reg [3:0] encoder_input8_0,encoder_input8_1;
    reg [1:0] encoder_output8_0,encoder_output8_1;
    reg valid8_0,valid8_1;
    reg select8;

    always@(*)begin
        encoder_input8_1 = encoder_input[3:0];
        encoder_input8_0 = encoder_input[7:4];
    end

    priority_encoder encoder8_0( encoder_input8_0, encoder_output8_0, valid8_0 );
    priority_encoder encoder8_1( encoder_input8_1, encoder_output8_1, valid8_1 );

    assign encoder_output = (valid8_0==1)? {1'b0,encoder_output8_0} : {1'b1,encoder_output8_1};
    assign valid = valid8_0 | valid8_1;


endmodule