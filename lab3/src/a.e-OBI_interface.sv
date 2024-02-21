`include "myTypes.sv" 

module obi_interface(
    input logic clk,
    input logic rst,
    // from CPU
    input logic proc_req,
    input logic [ADDRESS_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] wdata,
    input logic web,        // write enable -  active low
    input logic mem_sel,       // 0 - CODE, 1 - DATA
    // to CPU
    output logic [DATA_WIDTH-1:0] dout,
    output logic valid
    
);

    wire csb0, csb1;        // chip select (USE AS ENABLE SIGNAL FOR MEMORIES)
    wire [DATA_WIDTH-1:0] IRAM_output, DRAM_output;
    wire [DATA_WIDTH-1:0] LSU_addr, F0_ADDR; 
    wire [DATA_WIDTH-1:0] LSU_wdata;   
    wire LSU_we;

    always @* begin
        csb0 = (mem_sel == 1'b0) ? 1'b0 : 1'b1;
        csb1 = (mem_sel == 1'b0) ? 1'b1 : 1'b0;
    end

    Fetcher F_0 (
        .clk(clk),
        .rst(rst),
        .proc_req_in(proc_req),
        .addr_in(addr),
        .mem_rdy(1),
        // output
        .rdata(IRAM_output),
        .valid_in(1),
        // to CPU
        .data_out(dout),
        .valid_out(valid),
        // to memories
        .addr_out(F0_ADDR)
    );

    LoadStoreUnit LSU (
        .clk(clk),
        .rst(rst),
        .proc_req_in(proc_req),
        .addr_in(addr),
        .wdata_in(wdata),
        .we_in(web),
        .mem_rdy(1),
        // output
        .rdata(DRAM_output),
        .valid_in(1),
        // to CPU         
        .data_out(dout),
        .valid_out(valid),
        // to memories
        .addr_out(LSU_addr),
        .we_out(LSU_we),
        .wdata_out(LSU_wdata)
    );
    
    // INSTANTIATE MEMORIES HERE (SSRAM or mem_fake_wrapper)

    /*
    ssram_wrap memories (
        .clk(clk),
        .csb(mem_sel),
        .web()
    );
    */

endmodule
