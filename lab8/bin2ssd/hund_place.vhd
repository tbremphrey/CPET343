LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity hund_place is
	port (
		num_in : in std_logic_vector(9 downto 0);
		num_out : out std_logic_vector(9 downto 0)
	);
end entity hund_place;

architecture behavior of hund_place is
constant one_hundred : unsigned(7 downto 0) := "01100100"; 
signal unsigned_in : unsigned(9 downto 0);
begin	
	unsigned_in <= unsigned(num_in);
	num_out <= std_logic_vector(unsigned_in / one_hundred);

end architecture behavior;	