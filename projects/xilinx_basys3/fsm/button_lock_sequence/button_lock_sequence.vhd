----- Unlock Sequence: BCA ----- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity button_lock_sequence is
    port(
        clk      : in std_logic;
        reset    : in std_logic;
        btn_a    : in std_logic;
        btn_b    : in std_logic;
        btn_c    : in std_logic;
        unlocked : out std_logic := '0';
        locked_led : out std_logic := '1';
        ajar_led   : out std_logic;
        first_led  : out std_logic;
        second_led : out std_logic
    );
end entity;

architecture rtl of button_lock_sequence is 
    type all_states is (LOCKED, AJAR, FIRST, SECOND);

    signal curr_state  : all_states := LOCKED;
    signal prev_a      : std_logic := '0';
    signal prev_b      : std_logic := '0';
    signal prev_c      : std_logic := '0';
    signal count       : unsigned(17 downto 0) := "000000000000000000";
    signal btn_a_state : unsigned(3 downto 0) := "0000";
    signal btn_a_press : std_logic := '0';
    signal btn_b_state : unsigned(3 downto 0) := "0000";
    signal btn_b_press : std_logic := '0';
    signal btn_c_state : unsigned(3 downto 0) := "0000";
    signal btn_c_press : std_logic := '0';
    
begin
    process(clk, reset)
    begin
        if reset = '1' then
            curr_state <= LOCKED;
            
            locked_led <= '1';
            ajar_led <= '0';
            first_led <= '0';
            second_led <= '0';
            
            prev_a <= '0';
            prev_b <= '0';
            prev_c <= '0';
            
            btn_a_state <= "0000";
            btn_b_state <= "0000";
            btn_c_state <= "0000";
            
            count <= "000000000000000000";
        elsif(rising_edge(clk)) then
            count <= count + 1;

		    if(count = 250000) then
                btn_a_state <= shift_left(btn_a_state, 1);
                btn_a_state(0) <= btn_a;
                
                if(btn_a_state = "1111") then
                    btn_a_press <= '1';
                else
                    btn_a_press <= '0';
                end if;
                
                btn_b_state <= shift_left(btn_b_state, 1);
                btn_b_state(0) <= btn_b;
                
                if(btn_b_state = "1111") then
                    btn_b_press <= '1';
                else
                    btn_b_press <= '0';
                end if;
                
                btn_c_state <= shift_left(btn_c_state, 1);
                btn_c_state(0) <= btn_c;
                
                if(btn_c_state = "1111") then
                    btn_c_press <= '1';
                else
                    btn_c_press <= '0';
                end if;
                
                case curr_state is
                    when LOCKED => 
                        unlocked <= '0';
        
                        if(prev_b = '0' and btn_b_press = '1') then
                            curr_state <= FIRST;
                            
                            locked_led <= '0';
                            ajar_led <= '0';
                            first_led <= '1';
                            second_led <= '0';
                        end if;
                    when AJAR =>
                        unlocked <= '1';
                        
                        locked_led <= '0';
                        ajar_led <= '1';
                        first_led <= '0';
                        second_led <= '0';
                    when FIRST =>
                        unlocked <= '0';
        
                        if(prev_c = '0' and btn_c_press = '1') then
                            curr_state <= SECOND;
                            
                            locked_led <= '0';
                            ajar_led <= '0';
                            first_led <= '0';
                            second_led <= '1';
                        elsif((prev_a = '0' and btn_a_press = '1') or (prev_b = '0' and btn_b_press = '1')) then
                            curr_state <= LOCKED;
                            
                            locked_led <= '1';
                            ajar_led <= '0';
                            first_led <= '0';
                            second_led <= '0';
                        end if;
                    when SECOND =>
                        unlocked <= '0';
        
                        if(prev_a = '0' and btn_a_press = '1') then
                            curr_state <= AJAR;
                            
                            locked_led <= '0';
                            ajar_led <= '1';
                            first_led <= '0';
                            second_led <= '0';
                        elsif((prev_b = '0' and btn_b_press = '1') or (prev_c = '0' and btn_c_press = '1')) then
                            curr_state <= LOCKED;
                            
                            locked_led <= '1';
                            ajar_led <= '0';
                            first_led <= '0';
                            second_led <= '0';
                        end if;
                end case;
        
                prev_a <= btn_a_press;
                prev_b <= btn_b_press;
                prev_c <= btn_c_press;

                count <= "000000000000000000";
		    end if;
        end if;
    end process;
end architecture;