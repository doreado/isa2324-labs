`include "myTypes.sv" 

module ssram_wrap (
    input logic clk,
    
    input logic proc_req_in,                        // chip select - active low 
    input logic [DATA_WIDTH-1:0] addr,
    input logic web,                        // write enable -  active low
    input logic [DATA_WIDTH-1:0] din,       // write data 

    output logic req_done,
    output logic dout,
    output logic valid
);

    wire csb0, web0, addr0;
    logic valid_reg;

    always_ff @(posedge clk) begin
        valid_reg <= proc_req_in;               // rise valid 1 cc later 
    end

    always_comb begin
        req_done = 1'b1;
        csb0 = ~proc_req_in;
        web0 = ~web;
        addr0 = {2'b0, addr[9:2]};
        valid = valid_reg;
    end 

    sram_32_1024_freepdk45 RAM (
        .clk0(clk),
        .csb0(csb0),
        .web0(web0),
        .addr0(addr),
        .din0(din),
        .dout0(dout)
    );


endmodule
