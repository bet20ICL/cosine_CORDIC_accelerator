


module Cordic(
    aclr,
	clk_en,
	clock,
	dataa,
	datab,
	result);

	input	  aclr;
	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa; // this is the floating point input
	input	[31:0]  datab;
	output	[31:0]  result;

    // decode floating point to fix point input using 32 bit fixed point.
    wire [31:0] fp_input = dataa;

    wire sign = fp_input[31];
    wire [7:0] exponent = fp_input[30:23];
    wire [22:0] significand = fp_input[22:0];
    
    wire unsigned [31:0] magnitude
    wire [31:0] fixed_point_input;
   
    assign magnitude = ({2'b01, significand} << 30) << (exponent - 127); // (1.significant 0000 0000) 32-bit 
    assign fixed_point_input = (sign==0)? magnitude: magnitude^32'hffffffff + 1 ;


    reg [] x;
    reg [] y;
    reg [] z;
    reg [3:0] rotateIndex; // 4 bits so the variable is enough to cover 10 rotation.
    reg [] clk_count;
    wire signOfz; // The sign of itermediate varibale, use for each operation.

    // TODO: Non pipeline version, initialise condition:  every 10 clock, fixed_point_input changed ... 
    // should i use initial here?
    always@(posedge clk) begin
        // initialise variable
        if(clk_count == 0) begin
            rotateIndex <= 0;
            x <= 0.607252935; // 1/K
            y <= 0;
            z <= fixed_point_input; // in radius
        end 

        clk_count <= clk_count + 1;
        if(clk_count == 10) clk_count <= 0;
    end

    //-------------------------------------cordic------------------------------------
    wire [] rotateAngle; // in radian
    always@(*) begin
        case(rotateIndex)
            4'd0    : rotateAngle = 0.785 398 163; 		
            4'd1    : rotateAngle = 0.463 647 609; 		
            4'd2    : rotateAngle = 0.244 978 663; 		
            4'd3    : rotateAngle = 0.124 354 994; 		
            4'd4    : rotateAngle = 0.062 418 810; 		
            4'd5    : rotateAngle = 0.031 239 833; 		
            4'd6    : rotateAngle = 0.015 623 728; 		
            4'd7    : rotateAngle = 0.007 812 341; 		
            4'd8    : rotateAngle = 0.003 906 230; 		
            4'd9    : rotateAngle = 0.001 953 123; 		
            default  : out = 0; 		
        endcase
    end

    //-------------------------------------cordic------------------------------------

    reg [] 
    always@(posedge clk) begin

        
    end


    endmodule