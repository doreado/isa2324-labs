import myTypes::*;

module OBI_interface(

    input logic clk,
    input logic rst,
    // from CPU
    input logic IRAM_proc_req,
    input logic DRAM_proc_req,
    input logic [32-1:0] IRAM_addr,
    input logic [32-1:0] DRAM_addr,
    input logic [32-1:0] wdata,
    input logic web,        // write enable -  active low
    // from MEMORY
    input logic IRAM_rdy,
    input logic DRAM_rdy,
    input logic [32-1:0] IRAM_rdata,
    input logic [32-1:0] DRAM_rdata,
    input logic IRAM_valid_in,
    input logic DRAM_valid_in,
    // to MEMORY
    output logic [32-1:0] IRAM_addr_out,
    output logic [32-1:0] DRAM_addr_out,
    output logic web_out,
    output logic [32-1:0] wdata_out,
    //output logic proc_req_out,
    // to CPU
    output logic req_busy_out,
    output logic IRAM_rdy_out,
    output logic DRAM_rdy_out,
    output logic [32-1:0] IRAM_dout,
    output logic [32-1:0] DRAM_dout,
    output logic IRAM_valid_out,
    output logic DRAM_valid_out
);



    Fetcher F_0 (
        .clk(clk),
        .rst(rst),
        .proc_req_in(IRAM_proc_req),
        .addr_in(IRAM_addr),
        .mem_rdy(IRAM_rdy),
        // input
        .rdata(IRAM_rdata),
        .valid_in(IRAM_valid_in),           // 1 if using ssram
        // to CPU
        .data_out(IRAM_dout),
        .valid_out(IRAM_valid_out),
        .req_busy(req_busy_out),
        // to memories
        .addr_out(IRAM_addr_out)
    );

    LoadStoreUnit LSU (
        .clk(clk),
        .rst(rst),
        .proc_req_in(DRAM_proc_req),
        .addr_in(DRAM_addr),
        .wdata_in(wdata),
        .we_in(web),
        .mem_rdy(DRAM_rdy),
        // output
        .rdata(DRAM_rdata),
        .valid_in(DRAM_valid_in),
        // to CPU         
        .data_out(DRAM_dout),
        .valid_out(DRAM_valid_out),
        // to memories
        .addr_out(DRAM_addr_out),
        .we_out(web_out),
        .wdata_out(wdata_out)
    );
    

endmodule
