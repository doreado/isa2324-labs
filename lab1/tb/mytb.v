`timescale 1ns / 1ps

module tb;

  parameter Nb = 9;

  // Port declarations
  wire [Nb-1:0] datamaker_DOUT;
  wire [Nb-1:0] filter_DOUT;
  wire [Nb-1:0] B [8:0];
  wire filter_VOUT;
  wire datamaker_VOUT;
  wire CLK;
  wire RST_n;
  wire END_SIM;

  // Instantiate the FIR_Filter module
  FIR_Filter UUT (
    .DIN(datamaker_DOUT),
    .DOUT(filter_DOUT),
    .B(B),
    .VIN(datamaker_VOUT),
    .VOUT(filter_VOUT),
    .CLK(CLK),
    .RST_n(RST_n)
  );

  // Instantiate the data_maker module
  data_maker data (
    .CLK(CLK),
    .RST_n(RST_n),
    .VOUT(datamaker_VOUT),
    .DOUT(datamaker_DOUT),
    .B0(B[0]),
    .B1(B[1]),
    .B2(B[2]),
    .B3(B[3]),
    .B4(B[4]),
    .B5(B[5]),
    .B6(B[6]),
    .B7(B[7]),
    .B8(B[8]),
    .END_SIM(END_SIM)
  );

  data_sink datacmp (
    .CLK(CLK),
    .RST_n(RST_n),
    .VIN(datamaker_VOUT),
    .DIN(filter_DOUT)
  ); 

  // Instantiate the clk_gen module
  clk_gen clock (
    .END_SIM(END_SIM),
    .CLK(CLK),
    .RST_n(RST_n)
  );

  // Testbench logic
  initial begin
    // Initialize signals and variables if needed

    // Simulation control
    $display("Starting simulation");
    $monitor("DIN = %h, DOUT = %h, B = %p, VIN = %p, VOUT = %p, CLK = %b, RST_n = %b", datamaker_DOUT, filter_DOUT, B, datamaker_VOUT, filter_VOUT, CLK, RST_n);

    // Add testbench stimulus and checks as needed
    

end

endmodule : tb
