module cordic(
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
    wire [20:0] fixed_point_input;
    floating_to_fixed floating_to_fixed_unit(.dataa(dataa), .fixed_point_input(fixed_point_input));


    //-------------------------------------------------------------
    // CORDIC
    //-------------------------------------------------------------
    reg signed [20:0] x, x1, x2, x3, x4, x5, x6, x7;
    reg signed [20:0] y, y1, y2, y3, y4, y5, y6, y7;
    reg signed [20:0] z, z1, z2, z3, z4, z5, z6, z7;
   
    wire  [20:0] offsetX, offsetX1, offsetX2, offsetX3, offsetX4, offsetX5, offsetX6, offsetX7;
    wire  [20:0] offsetY, offsetY1, offsetY2, offsetY3, offsetY4, offsetY5, offsetY6, offsetY7;
    wire  [20:0] offsetZ, offsetZ1, offsetZ2, offsetZ3, offsetZ4, offsetZ5, offsetZ6, offsetZ7;
   
    reg [4:0] rotate_index, rotate_index1, rotate_index2, rotate_index3, rotate_index4, rotate_index5, rotate_index6, rotate_index7;
    reg signed [20:0] rotateAngle, rotateAngle1, rotateAngle2, rotateAngle3, rotateAngle4, rotateAngle5, rotateAngle6, rotateAngle7;
    
    // LUT
    always@(*) begin
        case(rotate_index)             
            4'd0    : 
            begin 
                rotateAngle  = 21'b011001001000011111101; 
                rotateAngle1 = 21'b001110110101100011001;
                rotateAngle2 = 21'b000111110101101101110;
                rotateAngle3 = 21'b000011111110101011011;
            
                rotateAngle4 = 21'b000001111111110101010;
                rotateAngle5 = 21'b000000111111111110101;
                rotateAngle6 = 21'b000000011111111111110;
                rotateAngle7 = 21'b000000001111111111111;
            end
            4'd8    : 
            begin
                rotateAngle = 21'b000000000111111111111;
                rotateAngle1 = 21'b000000000011111111111;
                rotateAngle2 = 21'b000000000001111111111;
                rotateAngle3 = 21'b000000000000111111111;
          
                rotateAngle4 = 21'b000000000000011111111;
                rotateAngle5 = 21'b000000000000001111111;
                rotateAngle6 = 21'b000000000000000111111;
                rotateAngle7 = 21'b000000000000000011111;
            end
            default : 
            begin
                rotateAngle  = 0; 
                rotateAngle1 = 0; 
                rotateAngle2 = 0;
                rotateAngle3 = 0;

                rotateAngle4 = 0;
                rotateAngle5 = 0; 
                rotateAngle6 = 0; 
                rotateAngle7 = 0;
                
            end		
        endcase
    end
    
    rotation_offset rotation_offset_unit_0( .x(x), .y(y), .z(z), .offsetX(offsetX), .offsetY(offsetY), .offsetZ(offsetZ), .rotate_index(rotate_index), .rotateAngle(rotateAngle)); 
    rotation_offset rotation_offset_unit_1( .x(x1), .y(y1), .z(z1), .offsetX(offsetX1), .offsetY(offsetY1), .offsetZ(offsetZ1), .rotate_index(rotate_index1), .rotateAngle(rotateAngle1));
    rotation_offset rotation_offset_unit_2( .x(x2), .y(y2), .z(z2), .offsetX(offsetX2), .offsetY(offsetY2), .offsetZ(offsetZ2), .rotate_index(rotate_index2), .rotateAngle(rotateAngle2));
    rotation_offset rotation_offset_unit_3( .x(x3), .y(y3), .z(z3), .offsetX(offsetX3), .offsetY(offsetY3), .offsetZ(offsetZ3), .rotate_index(rotate_index3), .rotateAngle(rotateAngle3));
    rotation_offset rotation_offset_unit_4( .x(x4), .y(y4), .z(z4), .offsetX(offsetX4), .offsetY(offsetY4), .offsetZ(offsetZ4), .rotate_index(rotate_index4), .rotateAngle(rotateAngle4));
    rotation_offset rotation_offset_unit_5( .x(x5), .y(y5), .z(z5), .offsetX(offsetX5), .offsetY(offsetY5), .offsetZ(offsetZ5), .rotate_index(rotate_index5), .rotateAngle(rotateAngle5));
    rotation_offset rotation_offset_unit_6( .x(x6), .y(y6), .z(z6), .offsetX(offsetX6), .offsetY(offsetY6), .offsetZ(offsetZ6), .rotate_index(rotate_index6), .rotateAngle(rotateAngle6));
    rotation_offset rotation_offset_unit_7( .x(x7), .y(y7), .z(z7), .offsetX(offsetX7), .offsetY(offsetY7), .offsetZ(offsetZ7), .rotate_index(rotate_index7), .rotateAngle(rotateAngle7));

    always@(*) begin
        rotate_index1 = rotate_index + 1'b1;
        x1 = x + offsetX;
        y1 = y + offsetY;
        z1 = z + offsetZ;
        rotate_index2 = rotate_index1 + 1'b1;
        x2 = x1 + offsetX1;
        y2 = y1 + offsetY1;
        z2 = z1 + offsetZ1;
        rotate_index3 = rotate_index2 + 1'b1;
        x3 = x2 + offsetX2;
        y3 = y2 + offsetY2;
        z3 = z2 + offsetZ2;
        rotate_index4 = rotate_index3 + 1'b1;
        x4 = x3 + offsetX3;
        y4 = y3 + offsetY3;
        z4 = z3 + offsetZ3;
        rotate_index5 = rotate_index4 + 1'b1;
        x5 = x4 + offsetX4;
        y5 = y4 + offsetY4;
        z5 = z4 + offsetZ4;
        rotate_index6 = rotate_index5 + 1'b1;
        x6 = x5 + offsetX5;
        y6 = y5 + offsetY5;
        z6 = z5 + offsetZ5;
        rotate_index7 = rotate_index6 + 1'b1;
        x7 = x6 + offsetX6;
        y7 = y6 + offsetY6;
        z7 = z6 + offsetZ6;
    end
    
   


    assign done = (rotate_index == 5'd16);

    always @(posedge clock) begin
        if (aclr) begin
            rotate_index <= 4'b0;
            x <= 21'b010011011011101001110;
            y <= 21'b0;
            z <= 21'b0;
        end 
        else if (clk_en) begin
            if (start) begin
                rotate_index <= 4'b0;
                x <= 21'b010011011011101001110;
                y <= 21'b0;
                z <= fixed_point_input;
            end
            else begin
                rotate_index <= rotate_index + 5'd8;
                x <= x7 + offsetX7;
                y <= y7 + offsetY7;
                z <= z7 + offsetZ7;
            end
        end
    end
    always@(*) begin
        $display("rotate_index ", rotate_index);
        $display("x: ", x);
        $display("y: ", y);
        $display("z: ", z);
    end

    //-------------------------------------------------------------
    // Fixed point to floating point
    //-------------------------------------------------------------
    // TODO: We can get rip off the last cycle if wanted.

    wire [20:0] fixed_point_result;
    wire [31:0] result_fp;

    assign fixed_point_result = (rotate_index==16 && !aclr) ? x : 21'b0;   // TODO: assign fixed_point_result = (rotate_index==15 && !aclr) ? x+offsetX : 21'b0;
    
    fixed_to_float fixed_to_float_unit( fixed_point_result, result_fp );
    
    assign result = result_fp;

endmodule



module rotation_offset(
    x,
    y,
    z,
    offsetX,
    offsetY,
    offsetZ,
    rotate_index,
    rotateAngle,
);
   
    input [20:0] x;
    input [20:0] y;
    input [20:0] z;
    input [4:0] rotate_index;
    input [20:0] rotateAngle;

    output  reg [20:0] offsetX;
    output  reg [20:0] offsetY;
    output  reg [20:0] offsetZ;
    always@(*) begin 
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