interface dut_if #(
  parameter fpnew_pkg::fpu_features_t       Features       = fpnew_pkg::RV16F,		   
  parameter fpnew_pkg::fpu_implementation_t Implementation = fpnew_pkg::ISA_PIPE,
  parameter type                            TagType        = logic,
  // Do not change
  localparam int unsigned WIDTH        = Features.Width,
  localparam int unsigned NUM_OPERANDS = 3
 ) (input clk, rst);

    input logic [NUM_OPERANDS-1:0][WIDTH-1:0] operands_i,
      logic [WIDTH-1:0]
      logic valid, ready;

      modport port_in (input clk, rst, operands, B, valid, output ready);
      modport port_out (input clk, rst, output result, valid);
  endinterface

