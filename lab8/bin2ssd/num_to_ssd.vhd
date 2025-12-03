LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity num_to_ssd is
	port (
		inputs : in std_logic_vector(9 downto 0);
		Seg_Display : out std_logic_vector(6 downto 0)
	);
end entity num_to_ssd;

architecture behavior of num_to_ssd is

CONSTANT ZERO : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000000";
CONSTANT ONE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111001";
CONSTANT TWO : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100100";
CONSTANT THREE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000";
CONSTANT FOUR : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0011001";
CONSTANT FIVE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010010";
CONSTANT SIX : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000010";
CONSTANT SEVEN : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111000";
CONSTANT EIGHT : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
CONSTANT NINE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0011000";
CONSTANT BLANK : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";

signal inputsNum : STD_LOGIC_VECTOR (3 downto 0);

begin	
    inputsNum <= inputs(3 downto 0);

	caseMethod: PROCESS (inputsNum)
		     BEGIN
			     CASE inputsNum IS
				      WHEN "0000" => Seg_Display <= ZERO;
					  WHEN "0001" => Seg_Display <= ONE;
					  WHEN "0010" => Seg_Display <= TWO;
					  WHEN "0011" => Seg_Display <= THREE;
					  WHEN "0100" => Seg_Display <= FOUR;
					  WHEN "0101" => Seg_Display <= FIVE;
					  WHEN "0110" => Seg_Display <= SIX;
					  WHEN "0111" => Seg_Display <= SEVEN;
					  WHEN "1000" => Seg_Display <= EIGHT;
					  WHEN "1001" => Seg_Display <= NINE;
					  WHEN OTHERS => Seg_Display <= BLANK;
				  END CASE;
			END PROCESS;

end architecture behavior;	