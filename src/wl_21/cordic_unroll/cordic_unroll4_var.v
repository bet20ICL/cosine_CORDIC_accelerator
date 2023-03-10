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
    reg signed [20:0] x, x1, x2, x3;
    reg signed [20:0] y, y1, y2, y3;
    reg signed [20:0] z, z1, z2, z3;
   
    wire  [20:0] offsetX, offsetX1, offsetX2, offsetX3;
    wire  [20:0] offsetY, offsetY1, offsetY2, offsetY3;
    wire  [20:0] offsetZ, offsetZ1, offsetZ2, offsetZ3;
   
    reg [4:0] rotate_index, rotate_index1, rotate_index2, rotate_index3;
    reg signed [20:0] rotateAngle, rotateAngle1, rotateAngle2, rotateAngle3;
    
    // LUT
    always@(*) begin
        case(rotate_index)             
            4'd0    : 
            begin 
                rotateAngle  = 21'b011001001000011111101; 
                rotateAngle1 = 21'b001110110101100011001;
                rotateAngle2 = 21'b000111110101101101110;
                rotateAngle3 = 21'b000011111110101011011;
            end
            4'd4    : 
            begin 
                rotateAngle = 21'b000001111111110101010;
                rotateAngle1 = 21'b000000111111111110101;
                rotateAngle2 = 21'b000000011111111111110;
                rotateAngle3 = 21'b000000001111111111111;
            end
            4'd8    : 
            begin
                rotateAngle = 21'b000000000111111111111;
                rotateAngle1 = 21'b000000000011111111111;
                rotateAngle2 = 21'b000000000001111111111;
                rotateAngle3 = 21'b000000000000111111111;
            end
            4'd12   : 
            begin
                rotateAngle = 21'b000000000000011111111;
                rotateAngle1 = 21'b000000000000001111111;
                rotateAngle2 = 21'b000000000000000111111;
                rotateAngle3 = 21'b000000000000000011111;
            end
            default : 
            begin
                rotateAngle  = 0; 
                rotateAngle1 = 0; 
                rotateAngle2 = 0;
                rotateAngle3 = 0;
            end		
        endcase
    end
    
    rotation_offset rotation_offset_unit_0( .x(x), .y(y), .z(z), .offsetX(offsetX), .offsetY(offsetY), .offsetZ(offsetZ), .rotate_index(rotate_index), .rotateAngle(rotateAngle));
    always@(*) begin
        rotate_index1 = rotate_index + 1'b1;
        x1 = x + offsetX;
        y1 = y + offsetY;
        z1 = z + offsetZ;
    end
    rotation_offset rotation_offset_unit_1( .x(x1), .y(y1), .z(z1), .offsetX(offsetX1), .offsetY(offsetY1), .offsetZ(offsetZ1), .rotate_index(rotate_index1), .rotateAngle(rotateAngle1));
    always@(*) begin
        rotate_index2 = rotate_index1 + 1'b1;
        x2 = x1 + offsetX1;
        y2 = y1 + offsetY1;
        z2 = z1 + offsetZ1;
    end
    rotation_offset rotation_offset_unit_2( .x(x2), .y(y2), .z(z2), .offsetX(offsetX2), .offsetY(offsetY2), .offsetZ(offsetZ2), .rotate_index(rotate_index2), .rotateAngle(rotateAngle2));
    always@(*) begin
        rotate_index3 = rotate_index2 + 1'b1;
        x3 = x2 + offsetX2;
        y3 = y2 + offsetY2;
        z3 = z2 + offsetZ2;
    end
    rotation_offset rotation_offset_unit_3( .x(x3), .y(y3), .z(z3), .offsetX(offsetX3), .offsetY(offsetY3), .offsetZ(offsetZ3), .rotate_index(rotate_index3), .rotateAngle(rotateAngle3));

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
                rotate_index <= rotate_index + 5'd4;
                x <= x3 + offsetX3;
                y <= y3 + offsetY3;
                z <= z3 + offsetZ3;
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

    wire [20:0] fixed_point_result;
    wire [31:0] result_fp;

    assign fixed_point_result = x;
    
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