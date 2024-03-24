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
// File: alu_tester.svh
// Author: Michele Caon
// Date: 31/05/2022

/*
 * File: alu_tester.svh
 * ----------------------------------------
 * Class containig the methods and variables to test the
 * ALU described in 'alu.sv' using the interface in 
 * 'alu_if.sv'.
 */

`ifndef MBE_TESTER_SVH_
`define MBE_TESTER_SVH_

`include "mbe_cov.svh"

import mod_dadda_mul_pkg::*;

/* ALU tester class */
class mbe_tester #(
    parameter DWIDTH    = 11
);
    // PROPERTIES
    // ----------

    // ALU interface
    /*
     * NOTE: the interface is declared as virtual, meaning that the
     * user will provide a proper implementation. In this case, the 
     * handle to a proper interface object is passed to the 
     * constructor (see below) by the TB in 'alu_tb.sv'.
     */
    virtual interface mbe_if #(DWIDTH) tmif;

    // Random ALU operation and inputs (updated by the 'randomize()' method)
    typedef struct packed {
        logic [DWIDTH-1:0]  a;
        logic [DWIDTH-1:0]  b;
    } input_t;
    protected rand input_t     mbe_input;

    // Constraint to prefer corner cases for operands /10x more likely)
    constraint ab_dist_c {
        mbe_input.a dist {
            0                   :=10, 
            (1<<DWIDTH)-1       :=10,
            (1<<(DWIDTH-1))-1   :=10, 
            [1:(1<<DWIDTH)-2]   :=1
        };
        mbe_input.b dist {
            0                   :=10, 
            (1<<DWIDTH)-1       :=10,
            (1<<(DWIDTH-1))-1   :=10, 
            [1:(1<<DWIDTH)-2]   :=1
        };
    };

    // ALU coverage
    // NOTE: declared as static so it's shared among multiple class
    // instances.
    protected static mbe_cov #(DWIDTH)  mcov;

    // METHODS
    // -------

    // Constructor
    function new(virtual interface mbe_if #(DWIDTH) _if);
        tmif = _if;   // get the handle to the ALU interface from the TB
        mcov = new(_if);
    endfunction // new()

    // Test body
    /*
     * NOTE: tasks can contain "time-consuming" code, while functions
     * are always executed within a single simulation step.
     */
    task run_test(int unsigned num_cycles);
        // Reset the DUT
        init();

        // Start measuring coverage
        mcov.cov_start();

        // Issue num_cycles random ALU operations
        repeat (num_cycles) begin: driver
            @(posedge tmif.clk);
            rand_input();
        end

        // Wait for the last operation to complete
        @(posedge tmif.clk);

        // Stop measuring coverage
        mcov.cov_stop();
    endtask // run_test()

    protected task init();
        // Reset driver signals
        tmif.a      = '0;
        tmif.b      = '0;

        // Reset the DUT
        tmif.rst_dut();

        @(posedge tmif.clk);
    endtask: init
    
    // Prepare a new ALU operation
    function void rand_input();
        // Obtain random operations and operands
        assert (this.randomize())   // check the method's return value
        else   $error("ERROR while calling 'randomize()' method");

        // Set the ALU interface signals
        tmif.a    = mbe_input.a;
        tmif.b    = mbe_input.b;

        // Update coverage
        mcov.cov_sample();
    endfunction

    // Get the ALU coverage
    function real get_cov();
        return mcov.get_cov();
    endfunction: get_cov

endclass // alu_tester

`endif /* ALU_TESTER_SVH_ */
