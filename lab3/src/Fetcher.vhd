library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.myTypes.all;

entity Fetcher is
    port (
        clk: in std_logic;
        rst: in std_logic;
        -- from CPU
        proc_req_in: in std_logic;       
        addr_in: in addr_t;
        -- from MEM
        mem_rdy: in std_logic;
        rdata: in data_t;
        valid_in: in std_logic;
        -- to CPU
        data_out: out data_t;
        valid_out: out std_logic;
        req_busy: out std_logic;
        req_done: out std_logic;
        -- to MEM
        addr_out: out addr_t
    );
end Fetcher;

architecture Beh of Fetcher is
    TYPE Statetype IS
        (IDLE, READY, VALID);
    signal curr_state, next_state: Statetype;
begin

    Logic: process(curr_state, proc_req_in, mem_rdy, valid_in, addr_in)
    begin
        -- req_done <= '1';
       
        addr_out <= addr_in;
        req_busy <= '0';
        --
        req_done <= '0';
        case curr_state is
            when IDLE =>
                if(proc_req_in = '1') then
                    req_done <= '0';
                    req_busy <= '1';
                end if;
            when READY =>
                req_busy <= '1';
                -- if(proc_req_in = '1') then
                --     end if;
                if(proc_req_in = '1' and mem_rdy = '1') then
                    -- addr_out <= next_addr_in_s;
                end if;
            when VALID =>
                req_done <= '1';
                req_busy <= '1';
                if (valid_in = '1') then
                    req_busy <= '0';
                    -- valid_out <= '1';
                end if;  
        end case;
    end process;

    Control: process(curr_state, proc_req_in, mem_rdy, valid_in)
    begin
        case curr_state is
            when IDLE =>
                if(proc_req_in = '1') then
                    if(mem_rdy = '1') then
                        next_state <= VALID;  
                    else
                        next_state <= READY;
                    end if;
                end if;
            when READY =>
                if(mem_rdy = '1') then
                    next_state <= VALID;
                end if;
            when VALID =>
                if(valid_in = '1') then
                    next_state <= IDLE;
                else 
                    next_state <= VALID;
                end if;
        end case;        
    end process;

    StateReg: process(clk, rst)
    begin
        if(rst = '0') then
            curr_state <= IDLE;
        elsif (rising_edge(clk)) then
            curr_state <= next_state;
        end if;
    end process;

    process(valid_in, rdata)
    begin
        if (valid_in = '1') then 
            data_out <= rdata;
        end if;
    end process;

end architecture Beh;

















