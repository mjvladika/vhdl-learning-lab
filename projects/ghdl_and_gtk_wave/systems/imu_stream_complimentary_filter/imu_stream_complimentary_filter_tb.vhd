library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imu_stream_complimentary_filter_tb is
end entity;

architecture sim of imu_stream_complimentary_filter_tb is
    component imu_stream_complimentary_filter
        port(
            clock          : in std_logic;
            raw_gyro       : in signed(15 downto 0);
            raw_acc        : in signed(15 downto 0);
            filtered_angle : out signed(15 downto 0)
        );
    end component;

    signal clock          : std_logic := '0';
    signal raw_gyro       : signed(15 downto 0) := (others => '0');
    signal raw_acc        : signed(15 downto 0) := (others => '0');
    signal filtered_angle : signed(15 downto 0);
begin
    uut : imu_stream_complimentary_filter port map (
        clock          => clock,
        raw_gyro       => raw_gyro,
        raw_acc        => raw_acc,
        filtered_angle => filtered_angle
    );

    clock_process : process
    begin
        clock <= '0';
        wait for 5 ns;
        clock <= '1';
        wait for 5 ns;
    end process;

    stimulus_process : process
    begin
        wait for 10 ns;
        raw_gyro <= to_signed(100, 16);
        raw_acc <= to_signed(50, 16);
        wait for 10 ns;
        raw_gyro <= to_signed(200, 16);
        raw_acc <= to_signed(100, 16);
        wait for 10 ns;
        raw_gyro <= to_signed(-100, 16);
        raw_acc <= to_signed(-50, 16);
        wait for 10 ns;
        raw_gyro <= to_signed(-200, 16);
        raw_acc <= to_signed(-100, 16);
        wait for 10 ns;

        assert false report "Simulation Finished" severity failure;
    end process;
end architecture;