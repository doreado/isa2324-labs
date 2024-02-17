library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;


entity FIR_Filter is
    port(
        DIN3k   : in  std_logic_vector(Nb-1 downto 0);
        DIN3k1   : in  std_logic_vector(Nb-1 downto 0);
        DIN3k2   : in  std_logic_vector(Nb-1 downto 0);
        DOUT3k  : out std_logic_vector(Nb-1 downto 0);
        DOUT3k1  : out std_logic_vector(Nb-1 downto 0);
        DOUT3k2  : out std_logic_vector(Nb-1 downto 0);
        B     : in  parameters;
        VIN   : in  std_logic;
        VOUT  : out std_logic;
        CLK   : in  std_logic;
        RST_n : in  std_logic           --active low
        );
end entity;

architecture beh of FIR_Filter is

    type sample_t is array (0 to N) of signed (Nb-1 downto 0);
    type V_t is array (0 to (N - 1) / L) of std_logic;
    type mulres_t is array (0 to N, 0 to L-1) of signed (2*Nb-1 downto 0);
    type sum_t is array(0 to N-1, 0 to L-1) of signed(Nb-1 downto 0);

    signal x      : sample_t;    
    signal sums   : sum_t;
    signal mulres : mulres_t;
    signal V      : V_t;
    signal DOUT3k_s: signed (Nb-1 downto 0);

begin

    process(CLK, RST_n)
    begin
        if (RST_n = '0') then
            x    <= (others => (others => '0'));
            DOUT3k_s <= (others => '0');
            V <= (others => '0');
        elsif (rising_edge(clk)) then
            if (VIN = '1') then
                x(0) <= signed(DIN3k2);
                x(1) <= signed(DIN3k1);
                x(2) <= signed(DIN3k);
                V(0) <= VIN;

                -- Sample shifting
                loop1 : for i in 1 to (N-1)/L loop
                    x(i * L)     <= x((i - 1) * L);
                    x(i * L + 1) <= x((i - 1) * L + 1);
                    x(i * L + 2) <= x((i - 1) * L + 2);

                    V(i) <= V(i - 1);
                end loop;

                DOUT3k_s  <= sums(N - 2, 2);
            end if;
        end if;
    end process;

    -- Multiplicators
    mulres(0, 0) <= x(0) * B(0); mulres(0, 1) <= signed(DIN3k) * B(0); mulres(0, 2) <= signed(DIN3k1) * B(0);
    mulres(1, 0) <= x(1) * B(1); mulres(1, 1) <= x(0) * B(1); mulres(1, 2) <= signed(DIN3k) * B(1);
    loop2 : for i in 2 to N generate
        mulres(i, 0) <= x(i) * B(i);
        mulres(i, 1) <= x(i-1) * B(i);
        mulres(i, 2) <= x(i-2) * B(i);
    end generate;

    -- Adders
    sums(0, 0) <= mulres(0, 0)(2*Nb-1 downto 2*Nb-9) + mulres(1, 0)(2*Nb-1 downto 2*Nb-9);
    sums(0, 1) <= mulres(0, 1)(2*Nb-1 downto 2*Nb-9) + mulres(1, 1)(2*Nb-1 downto 2*Nb-9);
    sums(0, 2) <= mulres(0, 2)(2*Nb-1 downto 2*Nb-9) + mulres(1, 2)(2*Nb-1 downto 2*Nb-9);
    generate1 : for i in 1 to N-1 generate
        sums(i, 0) <= sums(i-1, 0) + mulres(i+1, 0)(2*Nb-1 downto 2*Nb-9);
        sums(i, 1) <= sums(i-1, 1) + mulres(i+1, 1)(2*Nb-1 downto 2*Nb-9);
        sums(i, 2) <= sums(i-1, 2) + mulres(i+1, 2)(2*Nb-1 downto 2*Nb-9);
    end generate;

    VOUT <= VIN and V((N - 1) / L);
    DOUT3k  <= std_logic_vector(DOUT3k_s);
    DOUT3k1 <= std_logic_vector(sums(N - 2, 0));
    DOUT3k2 <= std_logic_vector(sums(N - 2, 1));

end beh;