library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity FIR_Filter_adv is
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

architecture beh of FIR_Filter_adv is

    constant SUM_PIPE_IDX: integer := 3;

    type sample_t is array (0 to N) of signed (Nb-1 downto 0);
    type V_t is array (0 to 6) of std_logic;
    type mulres_t is array (0 to N, 0 to L-1) of signed (2*Nb-1 downto 0);
    type mulres_second_layer_t is array (0 to N - (SUM_PIPE_IDX + 2), 0 to L - 1) of signed (2 * Nb - 1 downto 0);
    type sums_t is array(0 to N-1, 0 to L-1) of signed(Nb-1 downto 0);
    type sum_regs_t is array (0 to L - 1) of signed (Nb - 1 downto 0);

    signal x    : sample_t;
    signal sums: sums_t;
    signal sum_regs: sum_regs_t;
    signal mulres, mulres_first_layer: mulres_t;
    signal mulres_second_layer: mulres_second_layer_t;
    signal V      : V_t;
    signal DOUT3k_s, DOUT3k_curr: signed (Nb-1 downto 0);
    signal DOUT3k2_s, DOUT3k2_curr: signed (Nb-1 downto 0);

begin

    process(CLK, RST_n)
    begin
        if (RST_n = '0') then
            x    <= (others => (others => '0'));
            DOUT3k_curr <= (others => '0');
            V <= (others => '0');

            -- Reset first pipeline multiplication registers layer
            for i in 0 to N loop
                for j in 0 to L - 1 loop
                    mulres_first_layer(i, j) <= (others => '0');
                end loop;
            end loop;

            -- Reset second pipeline multiplication registers layer
            for i in 0 to N - (SUM_PIPE_IDX + 2) loop
                for j in 0 to L - 1 loop
                    mulres_second_layer(i, j) <= (others => '0');
                end loop;
            end loop;

            -- Reset sum pipeline registers
            for i in 0 to L - 1 loop
                sum_regs(i) <= (others => '0');
            end loop;

        elsif (rising_edge(clk)) then
            V(0) <= VIN;

            if (VIN = '1') then
                x(0) <= signed(DIN3k2);
                x(1) <= signed(DIN3k1);
                x(2) <= signed(DIN3k);

                -- Sample shifting
                loop1 : for i in 1 to (N-1)/L loop
                    x(i * L)     <= x((i - 1) * L);
                    x(i * L + 1) <= x((i - 1) * L + 1);
                    x(i * L + 2) <= x((i - 1) * L + 2);
                end loop;

                -- Shift the valid bit for 6 cycles
                for i in 1 to 5 loop
                    V(i) <= V(i - 1);
                end loop;

                -- Update first pipeline multiplication registers layer
                for i in 0 to N loop
                    for j in 0 to L - 1 loop
                        mulres_first_layer(i, j) <= mulres(i, j);
                    end loop;
                end loop;

                -- Update second pipeline multiplication registers layer
                for i in 0 to N - (SUM_PIPE_IDX + 2) loop
                    for j in 0 to L - 1 loop
                        mulres_second_layer(i, j) <= mulres_first_layer(i + (SUM_PIPE_IDX + 2), j);
                    end loop;
                end loop;

                -- Update pipeline sum registers
                for i in 0 to L - 1 loop
                    sum_regs(i) <= sums(SUM_PIPE_IDX, i);
                end loop;

                DOUT3k_curr  <= DOUT3k_s;
                DOUT3k2_curr <= DOUT3k2_s;
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
    sums(0, 0) <= mulres_first_layer(0, 0)(2 *Nb - 1 downto 2 * Nb - 9) + mulres_first_layer(1, 0)(2 * Nb - 1 downto 2 * Nb - 9);
    sums(0, 1) <= mulres_first_layer(0, 1)(2 *Nb - 1 downto 2 * Nb - 9) + mulres_first_layer(1, 1)(2 * Nb - 1 downto 2 * Nb - 9);
    sums(0, 2) <= mulres_first_layer(0, 2)(2 *Nb - 1 downto 2 * Nb - 9) + mulres_first_layer(1, 2)(2 * Nb - 1 downto 2 * Nb - 9);
    sums_gen : for i in 1 to N - 1 generate
        comb_sums_gen: if i < SUM_PIPE_IDX + 1 generate
            sums(i, 0) <= sums(i - 1, 0) + mulres_first_layer(i + 1, 0)(2 * Nb - 1 downto 2 * Nb - 9);
            sums(i, 1) <= sums(i - 1, 1) + mulres_first_layer(i + 1, 1)(2 * Nb - 1 downto 2 * Nb - 9);
            sums(i, 2) <= sums(i - 1, 2) + mulres_first_layer(i + 1, 2)(2 * Nb - 1 downto 2 * Nb - 9);
        end generate;

        piped_sums_gen: if i > SUM_PIPE_IDX + 1 generate
            sums(i, 0) <= sums(i - 1, 0) + mulres_second_layer(i + 1 - (SUM_PIPE_IDX + 2), 0)(2 * Nb - 1 downto 2 * Nb - 9);
            sums(i, 1) <= sums(i - 1, 1) + mulres_second_layer(i + 1 - (SUM_PIPE_IDX + 2), 1)(2 * Nb - 1 downto 2 * Nb - 9);
            sums(i, 2) <= sums(i - 1, 2) + mulres_second_layer(i + 1 - (SUM_PIPE_IDX + 2), 2)(2 * Nb - 1 downto 2 * Nb - 9);
        end generate;
    end generate;

    -- inject pipeline registers
    sums(SUM_PIPE_IDX + 1, 0) <= sum_regs(0) + mulres_second_layer(0, 0)(2 * Nb - 1 downto 2 * Nb - 9);
    sums(SUM_PIPE_IDX + 1, 1) <= sum_regs(1) + mulres_second_layer(0, 1)(2 * Nb - 1 downto 2 * Nb - 9);
    sums(SUM_PIPE_IDX + 1, 2) <= sum_regs(2) + mulres_second_layer(0, 2)(2 * Nb - 1 downto 2 * Nb - 9);

    VOUT <= VIN and V(5);
    DOUT3k_s  <= sums(N - 1, 2);
    DOUT3k2_s <= sums(N - 1, 1);

    DOUT3k <= std_logic_vector(DOUT3k2_curr);
    DOUT3k1 <= std_logic_vector(DOUT3k_curr);
    DOUT3k2 <= std_logic_vector(sums(N - 1, 0));
end beh;
