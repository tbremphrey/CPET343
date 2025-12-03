LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity counter is
	port (
        set_n, reset_n : in std_logic;
        enable, clk : in std_logic;
        set_time : in std_logic_vector (9 downto 0);
        count_out: out std_logic_vector (9 downto 0)   
    );
	
end entity counter;

architecture behavioral of counter is

CONSTANT max_count : unsigned (11 downto 0) := x"3E7"; 
signal internal_count, unsinged_timeIn : unsigned (9 downto 0);
    
begin
    unsinged_timeIn <= unsigned(set_time);

    countMain: process (reset_n, clk)
        begin
            if (reset_n = '0') then
                internal_count <= (others => '0');              --asynchronous active_low reset 
            elsif (rising_edge(clk)) then                       --synchronous section
                if (set_n = '1') then                           
                    internal_count <= unsinged_timeIn;          --sets the internal count to 10 bit time input
                elsif (enable = '1') then                       --if the flag is active
                    if (internal_count = max_count) then       
                        internal_count <= (others => '0');      --rolls over if at max count
                    else
                        internal_count <= internal_count + 1;    --increments count otherwise
                    end if;
                end if;
            end if;
        end process;

    count_out <= std_logic_vector(internal_count);
end architecture behavioral;