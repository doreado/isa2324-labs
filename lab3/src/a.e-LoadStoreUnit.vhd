library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.myTypes.all;

entity LoadStoreUnit is
    port (
        clk: in std_logic;
        rst: in std_logic;
        -- from CPU
        proc_req_in: in std_logic;       
        addr_in: in addr_t;
        wdata_in: in data_t;
        we_in: in std_logic;
        -- from MEM
        mem_rdy: in std_logic;
        rdata: in data_t;
        valid_in: in std_logic;
        -- to CPU
        --mem_rdy_out: out std_logic;
        data_out: out data_t;
        valid_out: out std_logic;
        -- to MEM
        --proc_req_out: out std_logic;
        addr_out: out addr_t;
        we_out: out std_logic;
        wdata_out: out data_t
    );
end LoadStoreUnit;

architecture Beh of LoadStoreUnit is
    TYPE Statetype IS
        (IDLE, READY, VALID);
    signal curr_state, next_state: Statetype;
    signal addr_in_s, next_addr_in_s: addr_t;
    signal wdata_in_s, next_wdata_in_s: data_t;  
begin

    Logic: process(curr_state, proc_req_in, we_in, mem_rdy, valid_in, addr_in, addr_in_s, wdata_in, wdata_in_s, rdata)
    begin
        case curr_state is
            when IDLE =>
                valid_out <= '0';
                if(proc_req_in = '1') then
                    -- store request content 
                    next_addr_in_s <= addr_in;
                    if(we_in = '1') then
                        wdata_in_s <= wdata_in;
                    end if;
                    --burst case
                    if(mem_rdy = '1') then
                        addr_out <= addr_in;
                        if(we_in = '1') then
                            wdata_out <= wdata_in;
                        end if;
                    end if;
                end if;
            when READY =>
                if(mem_rdy = '1') then
                    addr_out <= next_addr_in_s;
                    if(we_in = '1') then
                        wdata_out <= next_wdata_in_s;
                    end if;
                end if;
            when VALID =>
                if (valid_in = '1') then
                    data_out <= rdata;
                    valid_out <= '1';
                end if;  
        end case;
    end process;
    
    --data_out <= rdata when valid_in = '1';
    --valid_out <= '1' when valid_in = '1' else '0';

    Control: process(curr_state, proc_req_in, mem_rdy, valid_in)
    begin
        case curr_state is
            when IDLE =>
                if(proc_req_in = '1') then
                    next_state <= READY;
                    if(mem_rdy = '1') then
                        next_state <= VALID;
                    end if;
                else
                    next_state <= IDLE;
                end if;
            when READY =>
                if(mem_rdy = '1') then
                    next_state <= VALID;
                else
                    next_state <= READY;
                end if;
            when VALID =>
                if(valid_in = '1') then
                    next_state <= IDLE;
                end if;
        end case;        
    end process;

    StateReg: process(clk, rst)
    begin
        if(rst = '0') then
            curr_state <= IDLE;
            addr_in_s <= (others => '0');
            wdata_in_s <= (others => '0');
        elsif (rising_edge(clk)) then
            curr_state <= next_state;
            addr_in_s <= next_addr_in_s;
            wdata_in_s <= next_wdata_in_s;
        end if;
    end process;


end architecture Beh;

















