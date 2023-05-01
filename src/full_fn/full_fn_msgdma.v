module full_fn_msgdma(
    clk,
    aclr,
    read,
    address,
    readdata
);

    input clk;
    input aclr;
    input read;
    input address;
    output reg [31:0] readdata;

    reg [31:0] control_regs [1:0];

    always @(*) begin
        control_regs[0] = 32'h3f800000; // 1.0
        control_regs[1] = 32'h40000000; // 2.0
    end

    always @(posedge clk) begin
        if (aclr) begin
            readdata <= 32'h0;
        end
        else if (read) begin
            readdata <= control_regs[address];
        end
    end
    
endmodule