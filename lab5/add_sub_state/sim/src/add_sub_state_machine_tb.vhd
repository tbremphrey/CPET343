-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_state_machine_tb is
end add_sub_state_machine_tb;

architecture arch of add_sub_state_machine_tb is

component add_sub_state_machine is
	port (
		reset           : in std_logic;
    clk             : in std_logic;
    button          : in std_logic;
    inputBits       : in std_logic_vector(7 downto 0);
    onesSSD         : out std_logic_vector(6 downto 0);
    tensSSD         : out std_logic_vector(6 downto 0);
    hundredsSSD     : out std_logic_vector(6 downto 0)
	);
end component; 

constant period     : time := 20ns;                                              

signal state_Button    : std_logic:= '0';
signal bits_input      : std_logic_vector (7 downto 0):="00000000";
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';

begin

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

input_sim:process
	begin
  wait for 3*period;
	report "********* Start TB *********";
		
	report "********* Test 1 *********";
		bits_input <= "00000101";
		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;
		
		bits_input <= "00000010";
		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

	report "********* Test 2 *********";
		bits_input <= "00000010";
		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;
		
		bits_input <= "00000101";
		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

	report "********* Test 3 *********";
		bits_input <= "11001000";
		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;
		
		bits_input <= "01100100";
		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

		wait for 5*period;
		state_Button <= not state_Button;
		wait for 5*period;
		state_Button <= not state_Button;

	report "********* Test 4 *********";
		bits_input <= "01100100";
		wait for 3*period;
		state_Button <= not state_Button;
		wait for 2*period;
		state_Button <= not state_Button;
		
		bits_input <= "11001000";
		wait for 3*period;
		state_Button <= not state_Button;
		wait for 2*period;
		state_Button <= not state_Button;

		wait for 3*period;
		state_Button <= not state_Button;
		wait for 2*period;
		state_Button <= not state_Button;

		wait for 3*period;
		state_Button <= not state_Button;
		wait for 2*period;
		state_Button <= not state_Button;

	report "********* End TB *********";
	wait;
end process;

uut: add_sub_state_machine
	port map(
		reset => reset,
    button => state_Button,
    clk => clk,
    inputBits => bits_input,
    onesSSD => open,
    tensSSD => open,
    hundredsSSD => open
	);
end arch;