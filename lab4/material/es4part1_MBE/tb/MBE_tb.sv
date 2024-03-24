// Copyright 2022 Politecnico di Torino.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 2.0 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-2.0. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// File: alu_tb.sv
// Author: Michele Caon
// Date: 31/05/2022

/*
 * File: alu_tb.sv
 * ----------------------------------------
 * Testbench for the ALU in 'alu.sv'. It provides to the
 * tester objects a connection point to the DUT using the
 * ALU interface described in 'alu_if.sv').
 */

/* Include the ALU tester classes */
`include "mbe_tester.svh"
`include "mbe_verbose_tester.svh"
`include "mbe_op_verbose_tester.svh"

/* Import ALU package namespace */
import mod_dadda_mul_pkg::*;

/* Testbench code */
module mbe_tb;

    /* Define data width */
    localparam DWIDTH   = 11;

    /* Instantiate ALU interface */
    mbe_if #(DWIDTH)    mif();

    /* Instantiate ALU wrapper */
    MBE_wrap #(DWIDTH)  mw(mif.mbe_port);

    /* Declare a quiet tester object */
    mbe_tester #(DWIDTH) tst;

    /* Declare a verbose tester object */
    mbe_verbose_tester #(DWIDTH) vtst;
    mbe_op_verbose_tester #(DWIDTH) optst;

    /* Number of test cycles */
    int unsigned    num_cycles = 10;
    int unsigned    err_num = 0;

    /* Run the test */
    initial begin
        /* Instantiate the tester objects */
        tst = new(mif); 
        vtst = new(mif);
        optst = new(mif, MULT);

        // Set the number of cycles to test
        if (0 != $value$plusargs("n%d", num_cycles))
            $display("[CONFIG] Number of test cycles set to %0d", num_cycles);

        /* Run the quiet test */
        $display("\nTEST #1 - Launching MBE quiet test...");
        tst.run_test(num_cycles);
        $display("TEST #1 - Test completed!");
        $display("TEST #1 - Functional coverage: %.2f%%", tst.get_cov());

        /* Run the verbose test */
        $display("\nTEST #2 - Launching MBE verbose test...");
        vtst.run_test(num_cycles);
        $display("TEST #2 - Test completed!");
        $display("TEST #2 - Functional coverage: %.2f%%", tst.get_cov());

        /* Run a verbose test with only one operation */
        $display("\n### TEST #3 - Launching MBE single operation test...");
        optst.run_test(num_cycles);
        $display("TEST #3 - Test completed!");
        $display("TEST #3 - Functional coverage: %.2f%%", tst.get_cov());

        // Print functional coverage
        $display("\nTOTAL FUNCTIONAL COVERAGE: %.2f%%", tst.get_cov());

        // Print the number of errors
        err_num = mif.get_err_num();
        $display("");
        if (err_num > 0) begin
            $error("### TEST FAILED with %0d errors", err_num);
        end else $display("### TEST PASSED!");

        /* Terminate the simulation */
        $display("");
        $stop;
    end
endmodule
