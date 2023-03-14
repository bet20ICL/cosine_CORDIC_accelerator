module rotation_offset(
    x,
    y,
    z,
    offsetX,
    offsetY,
    offsetZ,
    rotate_index,
    rotateAngle,
);
   
    input signed [20:0] x;
    input signed [20:0] y;
    input signed [20:0] z;
    input unsigned [4:0] rotate_index;
    input signed [20:0] rotateAngle;

    output reg [20:0] offsetX;
    output reg [20:0] offsetY;
    output reg [20:0] offsetZ;
    always@(*) begin 
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
endmodule

module cordic_rot(
    x,
    y,
    z,
    rot_x,
    rot_y,
    rot_z,
    rotate_index,
    rotate_angle
);
    input signed [20:0] x;
    input signed [20:0] y;
    input signed [20:0] z;
    input unsigned [4:0] rotate_index;
    input signed [20:0] rotate_angle;

    output reg [20:0] rot_x;
    output reg [20:0] rot_y;
    output reg [20:0] rot_z;

    reg [20:0] z_replicated; 
    reg [20:0] x_shift;
    reg [20:0] y_shift;
    always@(*) begin 
        z_replicated = {21{z[20]}};
        y_shift = (y>>>rotate_index);
        x_shift = (x>>rotate_index);
        rot_x = x + (y_shift ^ ~z_replicated) + !z[20]; 
        rot_y = y + (x_shift ^ z_replicated) + z[20]; 
        rot_z = z + (rotate_angle ^ ~z_replicated) + !z[20]; 
    end
endmodule