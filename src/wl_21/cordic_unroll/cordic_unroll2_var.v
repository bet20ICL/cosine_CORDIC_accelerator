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
    reg signed [20:0] x;
    reg signed [20:0] y;
    reg signed [20:0] z;
    reg signed [20:0] x1;
    reg signed [20:0] y1;
    reg signed [20:0] z1;

    reg signed [20:0] offsetX;
    reg signed [20:0] offsetY;
    reg signed [20:0] offsetZ;
    reg signed [20:0] offsetX1;
    reg signed [20:0] offsetY1;
    reg signed [20:0] offsetZ1;
   
    reg [4:0] rotate_index;
    reg [4:0] rotate_index1;
    reg signed [20:0] rotateAngle; // in radian
    reg signed [20:0] rotateAngle1; // in radian
    
    // LUT
    always@(*) begin
        case(rotate_index)             
            4'd0    : 
            begin 
                rotateAngle  = 21'b011001001000011111101; 
                rotateAngle1 = 21'b001110110101100011001;
            end
            4'd2    : 
            begin 
                rotateAngle = 21'b000111110101101101110;
                rotateAngle1 = 21'b000011111110101011011;
            end
            4'd4    : 
            begin 
                rotateAngle = 21'b000001111111110101010;
                rotateAngle1 = 21'b000000111111111110101;
            end
            4'd6    : 
            begin
                rotateAngle = 21'b000000011111111111110;
                rotateAngle1 = 21'b000000001111111111111;
            end
            4'd8    : 
            begin
                rotateAngle = 21'b000000000111111111111;
                rotateAngle1 = 21'b000000000011111111111;
            end
            4'd10   : 
            begin
                rotateAngle = 21'b000000000001111111111;
                rotateAngle1 = 21'b000000000000111111111;
            end
            4'd12   : 
            begin
                rotateAngle = 21'b000000000000011111111;
                rotateAngle1 = 21'b000000000000001111111;
            end
            4'd14   : 
            begin
                rotateAngle = 21'b000000000000000111111;
                rotateAngle1 = 21'b000000000000000011111;
            end
            default : 
            begin
                rotateAngle = 0; 
                rotateAngle1 = 0; 
            end		
        endcase
    end
    
    always @(*) begin
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

        rotate_index1 = rotate_index + 1'b1;
        x1 = x + offsetX;
        y1 = y + offsetY;
        z1 = z + offsetZ;

        if(z1[20]==0) begin
            offsetX1 = -(y1 >>> rotate_index1);
            offsetY1 = x1 >>> rotate_index1;
            offsetZ1 = -rotateAngle1;
        end 
        else begin
            offsetX1 = y1 >>> rotate_index1;
            offsetY1 = -(x1 >>> rotate_index1);
            offsetZ1 = rotateAngle1;
        end
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
                rotate_index <= rotate_index + 5'd2;
                x <= x1 + offsetX1;
                y <= y1 + offsetY1;
                z <= z1 + offsetZ1;
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
