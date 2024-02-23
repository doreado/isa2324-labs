library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.myTypes.all;
use work.control_words.all;

entity HAZARD_DETECTION_UNIT is
    port(
        CLK      : in std_logic;
        RST      : in std_logic;
        dp_to_hu : in dp_to_hu_t;
        cu_to_hu : in cu_to_hu_t;

        IRAM_READY : in std_logic;
        DRAM_READY : in std_logic;
        SECW  : out stage_enable_t;

        DREQ_DONE : in std_logic;
        DPROC_REQ : out std_logic;

        REQ_DONE : in std_logic;
        PROC_REQ : out std_logic
        );
end entity HAZARD_DETECTION_UNIT;

architecture RTL of HAZARD_DETECTION_UNIT is
begin

    ---------------------------- SECW Pipeline
    secw_update : process(DRAM_READY, IRAM_READY, cu_to_hu, dp_to_hu)
        begin

        if (cu_to_hu.IS_JUMP_ID = '1') then -- if a jump is decoded, put a nop in IR and do not update the PC.
            SECW <= (
                FLUSH_IF => '1',
                PREFETCH => '1',
                FETCH    => '1',
                DECODE   => '1',
                EXECUTE  => '1',
                MEMORY   => '1',
                WB       => '1'
            );
        elsif (DRAM_READY = '1') then -- freeze the pipeline until memory, if the dram is still reading or writing
           SECW <= (
               FLUSH_IF => '0',
               PREFETCH => '0',
               FETCH    => '0',
               DECODE   => '0',
               EXECUTE  => '0',
               MEMORY   => '0',
               WB       => '1'
               );
        elsif (IRAM_READY = '1') then -- fetch a nop if the iram is still reading
            SECW <= (
                FLUSH_IF => '1',
                PREFETCH => '0',
                FETCH    => '1',
                DECODE   => '1',
                EXECUTE  => '1',
                MEMORY   => '1',
                WB       => '1'
                );
        elsif (cu_to_hu.IS_B_ID = "10" or cu_to_hu.IS_B_ID = "01") then -- if a branch is decoded, continue fetching the next instruction normally (assume not-taken)
            if (dp_to_hu.B_TAKEN = '1') then -- assume not taken, then flush IR when it is taken
                SECW <= (
                    FLUSH_IF => '1',
                    PREFETCH => '1',
                    FETCH    => '1',
                    DECODE   => '1',
                    EXECUTE  => '1',
                    MEMORY   => '1',
                    WB       => '1'
                    );
            else
                SECW <= STALL_CLEAR; -- do nothing if the branch is not taken
            end if;
        else
            SECW <= STALL_CLEAR; -- do not stall anything otherwise
        end if;
    end process;
    
    dproc_req <= not(dreq_done); --'1';
    proc_req <= '1' when (cu_to_hu.IS_B_ID = "10" or cu_to_hu.IS_B_ID = "01") and (dp_to_hu.B_TAKEN = '1') else
                '1' when (cu_to_hu.IS_JUMP_EX = '1') else 
                '0' when (cu_to_hu.IS_JUMP_ID = '1') else
                not(req_done);
end architecture RTL;
