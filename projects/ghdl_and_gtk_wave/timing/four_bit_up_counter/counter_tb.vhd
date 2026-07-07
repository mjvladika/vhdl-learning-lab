library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture sim of counter_tb is

component counter
	port(
		rst, clk : in std_logic;
		output : out std_logic_vector(0 to 3)
	);
end component;

signal rst, clk : std_logic;
signal output : std_logic_vector(0 to 3);

begin
uut: counter port map(
	clk => clk,
	rst => rst,
	output => output
);

clock_process : process
begin
	clk <= '0';
	wait for 10 ns;
	clk <= '1';
	wait for 10 ns;
end process;

stim_process : process
begin
	rst <= '1';
	wait for 20 ns;
	rst <= '0';
	wait;
end process;

end sim;
