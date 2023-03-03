


module cordic(
    aclr,
	clk_en,
	clock,
	dataa,
	result);

	input	  aclr;
	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa; // this is the floating point input
	output	[31:0]  result;

    // decode floating point to fix point input using 32 bit fixed point.
    wire [31:0] fp_input = dataa;

    wire sign = fp_input[31];
    wire [7:0] exponent = fp_input[30:23];
    wire [22:0] significand = fp_input[22:0];
    
    wire [31:0] fixed_point_input;
   
    assign fixed_point_input = (exponent == 7'b0) ? 32'b0 : ({1'b1, significand} << 5'd31) << (exponent - 7'd127);
    // assign fixed_point_input = {32{exponent == 7'b0}} & (({1'b1, significand} << 7'd31) << (exponent - 7'd127));

    reg [31:0] x;
    reg [31:0] y;
    reg [31:0] z;
    reg [3:0] rotateIndex; // 4 bits so the variable is enough to cover 10 rotation.

    assign result = (rotateIndex==9 && !aclr) ? x: 32'b0;

    //-------------------------------------cordic------------------------------------
    reg [31:0] rotateAngle; // in radian
    always@(*) begin
        case(rotateIndex)
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

    //-------------------------------------cordic------------------------------------
    
    
    reg [32:0] offsetX;
    reg [32:0] offsetY;
    reg [32:0] offsetZ;


    always @(*) begin
        if(z>0)begin
            offsetX = ~(y >> rotateIndex) + 1'b1;
            offsetY = x >> rotateIndex;
            offsetZ = ~(rotateAngle) + 1'b1;
        end 
        else begin
            offsetX = y >> rotateIndex;
            offsetY = ~(x >> rotateIndex) + 1'b1;
            offsetZ = rotateAngle;
        end
    end

    // TODO: Non pipeline version, initialise condition:  every 10 clock, fixed_point_input changed ... 
    always @(posedge clock) begin
        if (aclr) begin
            rotateIndex <= 4'b0;
            x <= 32'b0;
            y <= 32'b0;
            z <= 32'b0;
        end 
        else if (clk_en) begin
            if (rotateIndex == 4'd9) begin
                // initialise variable
                rotateIndex <= 4'd0;
                x <= 32'b01001101101110100111011011010100; //convert to fixed point first somehow 		
                y <= 32'b0;
                z <= fixed_point_input; // in radius
            end 
            else begin
                rotateIndex <= rotateIndex + 1'b1;
                x <= x + offsetX;
                y <= y + offsetY;
                z <= z + offsetZ;
            end 
        end
    end


    endmodule