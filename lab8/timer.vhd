LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity timer is
    port (
        set_n, reset_n : in std_logic;
        clk : in std_logic;
        S :in std_logic;
        time_in : std_logic_vector (9 downto 0);
        hex2, hex1, hex0 : out std_logic_vector (6 downto 0)
    );
end entity timer;

architecture structural of timer is

    component delay_unit is
        port (
            maxValue : in std_logic_vector(23 downto 0);
            clk, reset_n : in std_logic;
            flag : out std_logic
            
        );
    end component delay_unit;
    
    component counter is
        port (
            set_n, reset_n : in std_logic;
            enable, clk : in std_logic;
            set_time : in std_logic_vector (9 downto 0);
            count_out: out std_logic_vector (9 downto 0) 
        );
    end component counter;
    
    component bin2ssd is
        port (
            in_num : in std_logic_vector(9 downto 0);
            hex2, hex1, hex0 : out std_logic_vector(6 downto 0)
        );
    end component bin2ssd;


    constant ms100 : std_logic_vector (23 downto 0) := x"4C4B40";
    constant ns100 : std_logic_vector (23 downto 0) := x"000005";

    signal flag : std_logic;
    signal delayInterval : std_logic_vector (23 downto 0);
    signal counterValue : std_logic_vector (9 downto 0);

    begin
        delayUnit : delay_unit
        port map (
            maxValue => delayInterval,
            clk => clk,
            reset_n => reset_n,
            flag => flag
        );
        
        mainCounter : counter
        port map (
            set_n => set_n,
            reset_n =>reset_n,
            enable => flag,
            clk => clk,
            set_time => time_in,
            count_out => counterValue
        );

        binary_to_display : bin2ssd
        port map (
            in_num => counterValue,
            hex2 => hex2,
            hex1 => hex1,
            hex0 => hex0
        );


        delay_mux: process (S)
            begin    
                case (s) is
                    when '1' => 
                        delayInterval <= ms100;
                    when '0' => 
                        delayInterval <= ns100;
                    when others =>
                        null;
                end case;
            end process;
    end architecture structural;