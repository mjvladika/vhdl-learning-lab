library ieee;
use ieee.std_logic_1164.all;

entity fsm_traffic_light_tb is
end entity;

architecture sim of fsm_traffic_light_tb is

component fsm_traffic_light
    port(
        clk, rst : in std_logic;
        nsR, nsY, nsG, ewR, ewY, ewG : out std_logic
    );
end component;

signal clk, rst, nsR, nsY, nsG, ewR, ewY, ewG : std_logic;
signal sim_done : boolean := false;

begin

uut : fsm_traffic_light port map(
	clk => clk,
	rst => rst,
	nsR => nsR,
	nsY => nsY,
	nsG => nsG,
	ewR => ewR,
	ewY => ewY,
	ewG => ewG
);

clk_process : process
begin
    while not sim_done loop
        clk <= '0'; 
        wait for 20 ns;
        clk <= '1'; 
        wait for 20 ns;
    end loop;
    wait;
end process;

stim_proc: process
begin
    rst <= '1'; 
    wait for 20 ns;
    rst <= '0'; 
    wait for 1 ms;
    sim_done <= true;
    wait;
end process;

end sim;