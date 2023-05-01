module full_fn_msgdma(
    clk,
    aclr,
    read,
    write,
    address,
    readdata,
    writedata
);

    // Avalon Clock Sink
    input clk;

    // Avalon Reset Sink 
    input aclr;

    // Avalon MM Slave
    input read;
    input write;
    input [1:0] address;
    input [31:0] writedata;
    output reg [31:0] readdata;

    // Internal
    reg [31:0] csr [3:0];

    // CSRs:
    // 0: control reg
    //     0: reset - resets the block 
    //     1: write_en - 
    //     2: start - start processing streamed elements
    // 1: input reg - how many elements to expect - move to progress reg
    // 2: status reg - some info about the status of the register
    // 3: progress reg - stores how many elements have been processed

    always @(posedge clk) begin
        if (aclr) begin
            readdata <= 32'h0;
            csr[0] <= 32'h0;
            csr[1] <= 32'h0;
            csr[2] <= 32'h3f800000; // 1.0
            csr[3] <= 32'h40000000; // 2.0
        end
        else begin
            // $display("ip: %h, add: %b, read: %b", csr[address], address, read);
            if (read) begin
                readdata <= csr[address];
            end 
            else if (write) begin
                csr[address] <= writedata;
            end
            
            // CSR Operation
        end
    end
    
endmodule