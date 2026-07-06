library ieee;
use ieee.std_logic_1164.all;

entity adder_pipeline_tb is
end entity;

architecture sim of adder_pipeline_tb is
    component adder_pipeline
        port(
            clock      : in std_logic;
            first_num  : in std_logic_vector(7 downto 0);
            second_num : in std_logic_vector(7 downto 0);
            sum        : out std_logic_vector(8 downto 0) := "000000000"
        );
    end component;

    signal clock      : std_logic := '0';
    signal first_num  : std_logic_vector(7 downto 0);
    signal second_num : std_logic_vector(7 downto 0);
    signal sum        : std_logic_vector(8 downto 0) := "000000000";
    
begin
    uut : adder_pipeline port map(
        clock       => clock,
        first_num   => first_num,
        second_num  => second_num,
        sum         => sum
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
        first_num  <= "00001111";
        second_num <= "00000001";
        wait for 200 ns;

        first_num  <= "11001010";
        second_num <= "00110011";
        wait for 200 ns;

        assert false report "Simulation Finished" severity failure;
    end process;
end architecture sim;