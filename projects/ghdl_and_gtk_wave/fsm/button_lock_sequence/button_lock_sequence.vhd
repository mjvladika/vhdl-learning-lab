----- Unlock Sequence: BCA ----- 

library ieee;
use ieee.std_logic_1164.all;

entity button_lock_sequence is
    port(
        clock    : in std_logic;
        btn_a    : in std_logic;
        btn_b    : in std_logic;
        btn_c    : in std_logic;
        unlocked : out std_logic := '0'
    );
end entity;

architecture rtl of button_lock_sequence is 
    type all_states is (LOCKED, AJAR, FIRST, SECOND);

    signal curr_state : all_states;
    signal prev_a     : std_logic := '0';
    signal prev_b     : std_logic := '0';
    signal prev_c     : std_logic := '0';
begin
    process(clock, btn_a, btn_b, btn_c)
    begin
        if(rising_edge(clock)) then
            case curr_state is
                when LOCKED => 
                    unlocked <= '0';

                    if(prev_b = '0' and btn_b = '1') then
                        curr_state <= FIRST;
                    end if;
                when AJAR =>
                    unlocked <= '1';
                when FIRST =>
                    unlocked <= '0';

                    if(prev_c = '0' and btn_c = '1') then
                        curr_state <= SECOND;
                    elsif((prev_a = '0' and btn_a = '1') or (prev_b = '0' and btn_b = '1')) then
                        curr_state <= LOCKED;
                    end if;
                when SECOND =>
                    unlocked <= '0';

                    if(prev_a = '0' and btn_a = '1') then
                        curr_state <= AJAR;
                    elsif((prev_b = '0' and btn_b = '1') or (prev_c = '0' and btn_c = '1')) then
                        curr_state <= LOCKED;
                    end if;
            end case;

            prev_a <= btn_a;
            prev_b <= btn_b;
            prev_c <= btn_c;
        end if;
    end process;
end architecture;