`include "myTypes.sv" 

module ssram_wrap (
    input logic clk,
    input logic csb,        // chip select - active low
    input logic web,        // write enable -  active low
    input logic mem_sel,       // 0 - CODE, 1 - DATA
    input logic [ADDRESS_WIDTH-1:0] addr, 
    input logic [DATA_WIDTH-1:0] din,     
    output logic [DATA_WIDTH-1:0] dout     
);

    wire csb0, csb1;
    logic [DATA_WIDTH-1:0] dout_reg;

    always @* begin
        csb0 = (mem_sel == 1'b0) ? 1'b0 : 1'b1;
        csb1 = (mem_sel == 1'b0) ? 1'b1 : 1'b0;
    end

    sram_32_1024_freepdk45 IRAM (
        .clk0(clk),
        .csb0(csb0),
        .web0(web),
        .addr0(addr),
        .din0(din),
        .dout0(dout)
    );

    sram_32_1024_freepdk45 DRAM (
        .clk0(clk),
        .csb0(csb1),
        .web0(web),
        .addr0(addr),
        .din0(din),
        .dout0(dout)
    );

    always_ff @(posedge clk) begin
        dout <= dout_reg;               //delayed output
    end
    // put data from MEM into a register
    always_ff @(posedge clk) begin
        if (mem_sel)
            dout_reg <= DRAM.dout;
        else
            dout_reg <= IRAM.dout;

    //assign dout = mem_sel ? DRAM.dout : IRAM.dout;


endmodule
