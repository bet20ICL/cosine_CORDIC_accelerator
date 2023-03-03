


module Cordic(
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
   
    assign fixed_point_input = (exponent == 0) ? 32'b0 : ({1'b1, significand} << 31) << (exponent - 7'd127);
    // assign fixed_point_input = {32{exponent == 0}} & (({1'b1, significand} << 31) << (exponent - 127));

    reg [31:0] x;
    reg [31:0] y;
    reg [31:0] z;
    reg [3:0] rotateIndex = 0; // 4 bits so the variable is enough to cover 10 rotation.

    assign result = (rotateIndex==9 && !aclr) ? x: 32'b0;

    //-------------------------------------cordic------------------------------------
    wire [31:0] rotateAngle; // in radian
    always@(*) begin
        case(rotateIndex)
            4'd0     : rotateAngle = 0.785 398 163; 		
            4'd1     : rotateAngle = 0.463 647 609; 		
            4'd2     : rotateAngle = 0.244 978 663; 		
            4'd3     : rotateAngle = 0.124 354 994; 		
            4'd4     : rotateAngle = 0.062 418 810; 		
            4'd5     : rotateAngle = 0.031 239 833; 		
            4'd6     : rotateAngle = 0.015 623 728; 		
            4'd7     : rotateAngle = 0.007 812 341; 		
            4'd8     : rotateAngle = 0.003 906 230; 		
            4'd9     : rotateAngle = 0.001 953 123; // convert to fixed point first somehow 	
            default  : rotateAngle = 0; 		
        endcase
    end

    //-------------------------------------cordic------------------------------------
    
    
    wire [32:0] offsetX;
    wire [32:0] offsetY;
    wire [32:0] offsetZ;


    always@(*) begin
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
    always @(posedge clk) begin
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
                x <= 0.607252935; //convert to fixed point first somehow 		
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