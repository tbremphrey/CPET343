LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity delay_unit is
    port (
        maxValue : in std_logic_vector(23 downto 0); --Ask if unsigned input is better
        clk, reset_n : in std_logic;
        flag : out std_logic
    );
	
end entity delay_unit;

architecture behavioral of delay_unit is

signal count, unsigned_max : unsigned(23 downto 0);

begin
    unsigned_max <= unsigned(maxValue);

    count1 : process (clk, reset_n) 
        begin
            if (reset_n = '0') then             --asynchronous active_low reset
                count <= (others => '0');       --sets all values in count to 0
            elsif (rising_edge(clk)) then       --Synchronous
                if (count = unsigned_max) then  --If max, set to 0
                    count <= (others => '0');
                else
                    count <= count + 1;         --else increment count
                end if;
            end if;
        end process;

    flagProcess : process(clk, reset_n)
    begin
        if (reset_n = '0') then
            flag <= '0';
        elsif (rising_edge(clk)) then
            if (count = unsigned_max) then  --If max, raise flag
                flag <= '1';
            else
                flag <= '0';
            end if;
        end if;
    end process;

	
end architecture behavioral;