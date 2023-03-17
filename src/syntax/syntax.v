// module cordic_operation(
//     x,
//     y,
//     z,
//     x_out,
//     y_out,
//     z_out,
//     // rotate_index,
//     // rotateAngle // in radian
// );
//     parameter   [3:0]       rotate_index = 4'b1,
//                 [20:0]      rotateAngle = 21'b0;

//     input signed [20:0] x;
//     input signed [20:0] y;
//     input signed [20:0] z;

//     output reg signed [20:0] x_out;
//     output reg signed [20:0] y_out;
//     output reg signed [20:0] z_out;

//     // input  [4:0] rotate_index;
//     // input signed [20:0] rotateAngle;

//     reg signed [20:0] offsetX;
//     reg signed [20:0] offsetY;
//     reg signed [20:0] offsetZ;

//     always @(*) begin
//         if(z[20]==0) begin
//             offsetX = -(y >>> rotate_index);
//             offsetY = x >>> rotate_index;
//             offsetZ = -rotateAngle;
//         end 
//         else begin
//             offsetX = y >>> rotate_index;
//             offsetY = -(x >>> rotate_index);
//             offsetZ = rotateAngle;
//         end

//         x_out = x + offsetX;
//         y_out = y + offsetY;
//         z_out = z + offsetZ;
//     end

// endmodule

// module rotation_offset(
//     x,
//     y,
//     z,
//     offsetX,
//     offsetY,
//     offsetZ,
//     rotate_index,
//     rotateAngle,
// );
   
//     input signed [20:0] x;
//     input signed [20:0] y;
//     input signed [20:0] z;
//     input unsigned [4:0] rotate_index;
//     input signed [20:0] rotateAngle;

//     output reg [20:0] offsetX;
//     output reg [20:0] offsetY;
//     output reg [20:0] offsetZ;
//     always@(*) begin 
//         if(z[20]==0) begin
//             offsetX = -(y >>> rotate_index);
//             offsetY = x >>> rotate_index;
//             offsetZ = -rotateAngle;
//         end 
//         else begin
//             offsetX = y >>> rotate_index;
//             offsetY = -(x >>> rotate_index);
//             offsetZ = rotateAngle;
//         end
//     end
// endmodule

// module addsub(
//     x,
//     y,
//     s,
//     q,
// );
//     parameter WIDTH = 32;
//     input [WIDTH-1:0] x;
//     input [WIDTH-1:0] y;
//     input s;
//     output [WIDTH-1:0] q;

//     // always @(*) begin
//     //     $display("%d", s);
//     // end

//     assign q = (x>>1) + (y ^ {WIDTH{s}}) + s;

// endmodule

// module addsub_offset(
//     x,
//     y,
//     z,
//     rot_x,
//     // rot_y,
//     // rot_z,
//     rotate_index
//     // rotate_angle
// );
   
//     input signed [20:0] x;
//     input signed [20:0] y;
//     input signed [20:0] z;
//     input unsigned [4:0] rotate_index;
//     // input signed [20:0] rotate_angle;

//     output reg [20:0] rot_x;
//     // output reg [20:0] rot_y;
//     // output reg [20:0] rot_z;

//     reg signed [20:0] z_replicated; 
//     reg signed [20:0] x_shift;
//     wire top_z;
//     wire not_top_z;
//     assign top_z = z[20];
//     assign not_top_z = ~z[20];
//     // reg signed [20:0] y_shift;
//     // reg signed [20:0] z_shift;
//     always@(*) begin 
//         z_replicated = {21{z[20]}};
//         x_shift = (y>>>rotate_index);
//         // y_shift = (x>>>rotate_index);
//         // z_shift = (rotate_angle>>>rotate_index);
//         $display("z[20]: %h", !z[20]);
//         // $display("xor: %h", x_shift ^ (~z_replicated)+1);

//         // rot_x = x + x_shift ^ (~z_replicated); 
//         rot_x = x + (x_shift ^ (~z_replicated)) + !z[20];
//         // rot_y = y + (y_shift ^ z_replicated) + z[20]; 
//         // rot_z = z + (z_shift ^ ~z_replicated) + ~z[20]; 
//         // x <= x + ((y>>>rotate_index) ^ {32{~z[20]}}) + ~z[20];
//         // y <= y + ((x>>>rotate_index) ^ {32{z[20]}}) + z[20];
//         // z <= z + ((rotateAngle>>>rotate_index) ^ {32{~z[20]}}) + ~z[20];
//     end

//     reg signed [20:0] offsetX;

//     always@(*) begin
//         if(z[20]==0) begin
//             offsetX = -(y >>> rotate_index);
//         end 
//         else begin
//             offsetX = y >>> rotate_index;
//         end
//         $display("offsetX: %h", offsetX);
//     end
// endmodule



module tb();

    reg [2:0] a;
    reg [2:0] b;
    reg [2:0] nb;
    reg [3:0] c;

    assign nb = ~b + 1;
    
    initial begin
        a = 3'd7;
        b = 3'd4;
        #1;
        c = a + nb;
        $display("%b, %b, %b, %b", a, b, nb, c);
        $display("%d, %d, %d, %d", a, b, nb, c);
    end

    // parameter A = 4;
    // parameter B = $clog2(A);
    // reg signed [15:0] x;
    // reg [15:0] y;
    // reg signed [15:0] z;
    // reg [15:0] tmp;
    // reg signed s;
    // wire [15:0] q;

    // addsub #(.WIDTH(16)) dut(
    //     .x(x),
    //     .y(y),
    //     .s(s),
    //     .q(q)
    // );

    // initial begin

    //     $display("A: %d, B: %d", A, B);
        // x = (32'h8002);
        // y = 32'h2;
        // s = 1'b0;
        // #1
        // z = (x>>>1);
        // // z = ((x>>>1) ^ {32{s}});
        // #2;
        // $display("x: %h, y: %h, q: %h, z: %h", x, y, q, z);

        // s = 1'b1;
        // #1
        // z = (x>>>1);
        // // z = ((x>>>1) ^ {32{s}}) + s;
        // #2;
        // $display("x: %h, y: %h, q: %h, z: %h", x, y, q, z);
    // end


    // reg [20:0] x;
    // reg [20:0] y;
    // reg [20:0] z;
    // reg [4:0] rotate_index;

    // wire [20:0] rot_x;
    // // wire [20:0] y_out;
    // // wire [20:0] z_out;

    // reg [20:0] t;
    // reg [20:0] f;
    // reg [20:0] g;
    // wire topf;
    // assign topf = f[20];

    // addsub_offset unit(.x(x), .y(y), .z(z), .rotate_index(rotate_index), .rot_x(rot_x));
    // initial begin
    //     x = 21'h0;
    //     y = 21'h100000;
    //     z = 21'h000000;
    //     rotate_index = 5'h2;

    //     #1;
    //     $display("x: %h, y: %h, z: %h, rotate_index: %h, rot_x: %h, top: %b", x, y, z, rotate_index, rot_x, z[20]);
    //     t = 21'h1ffff;
    //     f = 21'h000000;
    //     #1;
    //     g = t + (~f[20]);
    //     $display("t:%h, f:%h, g:%h", t, ~f[20], g);



    // end
    // $display("angle: %d", 16'h011001001000011111101);

endmodule