module bare_cordic(
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
	input	[20:0]  dataa; // this is the floating point input
	output	[20:0]  result;
    output          done;

    //-------------------------------------------------------------
    // FP to fixed-point
    //-------------------------------------------------------------
    // ignore the sign of the input as we know cosine is even
    wire [20:0] fixed_point_input;
    assign fixed_point_input = dataa;

    //-------------------------------------------------------------
    // CORDIC
    //-------------------------------------------------------------
    reg signed [20:0] x;
    reg signed [20:0] y;
    reg signed [20:0] z;

    wire signed [20:0] rot_x;
    wire signed [20:0] rot_y;
    wire signed [20:0] rot_z;

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

    assign done = (rotate_index == 5'd16);

    cordic_rot cr_0( .x(x), .y(y), .z(z), .rot_x(rot_x), .rot_y(rot_y), .rot_z(rot_z), .rotate_index(rotate_index), .rotate_angle(rotateAngle));

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

    wire [20:0] fixed_point_result;

    assign fixed_point_result = x;    
    assign result = fixed_point_result;

endmodule