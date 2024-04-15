module HA ( input  a,
            input  b,
            output c_out,
            output sum);

   assign sum = a ^ b;
   assign c_out = a & b;
endmodule
