library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package constants is

constant N: integer := 8;
constant Nb: integer := 9;
type parameters is array (0 to N) of signed(Nb-1 downto 0);

end constants;