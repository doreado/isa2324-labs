library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.myTypes.all;

entity LoadStoreUnit is
    port (
        clk: in std_logic;
        rst: in std_logic;
        -- from CPU
        mem_en: in std_logic;
        proc_req_in: in std_logic;       
        addr_in: in addr_t;
        wdata_in: in data_t;
        we_in: in std_logic;        -- active low
        -- from MEM
        mem_rdy: in std_logic;
        rdata: in data_t;
        valid_in: in std_logic;
        -- to CPU
        data_out: out data_t;
        valid_out: out std_logic;
        req_done: out std_logic;
        -- to MEM
        addr_out: out addr_t;
        we_out: out std_logic;
        req_busy: out std_logic;
        wdata_out: out data_t
    );
end LoadStoreUnit;

architecture Beh of LoadStoreUnit is
    TYPE Statetype IS
        (IDLE, READY, VALID);
    signal curr_state, next_state: Statetype;
    signal addr_in_s, next_addr_in_s: addr_t;
    signal wdata_in_s, next_wdata_in_s: data_t;  
    signal valid_in_s, mem_rdy_s: std_logic;
begin

    Logic: process(curr_state, proc_req_in, we_in, mem_en, valid_in, addr_in, wdata_in, rdata)
    begin
        addr_out <= addr_in;
        req_busy <= '0';
        --
        req_done <= '0';

        case curr_state is
            when IDLE =>
                -- valid_out <= '0';
                if(mem_en = '1' and proc_req_in = '1') then
                    req_done <= '0';
                    req_busy <= '1';
                    -- store request content 
                    -- next_addr_in_s <= addr_in;
                    -- if(we_in = '1') then
                        -- wdata_in_s <= wdata_in;
                        -- we_out <= '1'; 
                    -- end if;
                    --burst case
                    -- if(mem_rdy = '1') then
                    --     addr_out <= addr_in;
                    --     if(we_in = '1') then
                    --         wdata_out <= wdata_in;
                    --         we_out <= '1'; 
                    --     end if;
                    -- end if;
                end if;
            when READY =>
                req_busy <= '1';
                -- if(mem_rdy = '1') then
                -- --    addr_out <= next_addr_in_s;
                --     if(we_in = '1') then
                -- --       wdata_out <= next_wdata_in_s;
                --         we_out <= '1'; 
                --     end if;
                -- end if;
            when VALID =>
                req_busy <= '1';
                req_done <= '1';
                if (valid_in = '1') then
                    req_busy <= '0';
                    data_out <= rdata;
                    --valid_out <= '1';
                end if;  
        end case;
    end process;

    Control: process(curr_state, proc_req_in, mem_rdy, valid_in, mem_en)
    begin
        case curr_state is
            when IDLE =>
                if(mem_en = '1' and proc_req_in = '1') then
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
                else 
                    next_state <= VALID;
                end  if;
        end case;        
    end process;

    StateReg: process(clk, rst)
    begin
        if(rst = '0') then
            curr_state <= IDLE;
            -- addr_in_s <= (others => '0');
            -- wdata_in_s <= (others => '0');
        elsif (rising_edge(clk)) then
            curr_state <= next_state;
            mem_rdy_s  <= mem_rdy;
            valid_in_s <= valid_in;
            --mem_rdy_reg <= mem_rdy_s;
            -- addr_in_s <= next_addr_in_s;
            -- wdata_in_s <= next_wdata_in_s;
        end if;
    end process;

    process(valid_in, rdata)
    begin
        if (valid_in = '1') then
            data_out <= rdata;
        end if;
    end process;

    --addr_out <= addr_in;
    we_out <= we_in;
    wdata_out <= wdata_in;

end architecture Beh;

















