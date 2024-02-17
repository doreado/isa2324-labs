library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.myTypes.all;

entity LoadStoreUnit is
    port (
        clk: in std_logic,
        rst: in std_logic,
        -- from CPU
        proc_req_in: in std_logic,       
        addr_in: in IRAM_ADDR_SIZE,
        wdata_in: in addr_t,
        we_in: in std_logic,
        -- from MEM
        mem_rdy: in std_logic,
        rdata: in data_t,
        valid_in: in std_logic
        -- to CPU
        --mem_rdy_out: out std_logic,
        data_out: out data_t,
        valid_out: out std_logic
        -- to MEM
        proc_req_out: out std_logic,
        addr_out: out pc_t,
        we_out: out std_logic,
        wdata_out: out addr_t
    );
end LoadStoreUnit;

architecture Beh of LoadStoreUnit is
    TYPE Statetype IS
        (IDLE, READY, VALID_WAIT);
    signal curr_state, next_state;
    signal addr_in_s: addr_t;
    signal wdata_in_s: data_t;  

    Logic: process(curr_state)
    begin
        case curr_state is
            when IDLE =>
                if(proc_req_in == '1') then
                    -- store request content 
                    addr_in_s <= addr_in;
                    if(we == '1') then
                        wdata_in_s <= wdata_in;
                    end if;
                    
                end if;
            when READY =>
                if(mem_rdy == '1') then
                    addr_out <= addr_in_s;
                    if(we == '1') then
                        we_out <= wdata_in_s;
                    end if;
                end if;  
        end case;
        data_out <= rdata when valid_in = '1';
        valid_out <= '1' when valid_in = '1' else '0';
    end process;

    Control: process(curr_state, proc_req_in, mem_rdy, valid_in)
    begin
        case curr_state is
            when IDLE =>
                if(proc_req_in == '1') then
                    next_state <= READY;
                end if;
            when READY =>
                next_state <= READY;
                if(mem_rdy == '1') then
                    next_state <= IDLE;
                end if;
        end case;        
    end process;

    StateReg: process(clk, rst)
    begin
        if(rst = '1') then
            curr_state <= IDLE;
        elsif (rising_edge(clk)) then
            curr_state <= next_state;
        end if;
    end process;


end architecture Beh;

















