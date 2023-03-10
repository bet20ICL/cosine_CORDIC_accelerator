module cordic_operation(
    x,
    y,
    z,
    x_out,
    y_out,
    z_out,
    // rotate_index,
    // rotateAngle // in radian
);
    parameter   [3:0]       rotate_index = 4'b1,
                [20:0]      rotateAngle = 21'b0;

    input signed [20:0] x;
    input signed [20:0] y;
    input signed [20:0] z;

    output reg signed [20:0] x_out;
    output reg signed [20:0] y_out;
    output reg signed [20:0] z_out;

    // input  [4:0] rotate_index;
    // input signed [20:0] rotateAngle;

    reg signed [20:0] offsetX;
    reg signed [20:0] offsetY;
    reg signed [20:0] offsetZ;

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

        x_out = x + offsetX;
        y_out = y + offsetY;
        z_out = z + offsetZ;
    end

endmodule

module tb();

    // reg signed [15:0] x;
    // reg [15:0] y;
    // reg [15:0] z;
    // reg [15:0] tmp;

    // initial begin
    //     x = (32'h8000);
    //     y = (x >>> 1);
    //     z = y + 1'b1;
    //     tmp = (x >>> 1) + 2'sb1;
    //     $display("x: %h, y: %h, z: %h, tmp: %h", x, y, z, tmp);
    // end


    // reg [20:0] x;
    // reg [20:0] y;
    // reg [20:0] z;

    // wire [20:0] x_out;
    // wire [20:0] y_out;
    // wire [20:0] z_out;

    $display("angle: %d", 16'h011001001000011111101);
    

endmodule