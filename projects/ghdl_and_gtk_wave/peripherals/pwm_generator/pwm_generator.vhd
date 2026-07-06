library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_generator is
    port(
        clock      : in std_logic;
        duty_cycle : in unsigned(3 downto 0);
        pwm_output : out std_logic := '0'
    );
end entity;

architecture rtl of pwm_generator is
    signal frequency  : unsigned(3 downto 0) := "1111";
    signal freq_count : unsigned(3 downto 0) := "0000";
begin
    process(clock)
    begin
        if(rising_edge(clock)) then
            freq_count <= freq_count + 1;

            if(freq_count < duty_cycle) then
                pwm_output <= '1';
            elsif(freq_count > duty_cycle) then
                pwm_output <= '0';
            elsif(freq_count = frequency) then
                freq_count <= "0000";
            end if;
        end if;
    end process;
end architecture;

