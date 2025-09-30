library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg is
  port (
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
end entity seven_seg;

architecture behavior of seven_seg is

	constant ZERO : std_logic_vector(6 DOWNTO 0) := "1000000";
	constant ONE : std_logic_vector(6 DOWNTO 0) := "1111001";
	constant TWO : std_logic_vector(6 DOWNTO 0) := "0100100";
	constant THREE : std_logic_vector(6 DOWNTO 0) := "0110000";
	constant FOUR : std_logic_vector(6 DOWNTO 0) := "0011001";
	constant FIVE : std_logic_vector(6 DOWNTO 0) := "0010010";
	constant SIX : std_logic_vector(6 DOWNTO 0) := "0000010";
	constant SEVEN : std_logic_vector(6 DOWNTO 0) := "1111000";
	constant EIGHT : std_logic_vector(6 DOWNTO 0) := "0000000";
	constant NINE : std_logic_vector(6 DOWNTO 0) := "0011000";
	constant LETTER_A : std_logic_vector(6 DOWNTO 0) := "0001000";
	constant LETTER_B : std_logic_vector(6 DOWNTO 0) := "0000011";
	constant LETTER_C : std_logic_vector(6 DOWNTO 0) := "1000110";
	constant LETTER_D : std_logic_vector(6 DOWNTO 0) := "0100001";
	constant LETTER_E : std_logic_vector(6 DOWNTO 0) := "0000110";
	constant LETTER_F : std_logic_vector(6 DOWNTO 0) := "0001110";
	constant BLANK : std_logic_vector(6 DOWNTO 0) := "1111111";

begin
	caseMethod: process (bcd, reset)
		begin
		case bcd is
            when "0000" => 
			    seven_seg_out <= ZERO;
            when "0001" => 
			    seven_seg_out <= ONE;
            when "0010" => 
			    seven_seg_out <= TWO;
            when "0011" => 
			    seven_seg_out <= THREE;
            when "0100" => 
			    seven_seg_out <= FOUR;
            when "0101" => 
			    seven_seg_out <= FIVE;
            when "0110" => 
			    seven_seg_out <= SIX;
            when "0111" => 
			    seven_seg_out <= SEVEN;
            when "1000" => 
			    seven_seg_out <= EIGHT;
            when "1001" => 
			    seven_seg_out <= NINE;
            when "1010" => 
			    seven_seg_out <= LETTER_A;
            when "1011" => 
			    seven_seg_out <= LETTER_B;
            when "1100" => 
			    seven_seg_out <= LETTER_C;
            when "1101" => 
			    seven_seg_out <= LETTER_D;
            when "1110" => 
			    seven_seg_out <= LETTER_E;
            when "1111" => 
			    seven_seg_out <= LETTER_F;
            when others => 
			    seven_seg_out <= BLANK;
		end case;
		
    if(reset='1') then
      seven_seg_out <= BLANK;
    end if;
	end process caseMethod;

end architecture behavior;