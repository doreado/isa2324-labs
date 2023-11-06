library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;


entity FIR_Filter is
    port(
        DIN   : in  std_logic_vector(Nb-1 downto 0);
        DOUT  : out std_logic_vector(Nb-1 downto 0);
        B     : in  parameters;
        VIN   : in  std_logic;
        VOUT  : out std_logic;
        CLK   : in  std_logic;
        RST_n : in  std_logic           --active low
        );
end entity;

architecture beh of FIR_Filter is

    type sample_t is array (0 to N) of signed (Nb-1 downto 0);
    type V_t is array (0 to N) of std_logic;
    type mulres_t is array (0 to N) of signed (2*Nb-1 downto 0);
    type sum_t is array(0 to N-1) of signed(Nb-1 downto 0);

    signal x      : sample_t;           --x0 is the most recent;
    signal sums, sums_s   : sum_t;
    signal mulres : mulres_t;
    signal mulres_s : mulres_t;
    signal V      : V_t;
    signal DOUT_s : signed (Nb-1 downto 0);

begin

    process(CLK, RST_n)
    begin
        if (RST_n = '0') then
            x    <= (others => (others => '0'));
            DOUT_s <= (others => '0');
            V    <= (others => '0');
        elsif (rising_edge(clk)) then
            if (VIN = '1') then
                x(0) <= signed(DIN);
                V(0) <= VIN;
                loop1 : for i in 0 to N-1 loop
                    x(i+1) <= x(i);
                    V(i+1) <= V(i);
                end loop;

                DOUT_s <= sums(N-1);
            end if;
        end if;
    end process;

    process(x, B)
    begin
        loop2 : for i in 0 to N loop
            mulres_s(i) <= x(i) * B(i);
        end loop;
    end process;
    mulres <= mulres_s;
    
    sums_s(0) <= mulres(0)(2*Nb-1 downto 2*Nb-9) + mulres(1)(2*Nb-1 downto 2*Nb-9);
    generate1 : for i in 1 to N-1 generate
        sums_s(i) <= sums_s(i-1) + mulres(i+1)(2*Nb-1 downto 2*Nb-9);
    end generate;
    sums <= sums_s;

    VOUT <= VIN and V(N);
    DOUT <= std_logic_vector(DOUT_s);

end beh;
