library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

use WORK.myTypes.all;
use WORK.alu_type.all;

--------------------------------------------------------------------
-- Entity Declaration
--------------------------------------------------------------------

entity ALU is
    generic (
        N : integer := numBit
    );
    port (
        FUNC   : in alu_op_t;
        DATA1  : in std_logic_vector(N - 1 downto 0);
        DATA2  : in std_logic_vector(N - 1 downto 0);
        OUTALU : out std_logic_vector(N - 1 downto 0)
    );
end ALU;

architecture BEHAVIORAL of ALU is

    --------------------------------------------------------------------
    -- Components Declaration
    --------------------------------------------------------------------

    component P4_ADDER is
        generic (
            NBIT : integer);
        port (
            A    : in  std_logic_vector(NBIT - 1 downto 0);
            B    : in  std_logic_vector(NBIT - 1 downto 0);
            Cin  : in  std_logic;
            S    : out std_logic_vector(NBIT - 1 downto 0);
            Cout : out std_logic);
    end component P4_ADDER;

    ----------------------------------------------------------------
    -- Constants Declaration
    ----------------------------------------------------------------

    constant log2_numBit : integer := integer(ceil(log2(real(numBit))));

    ----------------------------------------------------------------
    -- Signals Declaration
    ----------------------------------------------------------------

begin

    ----------------------------------------------------------------
    -- Processes
    ----------------------------------------------------------------

    P_ALU : process (FUNC, DATA1, DATA2)
    begin
        case FUNC is

            when ALU_ADD => -- Sum: A + B
                OUTALU  <= std_logic_vector(signed(DATA1) + signed(DATA2));

            when ALU_SUB => -- Sub: A - B
                OUTALU  <= std_logic_vector(signed(DATA1) - signed(DATA2));

        end case;
    end process P_ALU;

end BEHAVIORAL;

----------------------------------------------------------------
-- Configurations
----------------------------------------------------------------

configuration CFG_ALU_BEHAVIORAL of ALU is
    for BEHAVIORAL
    end for;
end CFG_ALU_BEHAVIORAL;
