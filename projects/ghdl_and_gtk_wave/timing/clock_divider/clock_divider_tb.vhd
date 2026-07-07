library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_divider_tb is
end clock_divider_tb;

architecture sim of clock_divider_tb is

component clock_divider
	port(
		rst, clk : in std_logic;
		clk_out : out std_logic
	);
end component;

signal rst, clk : std_logic;
signal clk_out : std_logic;
signal sim_done : boolean := false;

constant clk_period : time := 10 ns;

begin
uut: clock_divider port map(
	clk => clk,
	rst => rst,
	clk_out => clk_out
);

clk_process : process
begin
    while not sim_done loop
        clk <= '0'; wait for clk_period/2;
        clk <= '1'; wait for clk_period/2;
    end loop;
    wait;
end process;

stim_proc: process
begin
    rst <= '1'; 
    wait for 20 ns;
    rst <= '0'; 
    wait for 580 ns; 
    sim_done <= true; 
    wait;
end process;

end sim;