LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity bin2ssd is
	port (
		 in_num : in std_logic_vector(9 downto 0);
		 hex2,hex1, hex0 : out std_logic_vector(6 downto 0)
	);
	
end entity bin2ssd;

architecture functional of bin2ssd is

signal hundLine, tenLine, oneLine : std_logic_vector(9 downto 0);


component hund_place is
	port (
		num_in : in std_logic_vector(9 downto 0);
		num_out : out std_logic_vector(9 downto 0)
	);
end component hund_place;
component ten_place is
	port (
		num_in : in std_logic_vector(9 downto 0);
		num_out : out std_logic_vector(9 downto 0)
	);
end component ten_place;
component one_place is
	port (
		num_in : in std_logic_vector(9 downto 0);
		num_out : out std_logic_vector(9 downto 0)
	);
end component one_place;
component num_to_ssd is
	port (
		inputs : in std_logic_vector(9 downto 0);
		Seg_Display : out std_logic_vector(6 downto 0)
	);
end component num_to_ssd;



begin
	hundFunc : hund_place
	port map (
		num_in => in_num,
		num_out => hundLine
	);
	tenFunc : ten_place
	port map (
		num_in => in_num,
		num_out => tenLine
	);
	oneFunc : one_place
	port map (
		num_in => in_num,
		num_out => oneLine
	);
	hundSSD : num_to_ssd
	port map (
		inputs => hundLine,
		Seg_Display => hex2
	);
	tenSSD : num_to_ssd
	port map (
		inputs => tenLine,
		Seg_Display => hex1
	);
	oneSSD : num_to_ssd
	port map (
		inputs => oneLine,
		Seg_Display => hex0
	);

end architecture functional;