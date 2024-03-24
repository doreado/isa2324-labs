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
// File: alu_verbose_tester.svh
// Author: Michele Caon
// Date: 02/06/2022

// File: alu_verbose_tester.svh
// ----------------------------
// Class extended from alu_tester.svh to print additional information about
// the test progress.

`ifndef MBE_VERBOSE_TESTER_SVH_
`define MBE_VERBOSE_TESTER_SVH_

`include "MBE_tester.svh"

/* ALU verbose tester class */
class mbe_verbose_tester #(
    parameter DWIDTH    = 11
) extends mbe_tester #(DWIDTH);    // inherits methods and variables from alu_tester

    // Operands queue
    input_t    inputq[$];
    
    // Use the constructor from the parent class
    function new(virtual interface mbe_if #(DWIDTH) _if);
        super.new(_if);
        inputq = {};
    endfunction // new()

    // Test body
    task run_test(int unsigned num_cycles);
        // Reset the DUT
        init();

        // Start measuring coverage
        mcov.cov_start();

        fork
            // Monitor operations
            print_op();

            // Issue num_cycles random ALU operations
            repeat (num_cycles) begin: driver
                @(posedge tmif.clk);
                rand_mbe_input();
                inputq.push_front({mbe_input});
            end
        join

        // Stop measuring coverage
        mcov.cov_stop();
    endtask // run_test()
    
    // Print current operation
    task print_op();
        input_t   prev_input;

        repeat (2) @(negedge tmif.clk);    // skip the first result after reset
        while (inputq.size() > 0) begin
            @(negedge tmif.clk); // sample on negative edge to avoid race conditions
            prev_input = inputq.pop_back();
            $display("a: %b (%d) | b: %b (%d) | res: %b (%d)", $time, prev_input.a, prev_input.a, prev_input.b, prev_input.b, tmif.result, tmif.result);
        end
    endtask // op2str()

endclass // alu_verbose_tester

`endif /* ALU_VERBOSE_TESTER_SVH_ */
