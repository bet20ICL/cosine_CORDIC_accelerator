// module x_minus_div_128_fxd(
//     flt_in,
//     fxd_out
// );
//     input	[31:0]  flt_in;     // floating point input
//     output  [21:0] fxd_out;     // 1 signed bit, 20 frac bits

//     reg     [21:0] fxd_9_13;    
    

//     always@(*) begin 
//         if(fixed_point_input_9_13[21]==0) subtract_128 = fixed_point_input_9_13 - 21'sd128; 
//         else   subtract_128 = 21'sd128 - fixed_point_input_9_13; 
//         divide_128 = subtract_128 >> 7;
//     end
// endmodule

// module floating_to_fixed_9_13(
//     dataa,
//     fixed_point_input
// );
//     // convert the 32bits floating point input to 21bits fixed point.
//     input	[31:0]  dataa; 
//     output  [21:0] fixed_point_input;  

//     wire unsigned [7:0] exponent; 
//     wire [22:0] significand;
//     wire sign;
    
//     assign exponent = dataa[30:23];
//     assign significand = dataa[22:0];
//     assign sign = dataa[31];

//     wire [8:0] exp_diff;
//     assign exp_diff = exponent + 9'b110000001; // -127 in twos complement

//     wire [8:0] neg_exp_diff;
//     assign neg_exp_diff = ~exp_diff + 1'b1;

//     // 9+13 = 22
//     wire [21:0] magnitude;
//     assign magnitude = exp_diff[8] ? significand << neg_exp_diff : significand >> exp_diff;

//     always@(*) begin
//         magnitude = significand[22:3];
//         if(exponent < 7'd127) begin
//             magnitude = magnitude >> (7'd127-exponent);
//         end else
//         begin
//             magnitude = magnitude << (exponent-7'd127);
//         end
//     end
//     assign fixed_point_input = (sign)? ~magnitude+1 : magnitude;

// endmodule

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