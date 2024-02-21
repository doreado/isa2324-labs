`include "myTypes.sv" 

module obi_interface(
    input logic clk,
    input logic rst,
    // from CPU
    input logic IRAM_proc_req,
    input logic DRAM_proc_req,
    input logic [ADDRESS_WIDTH-1:0] IRAM_addr,
    input logic [ADDRESS_WIDTH-1:0] DRAM_addr,
    input logic [DATA_WIDTH-1:0] wdata,
    input logic web,        // write enable -  active low
    // from MEMORY
    input logic IRAM_rdy,
    input logic DRAM_rdy,
    input logic [DATA_WIDTH-1:0] IRAM_rdata,
    input logic [DATA_WIDTH-1:0] DRAM_rdata,
    input logic IRAM_valid_in,
    input logic DRAM_valid_in,
    // to MEMORY
    output logic [ADDRESS_WIDTH-1:0] IRAM_addr_out,
    output logic [ADDRESS_WIDTH-1:0] DRAM_addr_out,
    output logic web_out,
    output logic wdata_out,
    // to CPU
    output logic [DATA_WIDTH-1:0] IRAM_dout,
    output logic [DATA_WIDTH-1:0] DRAM_dout,
    output logic IRAM_valid_out,
    output logic DRAM_valid_out
);

    
    /*
    always @* begin
        csb0 = (mem_sel == 1'b0) ? 1'b0 : 1'b1;
        csb1 = (mem_sel == 1'b0) ? 1'b1 : 1'b0;
    end
    */
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
