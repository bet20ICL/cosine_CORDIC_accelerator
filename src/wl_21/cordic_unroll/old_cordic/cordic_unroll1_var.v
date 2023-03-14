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
    wire [20:0] fixed_point_input;
    floating_to_fixed floating_to_fixed_unit(.dataa(dataa), .fixed_point_input(fixed_point_input));


    //-------------------------------------------------------------
    // CORDIC
    //-------------------------------------------------------------
    reg signed [20:0] x;
    reg signed [20:0] y;
    reg signed [20:0] z;

    reg signed [20:0] offsetX;
    reg signed [20:0] offsetY;
    reg signed [20:0] offsetZ;

    reg [4:0] rotate_index;
    reg signed [20:0] rotateAngle; // in radian
    
    // LUT
    always@(*) begin
        case(rotate_index)             
            4'd0    : rotateAngle = 21'h0c90fe;
            4'd1    : rotateAngle = 21'h076b1a;
            4'd2    : rotateAngle = 21'h03eb6f;
            4'd3    : rotateAngle = 21'h01fd5c;
            4'd4    : rotateAngle = 21'h00ffab;
            4'd5    : rotateAngle = 21'h007ff5;
            4'd6    : rotateAngle = 21'h003fff;
            4'd7    : rotateAngle = 21'h002000;
            4'd8    : rotateAngle = 21'h001000;
            4'd9    : rotateAngle = 21'h000800;
            4'd10   : rotateAngle = 21'h000400;
            4'd11   : rotateAngle = 21'h000200;
            4'd12   : rotateAngle = 21'h000100;
            4'd13   : rotateAngle = 21'h000080;
            4'd14   : rotateAngle = 21'h000040;
            4'd15   : rotateAngle = 21'h000020;
            default : rotateAngle = 0; 		
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
                rotate_index <= rotate_index + 1'b1;
                x <= x + offsetX;
                y <= y + offsetY;
                z <= z + offsetZ;
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