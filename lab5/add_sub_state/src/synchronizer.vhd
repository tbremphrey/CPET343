library ieee;
use ieee.std_logic_1164.all;

entity synchronizer is
    generic (
        bits    : integer := 8
    );
    port (
        input   : in  std_logic_vector(bits-1 downto 0);
        clk     : in std_logic;
        reset   : in std_logic;
        output  : out std_logic_vector(bits-1 downto 0)
    );
end entity synchronizer;

architecture arch of synchronizer is

    signal temp_hold : std_logic_vector(bits-1 downto 0);
    
    begin
        process (clk, reset)
        begin
            if (reset = '1') then
            temp_hold <= "00000000";
            output <= "00000000";
            elsif (clk'event and clk = '1') then
                temp_hold <= input;
                output <= temp_hold;
            end if;
        end process;
    end arch;