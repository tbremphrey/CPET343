-------------------------------------------------------------------------------
-- Dr. Kaputa / Tyler Remphrey
-- generic adder [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
  generic (
    bits    : integer := 8
  );
  port (
    a               : in  std_logic_vector(bits-1 downto 0);
    b               : in  std_logic_vector(bits-1 downto 0);
    add_sub_toggle  : in std_logic;
    result          : out std_logic_vector(bits downto 0)
  );
end entity add_sub;

architecture beh of add_sub is

signal add_temp   : std_logic_vector(bits downto 0);
signal sub_temp   : std_logic_vector(bits downto 0);
signal add_on : std_logic;
signal sub_on : std_logic;

begin
  add_temp  <= std_logic_vector(unsigned("0" & a) + unsigned("0" & b));
  sub_temp  <= std_logic_vector(unsigned("0" & a) - unsigned("0" & b));
  process (add_temp, sub_temp, add_sub_toggle)
    begin
      if (add_sub_toggle = '0') then
        result <= add_temp;
      elsif (add_sub_toggle = '1') then
        result <= sub_temp;
      end if;
    end process;
end beh;