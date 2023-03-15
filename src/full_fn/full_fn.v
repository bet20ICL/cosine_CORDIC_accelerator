module full_fn(
    aclr,
	clk_en,
	clock,
	dataa,
	result,
    start,
    done, 
    // avalon master signals - to DMA control port
    dma_ctl_address,
    dma_ctl_chipselect,
    dma_ctl_readdata,
    dma_ctl_write_n,           
    dma_ctl_writedata,      
    // avalon slave signals - from DMA write master
    dma_wm_address,
    dma_wm_chipselect,
    dma_wm_waitrequest,
    dma_wm_write_n,           
    dma_wm_write_data 
    );

    input	        aclr;
	input	        clk_en;
	input	        clock;
    input           start;
	input	[31:0]  dataa; // the base address of the array to access
	output	[31:0]  result;
    output          done;

    // avalon master signals - to DMA control port
    output [2:0] dma_ctl_address;
    output dma_ctl_chipselect;
    input [31:0] dma_ctl_readdata;
    output dma_ctl_write_n;           
    output [31:0] dma_ctl_writedata;

    // avalon slave signals - from DMA write master
    input [4:0] dma_wm_address;
    input dma_wm_chipselect;
    output dma_wm_waitrequest;
    input dma_wm_write_n;           
    input [7:0] dma_wm_write_data;

    

endmodule
