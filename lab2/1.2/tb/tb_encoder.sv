`timescale 1ns/1ps
module testbench;

    
    parameter NBIT = 11;

    
    reg [NBIT-1:0] A;
    reg [NBIT-1:0] B;
    logic [5:0] S;
    logic [5:0][NBIT:0] partial_prod;

    /*
    ENCODER #(NBIT) uut (
        .A(A),
        .B(B),
        .S(S),
        .partial_products(partial_prod)
    );
    */
    PP_gen #(NBIT) uut (
        .A(A),
        .B(B),
        .S(S),
        .partial_products(partial_prod)
    );


    initial begin
       
        A = 11'b10101010101;
        B = 11'b01101101101;

        #10;

        $display("Test Case 1:");
        $display("A = %b", A);
        $display("B = %b", B);
        $display("S = %b", S);
        for (int i = 0; i < 6; i++)
            $display("partial_prod[%0d] = %b", i, partial_prod[i]);

        
        $stop;
    end

endmodule
