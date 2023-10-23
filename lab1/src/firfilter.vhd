library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;


entity FIR_Filter is
    port(
        DIN: In std_logic_vector(Nb-1 downto 0);
        DOUT: Out std_Logic_vector(Nb-1 downto 0);
        B: In parameters;
        VIN: In std_logic;
        VOUT: Out std_logic;
        CLK: In std_logic;
        RST_n: In std_logic      --active low
    );
end entity;

architecture beh of FIR_Filter is 

type sample_t is array (0 to N) of signed (Nb-1 downto 0);
type mulres_t is array (0 to N) of signed (2*Nb-1 downto 0);
type sum_t is array(0 to N-1) of signed(2*Nb-1 downto 0); --TODO Nb-1 downto 0

signal x: sample_t; --x0 is the most recent;
signal sums: sum_t;
signal mulres: mulres_t;
signal DOUT_s: signed (Nb-1 downto 0);
begin

process(CLK,RST_n)
begin 
if (RST_n = '0') then
    x <= (others=>(others => '0'));
    VOUT <= '0';
    DOUT <= (others => '0');
elsif (rising_edge(clk)) then
    if (VIN = '1') then
        x(0)<=signed(DIN);
        loop1: for i in 0 to N-2 loop
            x(i+1)<= x(i);
        end loop;
    end if;
    DOUT_s <= sums(N-1);
end if;
end process;

process(x)
begin
loop2: for i in 0 to N loop
    mulres(i)<= x(i) * B(i);
end loop;
end process;

sums(0) <= mulres(0) + mulres(1); --TODO troncamento dei mulres
generate1: for i in 1 to N-1 generate
    sums(i) <= sums(i-1) + mulres(i+1); -- TODO troncamento
end generate;

DOUT<= std_logic_vector(DOUT_s);   --TODO alzare VOUT

end beh;
