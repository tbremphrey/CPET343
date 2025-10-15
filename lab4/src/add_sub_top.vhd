library ieee;
use ieee.std_logic_1164.all;

entity add_sub_top is
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
end entity add_sub_top;

architecture arch of add_sub_top is

component synchronizer is
    generic (
        bits    : integer := 3
    );
    port (
        input   : in  std_logic_vector(bits-1 downto 0);
        clk     : in std_logic;
		reset   : in std_logic;
        output  : out std_logic_vector(bits-1 downto 0)
    );
end component synchronizer;
component rising_edge_synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component rising_edge_synchronizer;
component seven_seg is
  port (
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
end component seven_seg;
component add_sub is
  generic (
    bits    : integer := 4
  );
  port (
    a           : in  std_logic_vector(bits-2 downto 0);
    b           : in  std_logic_vector(bits-2 downto 0);
    add_button  : in std_logic;
    sub_button  : in std_logic;
    clk         : in std_logic;
    result      : out std_logic_vector(bits-1 downto 0)
  );
end component add_sub;

signal a_4bit         : std_logic_vector(3 downto 0);
signal b_4bit         : std_logic_vector(3 downto 0);
signal a_synchronized : std_logic_vector(2 downto 0);
signal b_synchronized : std_logic_vector(2 downto 0);
signal add_enable     : std_logic;
signal sub_enable     : std_logic;
signal add_sub_result : std_logic_vector(3 downto 0);

begin
    a_syn:synchronizer
	    port map (
        input => a,
		reset => reset,
        clk => clk,
        output => a_synchronized
    );
	b_syn:synchronizer
	        port map (
            input => b,
			reset => reset,
            clk => clk,
            output => b_synchronized
    );
	add_res:rising_edge_synchronizer
	    port map (
            clk => clk,
            reset => reset,
            input => add_button,
            edge => add_enable
        );
	sub_res:rising_edge_synchronizer
	    port map (
            clk => clk,
            reset => reset,
            input => sub_button,
            edge => sub_enable
        );
	hex4:seven_seg
	    port map (
			reset => reset,
            bcd => a_4bit,
			seven_seg_out => a_num_out
		);
	hex2:seven_seg
	    port map (
			reset => reset,
            bcd => b_4bit,
			seven_seg_out => b_num_out
		);
	hex0:seven_seg
	    port map (
			reset => reset,
            bcd => add_sub_result,
			seven_seg_out => result_out
		);
	add_sub_main:add_sub
		port map(
			a => a_synchronized,
			b => b_synchronized,
			add_button => add_enable,
			sub_button => sub_enable,
			clk => clk,
			result => add_sub_result
		);
		
	--Make 4 bit signals for SSD
	process(a_synchronized, b_synchronized)
	begin
	a_4bit <= '0' & a_synchronized;
	b_4bit <= '0' & b_synchronized;
	end process;

end arch;