module RCA(output [21:0] sum, output cout, input [21:0] a, b);
  
  wire [21:1] c;
  genvar i;
  FA fa0(a[0], b[0], 0, c[1], sum[0]);
  generate
    for ( i=1; i<21;i++) begin
        FA fa_i (a[i],b[i],c[i],c[i+1],sum[i]);
    end
  endgenerate

  FA fa21 (a[21],b[21],c[21],cout,sum[21]);
  
endmodule