-------------------------------------------------------------------------------
-- Tyler Remphrey
-- single bit full adder [structural]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity full_adder_single_bit_str is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_str;

architecture beh of full_adder_single_bit_str is

signal toSum1: std_logic; --Output of first xor gate
signal toCout1: std_logic;  --Output of first and gate
signal toCout2: std_logic;  --Output of second and gate

begin
  toSum1 <=  a xor b;
  toCout1 <= toSum1 and cin;
  toCout2 <= a and b;
  sum <= toSum1 xor cin;
  cout <= toCout1 or toCout2;
end beh; 