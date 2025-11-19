-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calc_state_machine_tb is
end calc_state_machine_tb;

architecture arch of calc_state_machine_tb is

component calc_state_machine is
    port (
        reset           : in std_logic;
        clk             : in std_logic;
        execute         : in std_logic;
		mSave           : in std_logic;
		mRecall         : in std_logic;
        inputOperator   : in std_logic_vector(1 downto 0);
        inputBits       : in std_logic_vector(7 downto 0);
        onesSSD         : out std_logic_vector(6 downto 0);
        tensSSD         : out std_logic_vector(6 downto 0);
        hundredsSSD     : out std_logic_vector(6 downto 0)
    );
end component; 

constant period     : time := 20ns;                                              

signal exButton    : std_logic:= '0';
signal rcButton    : std_logic:= '0';
signal svButton    : std_logic:= '0';
signal inOperator  : std_logic_vector(1 downto 0) := "00";
signal inBits      : std_logic_vector (7 downto 0):="00000000";
signal clk         : std_logic := '0';
signal reset       : std_logic := '1';

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
		inBits <= "00000100";
		inOperator <= "00";
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		
		inBits <= "00001000";
		inOperator <= "10";
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';

		wait for 5*period;
		svButton <= '1';
		wait for 5*period;
		svButton <= '0';
		
		inBits <= "00001000";
		inOperator <= "01";
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		
		inBits <= "00000010";
		inOperator <= "11";
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';

		wait for 5*period;
		rcButton <= '1';
		wait for 5*period;
		rcButton <= '0';
		
		inBits <= "00000010";
		inOperator <= "11";
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
	report "********* End TB *********";
	wait;
end process;

uut: calc_state_machine
	port map(
	reset => reset,
    clk => clk,
    execute => exButton,
	mSave => svButton,
	mRecall => rcButton,
    inputOperator => inOperator,
    inputBits => inBits,
    onesSSD => open,
    tensSSD => open,
    hundredsSSD => open
	);
end arch;