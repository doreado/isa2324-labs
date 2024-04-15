interface dut_if #(
    parameter fpnew_pkg::fpu_features_t Features = fpnew_pkg::RV16F,
    localparam int unsigned WIDTH = Features.Width,
    localparam int unsigned NUM_OPERANDS = 3
) (input clk, rst);

    logic [NUM_OPERANDS-1:0][WIDTH-1:0] operands_i;
    logic [WIDTH-1:0] A;
    logic [WIDTH-1:0] B;
    logic [WIDTH-1:0] C;
    logic [WIDTH-1:0] data;
    logic valid, ready;

    modport port_in (input clk, rst, A, B, C, valid, output ready);
    modport port_out (input clk, rst, output data, valid, ready);
endinterface

