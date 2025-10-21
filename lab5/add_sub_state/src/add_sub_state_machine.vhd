library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_state_machine is
    port (
        reset           : in std_logic;
        clk             : in std_logic;
        button          : in std_logic;
        inputBits       : in std_logic_vector(7 downto 0);
        onesSSD         : out std_logic_vector(6 downto 0);
        tensSSD         : out std_logic_vector(6 downto 0);
        hundredsSSD     : out std_logic_vector(6 downto 0)
    );
end entity add_sub_state_machine;

architecture beh of add_sub_state_machine is

type ASstates is (state_aInput, state_bInput, state_dispSum, state_dispDiff);
signal currentState : ASstates;
signal nextState : ASstates;
--constant state_aInput   : std_logic_vector(3 downto 0) := "0001";
--constant state_bInput   : std_logic_vector(3 downto 0) := "0010";
--constant state_dispSum  : std_logic_vector(3 downto 0) := "0100";
--constant state_dispDiff : std_logic_vector(3 downto 0) := "1000";
--signal currentState     : std_logic_vector(3 downto 0);
--signal nextState        : std_logic_vector(3 downto 0);

component synchronizer is
    generic (
        bits    : integer := 8
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
component double_dabble is
    port (
        result_padded           : in  std_logic_vector(11 downto 0); 
        ones                    : out std_logic_vector(3 downto 0);
        tens                    : out std_logic_vector(3 downto 0);
        hundreds                : out std_logic_vector(3 downto 0)
    );
end component double_dabble;
component add_sub is
    generic (
        bits    : integer := 8
    );
    port (
        a               : in  std_logic_vector(bits-1 downto 0);
        b               : in  std_logic_vector(bits-1 downto 0);
        add_sub_toggle  : in std_logic;
        result          : out std_logic_vector(bits downto 0)
    );
end component add_sub;

signal onesDigit        : std_logic_vector(3 downto 0);
signal tensDigit        : std_logic_vector(3 downto 0);
signal hundredsDigit    : std_logic_vector(3 downto 0);
signal paddedOutput     : std_logic_vector(11 downto 0);
signal unpaddedResults  : std_logic_vector(8 downto 0);
signal syncedInput      : std_logic_vector(7 downto 0);
signal syncedButton     : std_logic;
--signal buttonFlag       : std_logic;
signal a_signal         : std_logic_vector(7 downto 0);
signal b_signal         : std_logic_vector(7 downto 0);
signal add_sub_flag     :std_logic := '0';


begin
    inputSync:synchronizer
        port map (
            input => inputBits,
            clk => clk,
            reset => reset,
            output => syncedInput
        );
    buttonSync:rising_edge_synchronizer
        port map (
            clk => clk,
            reset => reset,
            input => button,
            edge => syncedButton
        );
    addSub_Main:add_sub
    port map (
        a => a_signal,
        b => b_signal,
        add_sub_toggle => add_sub_flag,
        result => unpaddedResults
    );
    outputSplitter:double_dabble
        port map (
            result_padded => paddedOutput,
            ones => onesDigit,
            tens => tensDigit,
            hundreds => hundredsDigit
        );
    onesOut:seven_seg
        port map (
            reset => reset,
            bcd => onesDigit,
            seven_seg_out => onesSSD
        );
    tensOut:seven_seg
        port map (
            reset => reset,
            bcd => tensDigit,
            seven_seg_out => tensSSD
        );
    hundOut:seven_seg
        port map (
            reset => reset,
            bcd => hundredsDigit,
            seven_seg_out => hundredsSSD
        );

    process (clk, reset)
    begin
        if (reset = '1') then
            currentState <= state_aInput;
        elsif (clk'event and clk = '1') then
            currentState <= nextState;
        end if;
    end process;

    process (clk, currentState)
    begin
        if (clk'event and clk = '1') then
        case currentState is
            when state_aInput =>
                paddedOutput <= ("0000" & syncedInput);
            when state_bInput =>
                paddedOutput <= ("0000" & syncedInput);
            when state_dispSum|state_dispDiff =>
                paddedOutput <= ("000" & unpaddedResults);
            when others =>
                null;
        end case;
        end if;
    end process;


    process (currentState, syncedButton)
    begin
        nextState <= currentState;

        case currentState is
            when state_aInput =>
                a_signal <= syncedInput;
                --paddedOutput <= ("0000" & syncedInput);
                if (syncedButton = '1') then
                    nextState <= state_bInput;
                end if;
            when state_bInput =>
                b_signal <= syncedInput;
                --paddedOutput <= ("0000" & syncedInput);
                if (syncedButton = '1') then
                    nextState <= state_dispSum;
                end if;
            when state_dispSum =>
                add_sub_flag <= '0';
                --paddedOutput <= ("000" & unpaddedResults);
                if (syncedButton = '1') then
                    nextState <= state_dispDiff;
                end if;
            when state_dispDiff =>
                add_sub_flag <= '1';
                --paddedOutput <= ("000" & unpaddedResults);
                if (syncedButton = '1') then
                    nextState <= state_aInput;
                end if;
            when others =>
                nextState <= state_aInput;
        end case;
    end process;
end architecture beh;