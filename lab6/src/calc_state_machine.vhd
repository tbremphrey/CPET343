library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_state_machine is
    port (
        reset           : in std_logic;
        clk             : in std_logic;
        execute         : in std_logic;
		MS              : in std_logic;
		MR              : in std_logic;
        inputBits       : in std_logic_vector(7 downto 0);
        onesSSD         : out std_logic_vector(6 downto 0);
        tensSSD         : out std_logic_vector(6 downto 0);
        hundredsSSD     : out std_logic_vector(6 downto 0)
    );
end entity add_sub_state_machine;

architecture beh of add_sub_state_machine is

type CalcStates is (state_readW, state_readS, state_writeW, state_writeS, state_mathOP, state_memClear);
signal currentState : CalcStates;
signal nextState : CalcStates;

type ram_type is array (3 downto 0) of std_logic_vector (7 downto 0);
signal calcMemory : ram_type;

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
component alu is
	port (
		clk           : in  std_logic;
		reset         : in  std_logic;
		a             : in  std_logic_vector(7 downto 0); 
		b             : in  std_logic_vector(7 downto 0);
		op            : in  std_logic_vector(1 downto 0); -- 00: add, 01: sub, 10: mult, 11: div
		result        : out std_logic_vector(7 downto 0)
	);  
end component alu;

signal onesDigit        : std_logic_vector(3 downto 0);
signal tensDigit        : std_logic_vector(3 downto 0);
signal hundredsDigit    : std_logic_vector(3 downto 0);
signal paddedOutput     : std_logic_vector(11 downto 0);
signal aluOut  : std_logic_vector(7 downto 0);
signal clockedOutput    : std_logic_vector(7 downto 0);
signal syncedInput      : std_logic_vector(7 downto 0);
signal syncedExecute    : std_logic;
signal syncedMS         : std_logic;
signal syncedMR         : std_logic;
signal memIn         : std_logic_vector(7 downto 0);
signal memOut         : std_logic_vector(7 downto 0);
signal b_signal         : std_logic_vector(7 downto 0);
signal memAddress		: std_logic_vector(1 downto 0);
signal writeFlag		: std_logic;


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

memOut <= calcMemory(to_integer(unsigned(memAddress)));
calcMemory(to_integer(unsigned(memAddress))) <= clockedOutput;

    process (clk, reset)
    begin
        if (reset = '1') then
            currentState <= state_memClear;
        elsif (clk'event and clk = '1') then
            currentState <= nextState;
        end if;
    end process;

    process (clk, currentState)
    begin
        if (clk'event and clk = '1') then
        case currentState is
            when state_memClear =>
				memAddress <= "00";
				writeFlag <= '1';
				clockedOutput <= "00000000";
			when state_readW =>
				writeFlag <= '0';
				memAddress <= "00";
            when state_writeS =>
                memAddress <= "01";
				writeFlag <= '1';
            when state_mathOP =>
                clockedOutput <= aluOut;
			when state_writeW =>
				memAddress <= "09";
				writeFlag <= '1';
			when state_readS =>
				writeFlag <= '0';
				memAddress <= "01";
				clockedOutput <= memOut;
            when others =>
                null;
        end case;
        end if;
    end process;


    process (currentState, reset, syncedExecute, syncedMR, syncedMS)
    begin
        nextState <= currentState;

        case currentState is
            when state_memClear =>
                if (reset = '0') then
                    nextState <= state_readW;
                end if;
            when state_readW =>
				if (syncedMS = '1') then
					nextState <= state_writeS;
				elsif (syncedMR = '1') then
					nextState <= state_readS;
				elsif (execute = '1') then
					nextState <= state_mathOP;
				end if;
			when state_readS =>
				if (execute = '1') then
					nextState <= state_mathOP;
				end if;
			when state_writeS =>
				nextState <= state_readW;
			when state_mathOP =>
				nextState <= state_writeW;
			when state_writeW =>
				nextState => state_readW;
        end case;
    end process;
end architecture beh;