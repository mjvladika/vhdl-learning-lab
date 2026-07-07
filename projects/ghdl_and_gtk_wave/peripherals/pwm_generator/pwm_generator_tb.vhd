library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_generator_tb is
end entity;

architecture sim of pwm_generator_tb is
    component pwm_generator
        port(
            clock      : in std_logic;
            duty_cycle : in unsigned(3 downto 0);
            pwm_output : out std_logic
        );
    end component;

    signal clock      : std_logic;
    signal duty_cycle : unsigned(3 downto 0);
    signal pwm_output : std_logic;
begin
    uut : pwm_generator port map(
        clock      => clock,
        duty_cycle => duty_cycle,
        pwm_output => pwm_output
    );

    clk_process : process
    begin
        clock <= '0';
        wait for 5 ns;
        clock <= '1';
        wait for 5 ns;
    end process;

    stim_proc : process
    begin
        duty_cycle <= "0011";
        wait for 500 ns;
        duty_cycle <= "0111";
        wait for 500 ns;
        duty_cycle <= "1100";
        wait for 500 ns;

        assert false report "Simulation Finished" severity failure;
    end process;
end architecture;