-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
  generic (
    bits    : integer := 4
  );
  port (
    a           : in  std_logic_vector(bits-2 downto 0);
    b           : in  std_logic_vector(bits-2 downto 0);
    add_button  : in std_logic;
    sub_button  : in std_logic;
    clk         : in std_logic;
    cin         : in  std_logic;
    result      : out std_logic_vector(bits-1 downto 0);
    cout        : out std_logic
  );
end entity add_sub;

architecture beh of add_sub is

signal add_temp   : std_logic_vector(bits downto 0);
signal sub_temp   : std_logic_vector(bits downto 0);
signal cin_guard  : std_logic_vector(bits-1 downto 0) := (others => '0');

begin
  add_temp  <= std_logic_vector(unsigned("00" & a) + unsigned("00" & b) + unsigned(cin_guard & cin));
  sub_temp  <= std_logic_vector(unsigned("00" & a) - unsigned("00" & b));
  process (add_button, sub_button, clk)
  begin
      if(clk'event and clk = '1') then
        if (add_button = '1')
            result <= add_temp;
        elsif (sub_button = '1') then
            result <= sub_temp;
        end if;
        cout      <= sum_temp(bits); -- Carry is the most significant bit
      end if;
  end process;
end beh;