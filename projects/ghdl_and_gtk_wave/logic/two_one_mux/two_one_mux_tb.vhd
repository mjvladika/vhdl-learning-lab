library ieee;
use ieee.std_logic_1164.all;

entity two_one_mux_tb is
end two_one_mux_tb;

architecture sim of two_one_mux_tb is

signal a : std_logic := '0';
signal b : std_logic := '0';
signal c : std_logic := '0';
signal y : std_logic;

begin

uut: entity work.two_one_mux
port map(
	a => a,
	b => b,
	c => c,
	y => y
);

process
begin
	a <= '0'; b <= '0'; c <= '0'; wait for 10 ns;
	a <= '0'; b <= '0'; c <= '1'; wait for 10 ns;
	a <= '0'; b <= '1'; c <= '0'; wait for 10 ns;
	a <= '0'; b <= '1'; c <= '1'; wait for 10 ns;
	a <= '1'; b <= '0'; c <= '0'; wait for 10 ns;
	a <= '1'; b <= '0'; c <= '1'; wait for 10 ns;
	a <= '1'; b <= '1'; c <= '0'; wait for 10 ns;
	a <= '1'; b <= '1'; c <= '1'; wait for 10 ns;
	wait;
end process;

end sim;
