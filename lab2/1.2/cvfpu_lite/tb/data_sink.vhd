library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;

entity data_sink is
  --generic (
   -- NBIT : integer := 16);
  port (
    CLK   : in std_logic;
    RST_n : in std_logic;
    VIN   : in std_logic;
    DIN   : in std_logic_vector(16-1 downto 0));
end data_sink;

architecture beh of data_sink is

begin  -- beh

    process (CLK, RST_n)
    file res_fp : text open WRITE_MODE is "../cvfpu_lite/fp_test/results_hdl.txt";
    variable line_out : line;
    file fp_in : text open READ_MODE is "../cvfpu_lite/fp_test/result_c.txt";
    variable line_in : line;    
    variable x : std_logic_vector(15 downto 0);
    variable cnt : integer := 0;
    variable x_string : string(1 to 16);
    variable DIN_string : string(1 to 16);
 
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      cnt := 0;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if (VIN = '1') then
        write(line_out, DIN);
        writeline(res_fp, line_out);
        if not endfile(fp_in) then
          readline(fp_in, line_in);
          read(line_in, x);

          assert DIN = x report "Results are different: index=" & integer'image(cnt) & " c=" & integer'image(to_integer(signed(x))) & " HDL=" & integer'image(to_integer(signed(DIN))) severity error; 
        else
          assert VIN = '0' report "Reached EOF in results_c.txt" severity error;
        end if;
        cnt := cnt + 1;
      end if;
    end if;
  end process;

end beh;
