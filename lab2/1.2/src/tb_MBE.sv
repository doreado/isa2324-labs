module tb_MBE;

  parameter NBIT = 11;
  reg [10:0] a;
  reg [10:0] b;
  wire [21:0] result;
  reg [21:0] expected_result;

  MBE uut (
    .result(result),
    .a(a),
    .b(b)
  );

  reg clk = 0;
  always #5 clk = ~clk;

  initial begin

    a = 11'b11011011011;
    b = 11'b00000000001;
    expected_result = a * b;
    
    #10 a = 11'b11011011011;
    b = 11'b10101010101;
    expected_result = a * b;

    #10 a = 11'b10101010101;
    b = 11'b11011011011;
    expected_result = a * b;

    #10 a = 11'b01101101100;
    b = 11'b00110011001;
    expected_result = a * b;

    #10 $stop;
  end

  
  always @(posedge clk) begin
    if (result !== expected_result) begin
      $display("Mismatch: result=%0d, expected=%0d", result, expected_result);
      $stop;
    end
  end

endmodule
