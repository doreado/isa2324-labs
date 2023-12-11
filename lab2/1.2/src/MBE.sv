import mod_dadda_mul_pkg::*;
module MBE (output [21:0] result, input [10:0] a, b);

pp_t partial_products;
wire [5:0] s; 
wire [21:0] res1,res2,res;

Booth_Encoder encoder (a,b,s,partial_products);
mod_dadda_tree dadda (partial_products,s[4:0],res1,res2);
RCA adder (res,cout,res1,res2);
assign result = res;


endmodule