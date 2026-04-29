library ieee;
use ieee.std_logic_1164.all;

entity led_blinker_tb is
end led_blinker_tb;

architecture sim of led_blinker_tb is

component led_blinker
	port(
		rst, clk : in std_logic;
		led : out std_logic
	);
end component;

signal rst, clk : std_logic;
signal led : std_logic;
signal sim_done : boolean := false;

begin
uut: led_blinker port map(
	clk => clk,
	rst => rst,
	led => led
);

clk_process : process
begin
    while not sim_done loop
        clk <= '0'; wait for 20 ns;
        clk <= '1'; wait for 20 ns;
    end loop;
    wait;
end process;

stim_proc: process
begin
    rst <= '1'; 
    wait for 10 ns;
    rst <= '0'; 
    report "waiting for 1 ms now";
    wait for 1 ms; 
    report "done waiting for 1 ms";
    sim_done <= true; 
    wait;
end process;

end sim;