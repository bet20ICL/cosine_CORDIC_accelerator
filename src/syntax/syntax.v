module tb();

    reg signed [15:0] x;
    reg [15:0] y;
    reg [15:0] z;
    reg [15:0] tmp;

    initial begin
        x = (32'h8000);
        y = (x >>> 1);
        z = y + 1'b1;
        tmp = (x >>> 1) + 2'sb1;
        $display("x: %h, y: %h, z: %h, tmp: %h", x, y, z, tmp);
    end


endmodule