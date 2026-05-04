library ieee;
use ieee.std_logic_1164.all;

entity button_lock_sequence_tb is
end entity;

architecture sim of button_lock_sequence_tb is
    component button_lock_sequence
        port(
            clock    : in std_logic;
            btn_a    : in std_logic;
            btn_b    : in std_logic;
            btn_c    : in std_logic;
            unlocked : out std_logic
        );
    end component;

    signal clock    : std_logic;
    signal btn_a    : std_logic := '0';
    signal btn_b    : std_logic := '0';
    signal btn_c    : std_logic := '0';
    signal unlocked : std_logic := '0';
begin
    uut : button_lock_sequence port map(
        clock    => clock,
        btn_a    => btn_a,
        btn_b    => btn_b,
        btn_c    => btn_c,
        unlocked => unlocked
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
        btn_b <= '1'; wait for 20 ns; btn_b <= '0'; wait for 20 ns;
        btn_c <= '1'; wait for 20 ns; btn_c <= '0'; wait for 20 ns;
        btn_a <= '1'; wait for 20 ns; btn_a <= '0'; wait for 100 ns;

        assert false report "Simulation Finished" severity failure;
    end process;
end architecture;