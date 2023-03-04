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
    inter_sig_debug);

	input	  aclr;
	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa;
	output	[31:0]  result;
    output [3:0] rotate_index_debug;
    output [31:0] x_debug;
    output [31:0] z_debug;
    output [31:0] fixed_point_input_debug;
    output [7:0] exponent_debug;
    output [31:0] inter_sig_debug;

//-------------------debug variable--------------------
    assign rotate_index_debug = rotate_index;
    assign x_debug = x;
    assign z_debug = z;
    assign fixed_point_input_debug = fixed_point_input;
    assign exponent_debug = exponent;
//-------------------debug variable--------------------

    wire sign; 
    wire [7:0] exponent; 
    wire [22:0] significand;
    
    assign sign = dataa[31];
    assign exponent = dataa[30:23];
    assign significand = dataa[22:0];
    
    wire [31:0] fixed_point_input;
    assign fixed_point_input = (exponent == 8'b0) ? 32'b0 : (({1'b1, significand, 8'b0}) >> (7'd127-exponent));

//-------------------------cordic----------------------------
    reg [31:0] offsetX;
    reg [31:0] offsetY;
    reg [31:0] offsetZ;

    reg [31:0] x;
    reg [31:0] y;
    reg [31:0] z;

    reg [3:0] rotate_index;
    reg [31:0] rotateAngle; 

    assign result = (rotate_index==10 && !aclr) ? x : 32'b0;
    
    always@(*) begin
        case(rotate_index)
            4'd0    : rotateAngle = 32'b01100100100001111110110101010000 ;
            4'd1    : rotateAngle = 32'b00111011010110001100111000001010 ;
            4'd2    : rotateAngle = 32'b00011111010110110111010111111000 ;
            4'd3    : rotateAngle = 32'b00001111111010101101110101001100 ;
            4'd4    : rotateAngle = 32'b00000111111111010101011011101101 ;
            4'd5    : rotateAngle = 32'b00000011111111111010101010110110 ;
            4'd6    : rotateAngle = 32'b00000001111111111111010101010100 ;
            4'd7    : rotateAngle = 32'b00000000111111111111111010101010 ;
            4'd8    : rotateAngle = 32'b00000000011111111111111111010101 ;
            4'd9    : rotateAngle = 32'b00000000001111111111111111111011 ;
            default : rotateAngle = 0; 		
        endcase
    end


    always @(*) begin
        if(z[31]==0) begin
            offsetX = ~(y >> rotate_index) + 1'b1;
            offsetY = x >> rotate_index;
            offsetZ = ~(rotateAngle) + 1'b1;
        end 
        else begin
            offsetX = y >> rotate_index;
            offsetY = ~(x >> rotate_index) + 1'b1;
            offsetZ = rotateAngle;
        end
    end

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
        end
    end
    //TODO: Conversion from fixed-point to floating-point


endmodule