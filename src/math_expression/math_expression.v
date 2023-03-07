module math_expression (
    x,
    clk,
    clk_en,
    reset,
    f_x
);
    input clk;
    input clk_en;
    input reset;
    input [31:0] x;
	output [31:0] f_x;


    reg [31:0] cordic_input;
    reg shortreal cordic_output;
    assign cordic_input  = ((x - 128) / 128);
	

    
    // need 16 clk 
    cordic unit(
                .aclr(reset),
                .clk_en(clk_en),
                .clock(clk),
                .dataa(cordic_input),
                .result(cordic_output)
            );
        
    reg [4:0] clock_counter;
    always@(posedge clk) begin
        if(reset) begin
            clock_counter <= 0;

        end else if (clk_en) begin

        end
    end
   
   always@(*) begin
    if(clock_counter == 16) begin
       $display(x*0.5 + x*x*cordic_output);
    end
   end

endmodule


fp_multiplier(
    a,
    b,
    
);
