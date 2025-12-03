-------------------------------------------------------------------------------
-- Tyler Remphrey
-- lab 7 test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab7_top_tb is
end lab7_top_tb;

architecture arch of lab7_top_tb is

component lab7_top is
    port (
        nextButton  :in std_logic;
        resetButton :in std_logic;
        clk         :in std_logic;
        stateLED    :out std_logic_vector(3 downto 0);
        SSD0        :out std_logic_vector(6 downto 0);
        SSD1        :out std_logic_vector(6 downto 0);
        SSD2        :out std_logic_vector(6 downto 0)
    );
end component; 

constant period     : time := 20ns;                                              

signal exButton         : std_logic:= '0';
signal invertedExButton : std_logic;
signal clk              : std_logic := '0';
signal reset            : std_logic := '1';
signal invertedReset    : std_logic;

begin
invertedExButton <= not exButton;
invertedReset <= not reset;

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
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		--------------------------------
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		--------------------------------
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		--------------------------------
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		--------------------------------
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		--------------------------------
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		--------------------------------
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
		
		wait for 5*period;
		exButton <= '1';
		wait for 5*period;
		exButton <= '0';
	report "********* End TB *********";
	wait;
end process;

uut: lab7_top
	port map(
		nextButton => invertedExButton,
		resetButton => invertedReset,
		clk => clk,
		stateLED => open,
		SSD0 => open,
		SSD1 => open,
		SSD2 => open
	);
end arch;