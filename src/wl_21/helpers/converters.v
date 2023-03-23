module floating_to_fixed_8_13(
    dataa,
    fixed_point_input
);
    // convert the 32bits floating point input to 21bits fixed point.
    input	[31:0]  dataa; 
    output  [27:0] fixed_point_input;  

    wire [8:0] exponent;  // added one more bit in front to ensure it is a positive number. 
    wire [22:0] significand;
    wire sign;
    
    assign exponent = dataa[30:23]; // the most significant bit will be 0
    assign significand = dataa[22:0];
    assign sign = dataa[31];

    // always positive 8+13 = 21
    // magnitude + 20+ 8;
    wire [27:0] magnitude;
    assign magnitude = {8'b1,significand[22:3]};

    reg [27:0] shifted_result;
    reg [8:0] shifting;
    always@(*) begin
        shifting = exponent + 9'b110000001;  // -128
        if (shifting[8]) begin
            //shifting is negative
            shifted_result = magnitude >> (~shifting+1'b1);
        end else
        begin
            shifted_result = magnitude << shifting;  // TODO:sus
        end
    end
    // Input is always going to be positive
    assign fixed_point_input = shifted_result;



    //assign fixed_point_input = (sign)? ~magnitude+1 : magnitude;

    // always@(fixed_point_input) begin
    //     // $display("<--------------------------->");
    //     $display("dataa     %b", dataa);
	// 	// $display("magnitude      %b", magnitude);
    //     $display("shifted_result %b", shifted_result);
    //     // $display("shifting  %d", shifting);
    //     // $display("negative shifting  %d", (~shifting+1'b1));
    //     $display("fixed_point_input  %b", fixed_point_input);

	// end


endmodule

module fixed_subtract_128(
    fixed_point_input_8_13,
    divide_128
);
    input  [27:0] fixed_point_input_8_13;
    output [20:0] divide_128;


    // // wire [7:0] input_integer_part;
    // // wire unsigned [7:0] first_operand;
    // // reg [7:0] integer_part_sub128;
    // reg [27:0] divide_128_intermediate;

    // // wire [19:0] fractional_part;
    // // assign input_integer_part = fixed_point_input_8_13[27:27-7];
    // // assign fractional_part = fixed_point_input_8_13[27-8:0];

    // // assign first_operand = (fixed_point_input_8_13[27])? input_integer_part : ~input_integer_part+1;
    // // assign fractional_part = (fixed_point_input_8_13[27])? fixed_point_input_8_13[27-8:0] : ~input_integer_part+1;
     

    // always@(*) begin
    //     // integer_part_sub128 = first_operand + 8'b10000000;
    //     // divide_128_intermediate = {integer_part_sub128, fixed_point_input_8_13[27-8:0]} >> 7;
    //     if(fixed_point_input_8_13[27]) begin
    //         divide_128_intermediate = (fixed_point_input_8_13 - {8'd128, 20'b0}) >> 7;
    //     end 
    //     else begin
    //         divide_128_intermediate = ({8'd128, 20'b0} - fixed_point_input_8_13) >> 7;
    //     end 
    // end
    
    // assign divide_128 = divide_128_intermediate[20:0];


    reg [28:0] divide_128_intermediate_sign; // use sign opperation
    always@(*) begin
        // integer_part_sub128 = first_operand + 8'b10000000;
        // divide_128_intermediate = {integer_part_sub128, fixed_point_input_8_13[27-8:0]} >> 7;
        if(fixed_point_input_8_13[27]) begin
            divide_128_intermediate_sign = {2'b0, fixed_point_input_8_13[26:7]};
        end 
        else begin
            divide_128_intermediate_sign = {2'b11, fixed_point_input_8_13[26:7]};
        end 

        // sign bit is not needed
        assign divide_128 = divide_128_intermediate_sign[20:0];

    end


    //  always@(divide_128) begin
    //     $display("<--------------------->");
    //     $display("fixed_point_input_8_13 %b", fixed_point_input_8_13);
	// 	// $display("input_integer_part     %b", input_integer_part);
	// 	// $display("first_operand          %b", first_operand);
    //     // $display("second_operad          %b", 8'd128);
	// 	// $display("integer_part_sub128    %d", integer_part_sub128);
    //     // $display("integer_part_sub128    %b", integer_part_sub128);
    //     // $display("integer_part_sub128Com1 %b", {integer_part_sub128, fixed_point_input_8_13[27-8:0]});
    //     // $display("integer_part_sub128Com2 %b", divide_128_intermediate);
    //     $display("divide_128             %b", divide_128);
        
	// end
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
    
    assign fixed_point_input = {1'b1, significand[22:3]} >> (7'd127-exponent);

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
        result_exponent = 7'd127 - leadingOneIndex;
        intermediate_result = fixed_point_result << leadingOneIndex;
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

    always@(*) begin
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