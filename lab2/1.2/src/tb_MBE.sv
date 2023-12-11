module tb_MBE;

  parameter NBIT = 11;
  reg [10:0] a;
  reg [10:0] b;
  reg [21:0] result;
  reg [21:0] expected_result;

  MBE uut (
    .result(result),
    .a(a),
    .b(b)
  );

  reg clk = 0;
  always #5 clk = ~clk;

  initial begin
    for (a = 11'b00000000000; a <= 11'b11111111111; a = a + 1) begin
      for (b = 11'b00000000000; b <= 11'b11111111111; b = b + 1) begin
         expected_result = a * b;
         #10;
     end
    end
  end

  
  always @(posedge clk) begin
    if (result !== expected_result) begin
      $display("Mismatch: a=%0d, b=%0d, result=%0d, expected=%0d", a, b, result, expected_result);
    end
  end

endmodule
