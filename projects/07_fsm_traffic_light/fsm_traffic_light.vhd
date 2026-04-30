library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_traffic_light is
    port(
        clk, rst : in std_logic;
        nsR, nsY, nsG, ewR, ewY, ewG : out std_logic
    );
end entity;

architecture rtl of fsm_traffic_light is

type all_states is (RG, RY, GR, YR);
signal current_state : all_states;
signal count : unsigned(1 downto 0) := "00";

begin
    handle_state : process(clk, rst)
    begin
        report "CURRENT STATE: " & all_states'image(current_state);

        if(falling_edge(rst)) then
            report "falling edge of reset";
            current_state <= RG;
        elsif(rising_edge(clk)) then
            count <= count + 1;

            if (count = 3) then
                if(current_state = all_states'right) then
                    current_state <= all_states'left;
                else
                    current_state <= all_states'succ(current_state);
                end if;

                count <= "00";
            end if;
        end if;
    end process;

    light_leds : process(current_state, count)
    begin
        case current_state is
            when RG =>
                nsR <= '1'; nsY <= '0'; nsG <= '0';
                ewR <= '0'; ewY <= '0'; ewG <= '1';
            when RY =>
                nsR <= '1'; nsY <= '0'; nsG <= '0';
                ewR <= '0'; ewY <= '1'; ewG <= '0';
            when GR =>
                nsR <= '0'; nsY <= '0'; nsG <= '1';
                ewR <= '1'; ewY <= '0'; ewG <= '0';
            when YR =>
                nsR <= '0'; nsY <= '1'; nsG <= '0';
                ewR <= '1'; ewY <= '0'; ewG <= '0';
            when others =>
                nsR <= '0'; nsY <= '0'; nsG <= '0';
                ewR <= '0'; ewY <= '0'; ewG <= '0';
        end case;
    end process;

end rtl;
