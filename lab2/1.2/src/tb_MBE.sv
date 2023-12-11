module tb_MBE;

  parameter NBIT = 11;
  // one additional bit to avoid overflow
  reg [11:0] a;
  reg [11:0] b;
  reg [21:0] result;
  reg [21:0] expected_result;
  reg end_i;


  MBE uut (
    .result(result),
    .a(a[10:0]),
    .b(b[10:0])
  );

  reg clk = 0;
  always #5 clk = ~clk;

  initial begin
    end_i = 0;
    for (a = 12'b000000000000; a < 12'b100000000000; a = a + 1) begin
      for (b = 12'b000000000000; b < 12'b100000000000; b = b + 1) begin
         expected_result = a[10:0] * b[10:0];
         #10;
     end
    end
    end_i = 1;
    $stop;
  end

  
  always @(posedge clk) begin
    if (result !== expected_result) begin
      $display("Mismatch: a=%0d, b=%0d, result=%0d, expected=%0d", a, b, result, expected_result);
      $stop;
    end
  end

endmodule
