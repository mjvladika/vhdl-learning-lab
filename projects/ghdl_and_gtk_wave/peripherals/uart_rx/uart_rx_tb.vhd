library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx_tb is
end entity;

architecture sim of uart_rx_tb is
    component uart_rx
        port(
            clock        : in std_logic;
            serial_in    : in std_logic;
            valid        : out std_logic;
            parallel_out : out std_logic_vector(7 downto 0)
        );
    end component;

    signal clock        : std_logic;
    signal serial_in    : std_logic;
    signal valid        : std_logic;
    signal parallel_out : std_logic_vector(7 downto 0);
begin
    uut : uart_rx port map(
        clock        => clock,
        serial_in    => serial_in,
        valid        => valid,
        parallel_out => parallel_out
    );

    clk_process : process
    begin
        clock <= '0'; 
        wait for 5 ns;
        clock <= '1'; 
        wait for 5 ns;
    end process;

    stim_proc: process
    begin
        -- idle
        serial_in <= '1'; wait for 160 ns;
        -- start
        serial_in <= '0'; wait for 160 ns;
        -- data
        serial_in <= '1'; wait for 160 ns;
        serial_in <= '0'; wait for 160 ns;
        serial_in <= '1'; wait for 160 ns;
        serial_in <= '0'; wait for 160 ns;
        serial_in <= '1'; wait for 160 ns;
        serial_in <= '0'; wait for 160 ns;
        serial_in <= '1'; wait for 160 ns;
        serial_in <= '0'; wait for 160 ns;
        -- stop
        serial_in <= '1'; wait for 320 ns;


        assert false report "Simulation Finished" severity failure;
    end process;
    
end sim;