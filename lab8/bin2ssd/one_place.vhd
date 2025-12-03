LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity one_place is
	port (
		num_in : in std_logic_vector(9 downto 0);
		num_out : out std_logic_vector(9 downto 0)
	);
end entity one_place;

architecture behavior of one_place is
constant ten : unsigned(7 downto 0) := "00001010"; 
signal unsigned_in : unsigned(9 downto 0);
begin	
	unsigned_in <= unsigned(num_in); 
	num_out <= std_logic_vector('0' & '0' & (unsigned_in rem ten));

end architecture behavior;	