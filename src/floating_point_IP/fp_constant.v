module fp_half(
   dataa,
   result,
);
    input [31:0] dataa;
    output wire [31:0] result;

    wire [7:0] exponent; 
    assign exponent = dataa[30:23];
    

    assign result = (exponent == 8'd0) ? 32'b0 : ({dataa[31],exponent-8'b1,dataa[22:0]});

endmodule





module fp_div_128(
   dataa,
   result,
);
    input [31:0] dataa;
    output wire [31:0] result;

    wire [7:0] exponent; 
    assign exponent = dataa[30:23];
    
    // assign result = (exponent < 8'd7) ? 32'b0 : ({dataa[31],exponent-8'd7,dataa[22:0]});
    // bitwire or to check if exponent is smaller than 7.
    assign result = (exponent[7]|exponent[6]|exponent[5]|exponent[4]|exponent[3]) ? ({dataa[31],exponent-8'd7,dataa[22:0]}) : 32'b0 ;

endmodule