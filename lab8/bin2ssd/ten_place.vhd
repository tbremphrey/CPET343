LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity ten_place is
	port (
		num_in : in std_logic_vector(9 downto 0);
		num_out : out std_logic_vector(9 downto 0)
	);
end entity ten_place;

architecture behavior of ten_place is
constant one_hundred : unsigned(7 downto 0) := "01100100"; 
constant ten : unsigned(7 downto 0) := "00001010"; 
signal unsigned_in : unsigned(9 downto 0);
begin	
	unsigned_in <= unsigned(num_in);
	num_out <= std_logic_vector('0' & '0' & ((unsigned_in rem one_hundred)/ten));

end architecture behavior;	