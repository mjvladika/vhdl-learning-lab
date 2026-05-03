library ieee;
use ieee.std_logic_1164.all;

entity xor_gate_tb is
end xor_gate_tb;

architecture sim of xor_gate_tb is

signal a : std_logic := '0';
signal b : std_logic := '0';
signal y : std_logic;

begin

uut: entity work.xor_gate
port map(
	a => a,
	b => b,
	y => y
);

process
begin
	a <= '0'; b <= '0'; wait for 10 ns;
	a <= '0'; b <= '1'; wait for 10 ns;
	a <= '1'; b <= '0'; wait for 10 ns;
	a <= '1'; b <= '1'; wait for 10 ns;
	wait;
end process;

end sim;
