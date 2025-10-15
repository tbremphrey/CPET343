-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_tb is
end add_sub_tb;

architecture arch of add_sub_tb is

component add_sub_top is
	port (
		a          : in  std_logic_vector(2 downto 0);
        b          : in  std_logic_vector(2 downto 0);
		clk        : in std_logic;
		reset      : in std_logic;
		add_button : in std_logic;
		sub_button : in std_logic;
		a_num_out  : out std_logic_vector(6 downto 0);
		b_num_out  : out std_logic_vector(6 downto 0);
		result_out : out std_logic_vector(6 downto 0)
	);
end component; 

signal add_input    : std_logic:= '0';
signal sub_input    :std_logic:='1';
signal a_input      : std_logic_vector (2 downto 0):="000";
signal b_input      : std_logic_vector (2 downto 0):="000";
constant period     : time := 20ns;                                              
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
	for i in 0 to 1 loop
		add_input <= not add_input;
		sub_input <= not sub_input;
		for j in 0 to 7 loop
			a_input <= std_logic_vector(unsigned(a_input)+1);
			for k in 0 to 7 loop
				b_input <= std_logic_vector(unsigned(b_input)+1);
				wait for 2*period;
			end loop;
			wait for 2*period;
		end loop;
		wait for 4*period;
	end loop;
	report "********* End TB *********";
	wait;
end process;

uut: add_sub_top  
	port map(
		a => a_input,
        b => b_input,
		clk => clk,
		reset => reset,
		add_button => add_input,
		sub_button => sub_input,
		a_num_out => open,
		b_num_out => open,
		result_out => open
	);
end arch;