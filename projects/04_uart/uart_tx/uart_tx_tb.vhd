library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx_tb is
end entity;

architecture sim of uart_tx_tb is
    
    component uart_tx
        port(
            tx_start  : in std_logic;
            tx_input  : in std_logic_vector;
            clock     : in std_logic;
            tx_output : out std_logic
        );
    end component;

    signal tx_start, tx_output, clock : std_logic;
    signal tx_input : std_logic_vector (7 downto 0);

begin

    uut : uart_tx port map(
        tx_start  => tx_start,
        tx_input  => tx_input,
        clock     => clock,
        tx_output => tx_output
    );

    clk_process : process
    begin
        clock <= '0'; 
        wait for 10 ns;
        clock <= '1'; 
        wait for 10 ns;
    end process;

    stim_proc: process
    begin
        tx_start <= '1'; 
        wait for 10 ns;
        tx_input <= "10101010";
        tx_start <= '0'; 

        wait for 2 us;

        assert false report "Simulation Finished" severity failure;
    end process;

end sim;