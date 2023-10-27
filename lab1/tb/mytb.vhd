library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity tb is 
end tb;

architecture test of tb is 

component FIR_Filter is
    port(
        DIN: In std_logic_vector(Nb-1 downto 0);
        DOUT: Out std_Logic_vector(Nb-1 downto 0);
        B: In parameters;
        VIN: In std_logic;
        VOUT: Out std_logic;
        CLK: In std_logic;
        RST_n: In std_logic      --active low
    );
end component;

component data_sink is
    port (
    CLK   : in std_logic;
    RST_n : in std_logic;
    VIN   : in std_logic;
    DIN   : in std_logic_vector(Nb-1 downto 0));
end component;

component clk_gen is
    port (
      END_SIM : in  std_logic;
      CLK     : out std_logic;
      RST_n   : out std_logic);
  end component;

  component data_maker is
    port (
      CLK     : in  std_logic;
      RST_n   : in  std_logic;
      VOUT    : out std_logic;
      DOUT    : out std_logic_vector(Nb-1 downto 0);
      B0      : out std_logic_vector(Nb-1 downto 0);
      B1      : out std_logic_vector(Nb-1 downto 0);
      B2      : out std_logic_vector(Nb-1 downto 0);
      B3      : out std_logic_vector(Nb-1 downto 0);
      B4      : out std_logic_vector(Nb-1 downto 0);
      B5      : out std_logic_vector(Nb-1 downto 0);
      B6      : out std_logic_vector(Nb-1 downto 0);
      B7      : out std_logic_vector(Nb-1 downto 0);
      B8      : out std_logic_vector(Nb-1 downto 0);
      END_SIM : out std_logic);
end component;

    signal END_SIM_s, clk_s, rst_s, Vin_s, Vout_s: std_logic;
    signal Din_s, Dout_s, B0_s, B1_s, B2_s, B3_s, B4_s, B5_s, B6_s, B7_s, B8_s,: std_logic_vector(Nb-1 downto 0);

begin

    data: data_maker
    port map(
        clk_s, rst_s, Vin_s, Din_s, B0_s, B1_s, B2_s, B3_s, B4_s, B5_s, B6_s, B7_s, B8_s
    );
    
    clock: clk_gen
    port map(END_SIM_s, clk_s, rst_s);

    UUT: FIR_Filter
    port map (
        DIN => Din_s, 
        DOUT => Dout_s,
        B => B,
        VIN => Vin_s,
        VOUT => Vout_s,
        CLK => clk_s,
        RST_n => rst_s
    );

end architecture test;