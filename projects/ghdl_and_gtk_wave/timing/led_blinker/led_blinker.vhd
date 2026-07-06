library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_blinker is
    port(
		rst, clk : in std_logic;
		led : out std_logic
	);
end led_blinker;

architecture rtl of led_blinker is

signal count : unsigned(5 downto 0) := "000000";
signal led_toggle : std_logic := '0';

begin
    process(clk, rst)
    begin
        if (rst = '1') then
            count <= "000000";
            led_toggle <= '0';
        elsif (rising_edge(clk)) then
            count <= count + 1;

            if (count = 50) then
                led_toggle <= not led_toggle;
                count <= "000000";
            end if;
        end if;
    end process;

    led <= led_toggle;
end rtl;