module testbench;

    // Parameters
    parameter NBIT = 11;

    // Inputs
    logic [NBIT-1:0] A;
    logic [2:0] B;

    // Outputs
    logic [NBIT:0] ENC_output;

    // Instantiate the module
    Booth_Encoder #(NBIT) uut (
        .A(A),
        .B(B),
        .ENC_output(ENC_output)
    );

    // Stimulus
    initial begin
        // Test Case 1
        A = 11'b10101010101;

        // Wait for a few time units to let the values propagate
        #10;

        for (int i=0; i<8; i++) begin
            // Display the results
            $display("Test Case : %d", i);
            $display("A = %b", A);
            B = i;
            $display("B = %b", B);
            
            // evaluation time
            #1

            $display("ENC_output = %b", ENC_output);
        end
        // End simulation
        $stop;
    end

endmodule
