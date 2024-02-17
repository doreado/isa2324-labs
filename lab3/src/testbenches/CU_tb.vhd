library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.control_words.all;
use work.instruction_memory.all; -- Assuming you have an instruction_memory package

entity cu_tb is
end entity cu_tb;

architecture sim of cu_tb is
    signal clk, rst : std_logic := '0';
    signal func3 : std_logic_vector(2 downto 0) := (others => '0');
    signal func7 : std_logic_vector(6 downto 0) := (others => '0');
    signal opcode : std_logic_vector(6 downto 0) := (others => '0');
    

    -- Clock Process
    process
    begin
        wait for 5 ns;
        clk <= not clk;
    end process;

    -- Stimulus Process
    process
    begin
        -- Initialize CU
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 10 ns;

        -- Load instructions
        opcode <= "0110111";  --Lui
        wait for 10 ns;
        opcode <= "0000011";  --lw
        wait for 10 ns;
        opcode <= "0010011";  --addi
        wait for 10 ns;
        --opcode <= "1010011"; --mv
        --wait for 10 ns;
        opcode <= "0100011";  --sw
        wait for 10 ns;
        opcode <= "1101111"; --jal
        wait for 10 ns;
        --opcode <= "1010011";  --li
        --wait for 10 ns;
        opcode <= "1100111";  --jalr
        wait for 10 ns;
        --opcode <="1100011"; --ble
        wait;

    end process;

end architecture sim;