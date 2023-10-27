`timescale 1ns / 1ps

module tb;

  parameter Nb = 8;

  // Port declarations
  reg [Nb-1:0] DIN;
  wire [Nb-1:0] DOUT;
  wire [Nb-1:0] B [8:0];
  wire VIN;
  wire VOUT;
  reg CLK;
  reg RST_n;
  wire END_SIM;

  // Instantiate the FIR_Filter module
  FIR_Filter UUT (
    .DIN(DIN),
    .DOUT(DOUT),
    .B(B),
    .VIN(VIN),
    .VOUT(VOUT),
    .CLK(CLK),
    .RST_n(RST_n)
  );

  // Instantiate the data_maker module
  data_maker data (
    .CLK(CLK),
    .RST_n(RST_n),
    .VOUT(VIN),
    .DOUT(DIN),
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
    .VIN(VIN),
    .DIN(DIN)
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
    $monitor("DIN = %h, DOUT = %h, B = %h, VIN = %b, VOUT = %b, CLK = %b, RST_n = %b", DIN, DOUT, B, VIN, VOUT, CLK, RST_n);

    // Add testbench stimulus and checks as needed
    


    // End the simulation
    $finish;
  end

endmodule : tb
