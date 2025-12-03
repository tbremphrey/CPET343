-------------------------------------------------------------------------------
-- Tyler Remphrey
-- Lab 7
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab7_top is
    port (
        nextButton  :in std_logic;
        resetButton :in std_logic;
        clk         :in std_logic;
        stateLED    :out std_logic_vector(3 downto 0);
        SSD0        :out std_logic_vector(6 downto 0);
        SSD1        :out std_logic_vector(6 downto 0);
        SSD2        :out std_logic_vector(6 downto 0)
    );
end entity lab7_top;

architecture beh of lab7_top is
    component blink_rom
		port(
			address         : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			clock           : IN STD_LOGIC  := '1';
			q               : OUT STD_LOGIC_VECTOR (12 DOWNTO 0)
		);
	end component;
	
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
        hundredsSSD     : out std_logic_vector(6 downto 0);
        stateLED        : out std_logic_vector(3 downto 0)
    );
    end component calc_state_machine;
    
    component rising_edge_synchronizer is 
        port (
        clk               : in std_logic;
        reset             : in std_logic;
        input             : in std_logic;
        edge              : out std_logic
    );
    end component rising_edge_synchronizer;
    
    type programCounterStates is (state_wait, state_read);
    signal currentState : programCounterStates;
    signal nextState : programCounterStates;
    
    signal execute   : std_logic;
    signal reset  : std_logic;
    
    signal syncedNext     : std_logic;
    signal instruction    : std_logic_vector(12 downto 0);    -- operatorBits & inputBits & msBit & mrBit & exBit
    signal inputBits      : std_logic_vector(7 downto 0);
    signal operatorBits   : std_logic_vector(1 downto 0);
    signal msBit          : std_logic;
    signal mrBit          : std_logic;
    signal exBit          : std_logic;
    signal blipFlag       : std_logic;
    
    signal address_sig    : std_logic_vector(4 downto 0) := "00000";
    
    signal programCounter : std_logic_vector(4 downto 0) := "00001";
    
    begin
        reset <= not resetButton; --change to not for hardware
        execute <= not nextButton; --change to not for hardware
		
        operatorBits <= instruction(12 downto 11);
        inputBits <= instruction(10 downto 3);
        
        process (blipFlag, clk)
        begin
            if (clk'event and clk = '1') then
                if(blipFlag = '1') then
                    msBit <= instruction(2);
                    mrBit <= instruction(1);
                    exBit <= instruction(0);
                else 
                    msBit <= '0';
                    exBit <= '0';
                    mrBit <= '0';
                end if;
            end if;
        end process;
        
        process (clk, reset)
        begin
            if (reset = '1') then
                currentState <= state_wait;
            elsif (clk'event and clk = '1') then
                currentState <= nextState;
            end if;
        end process;
        
        process (clk, currentState, reset)
        begin
            if (reset = '1') then
				address_sig <= "00000";
				programCounter <= "00001";
			elsif (clk'event and clk = '1' and reset = '0') then
            case currentState is
                when state_wait =>
                    blipFlag <= '0';
                when state_read =>
                    programCounter <= std_logic_vector(unsigned(programCounter) + 1);
                    address_sig <= programCounter;
                    blipFlag <= '1';
                end case;
            end if;
        end process;


        process (currentState, syncedNext)
        begin
            nextState <= currentState;

            case currentState is
                when state_wait =>
                    
                    if (syncedNext = '1') then
                        nextState <= state_read;
                    end if;
                when state_read =>
                    nextState <= state_wait;
            end case;
        end process;
        
        
        
        rom_inst : blink_rom 
            port map (
                address     => address_sig,
                clock       => clk,
                q           => instruction
            );
        
        calcMain : calc_state_machine
            port map (
                reset => reset,
                clk => clk,
                execute => exBit,
                mSave => msBit,
                mRecall => mrBit,
                inputOperator => operatorBits,
                inputBits => inputBits,
                onesSSD => SSD0,
                tensSSD => SSD1,
                hundredsSSD => SSD2,
                stateLED => stateLED
            );
        nextSyncronizer : rising_edge_synchronizer
            port map (
                clk => clk,
                reset => reset,
                input => execute,
                edge => syncedNext
            );
        
        
        
end architecture beh;