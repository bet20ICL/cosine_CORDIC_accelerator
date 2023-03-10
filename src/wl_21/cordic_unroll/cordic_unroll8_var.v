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
    // always@(*) begin
    //     $display("rotate_index ", rotate_index);
    //     $display("x: ", x);
    //     $display("y: ", y);
    //     $display("z: ", z);
    // end

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
   
    input signed [20:0] x;
    input signed [20:0] y;
    input signed [20:0] z;
    input unsigned [4:0] rotate_index;
    input signed [20:0] rotateAngle;

    output reg [20:0] offsetX;
    output reg [20:0] offsetY;
    output reg [20:0] offsetZ;
    always@(*) begin 
        if(z[20]==0) begin
            offsetX = -(y >>> rotate_index);
            offsetY = x >>> rotate_index;
            offsetZ = -rotateAngle;
        end 
        else begin
            offsetX = y >>> rotate_index;
            offsetY = -(x >>> rotate_index);
            offsetZ = rotateAngle;
        end
    end
endmodule