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
// File: alu_cov.svh
// Author: Michele Caon
// Date: 06/06/2022

// File: alu_cov.svh
// ----------------------------------------
// Classes containig the methods and covergroup to compute the functional
// coverage of the ALU.

`ifndef MBE_COV_SVH_
`define MBE_COV_SVH_

//import alu_pkg::*;

`include "mod_dadda_mul_pkg.sv"

class MBE_cov #(
    parameter DWIDTH = 11
);
    // ---------
    // VARIABLES
    // ---------
    
    // Adder interface
    local virtual interface mbe_if #(DWIDTH) mif;
    
    // -------------------
    // FUNCTIONAL COVERAGE
    // -------------------

    // MBE coverage
    covergroup mbe_cg;
        // Operations
        //op_cp: coverpoint mif.alu_op iff (aif.rst_n) {
           // bins add        = {ADD};
            //bins sub        = {SUB};
           // bins mult       = {MULT};
            // others = default;
        //}

        // Operands
        a_cp: coverpoint mif.a iff (mif.rst_n) {
            bins corner[]   = {0, (1<<DWIDTH)-1} , (1<<(DWIDTH-1))-1};
            bins others     = default;
        }
        b_cp: coverpoint mif.b iff (mif.rst_n) {
            bins corner[]   = {0, (1<<DWIDTH)-1} , (1<<(DWIDTH-1))-1};
            bins others     = default;
        }
    endgroup: mbe_cg

    // -------
    // METHODS
    // -------

    // Constructor
    function new(virtual interface mbe_if #(DWIDTH) _if);
        mif         = _if;
        mbe_cg      = new();

        // disable the covergroup by default
        mbe_cg.stop();
    endfunction: new

    // Enable operands coverage
    function void cov_start();
        mbe_cg.start();
    endfunction: cov_start

    // Disable operands coverage
    function void cov_stop();
        mbe_cg.stop();
    endfunction: cov_stop

    // Sample operands coverage
    function void cov_sample();
        mbe_cg.sample();
    endfunction: cov_sample

    // Return operands coverage
    function real get_cov();
        return mbe_cg.get_inst_coverage();
    endfunction: get_cov
    
endclass // 

`endif 