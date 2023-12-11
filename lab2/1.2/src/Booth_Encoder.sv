import mod_dadda_mul_pkg::*;
module Booth_Encoder #(parameter NBIT = 11) (
    input wire [NBIT-1:0] A,
    input wire [NBIT-1:0] B,
    output signs_t S,
    output pp_t partial_products
);
    reg [2:0] B_temp[5:0];

    always_comb begin
        B_temp[0] = {B[1:0], 1'b0};
        B_temp[1] = {B[3:1]};
        B_temp[2] = {B[5:3]};
        B_temp[3] = {B[7:5]};
        B_temp[4] = {B[9:7]};
        B_temp[5] = {1'b0, B[10:9]};
    end

    always_comb begin
        for (int i = 0; i < 6; i++) begin
            case (B_temp[i])
                3'b000:  partial_products[i] = 0;
                3'b001:  partial_products[i] = {1'b0, A};
                3'b010:  partial_products[i] = {1'b0, A};
                3'b011:  partial_products[i] = {A,1'b0};
                3'b100:  partial_products[i] = ~{A, 1'b0};
                3'b101:  partial_products[i] = ~{1'b0, A};
                3'b110:  partial_products[i] = ~{1'b0, A};
                3'b111:  partial_products[i] = {NBIT + 1 {1'b1}};
                default:  partial_products[i] = {NBIT{1'b0}};
            endcase;
            S[i] = B_temp [i][2];
        end
    end

endmodule
