module cordic_rot_param(
     x,
     y,
     z,
     x_out,
     y_out,
     z_out
 );
     parameter   [3:0]       rotate_index = 4'b1;
     parameter   [20:0]      rotate_angle = 21'b0;
                
     input signed [20:0] x;
     input signed [20:0] y;
     input signed [20:0] z;

     output reg signed [20:0] x_out;
     output reg signed [20:0] y_out;
     output reg signed [20:0] z_out;

     reg [20:0] z_replicated; 
     reg [20:0] x_shift;
     reg [20:0] y_shift;

     always@(*) begin 
         z_replicated = {21{z[20]}};
         y_shift = (y>>>rotate_index);
         x_shift = (x>>rotate_index);
         x_out = x + (y_shift ^ ~z_replicated) + !z[20]; 
         y_out = y + (x_shift ^ z_replicated) + z[20]; 
         z_out = z + (rotate_angle ^ ~z_replicated) + !z[20]; 
     end

 endmodule