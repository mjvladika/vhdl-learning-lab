library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
    port(
        clock        : in std_logic;
        serial_in    : in std_logic;
        valid        : out std_logic;
        parallel_out : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of uart_rx is
    type all_states is (IDLE, START, DATA, STOP);

    signal curr_state    : all_states := IDLE;
    signal old_serial_in : std_logic := '1';
    signal clock_cycles  : integer := 0;
    signal bits_received : integer := 0;

    constant baud_rate_cycles : integer := 5;
begin
    process(clock)
    begin
        if(rising_edge(clock)) then 
            case curr_state is
                when IDLE =>
                    if(old_serial_in = '1' and serial_in = '0') then
                        curr_state <= START;
                        clock_cycles <= 0;
                    else
                        clock_cycles <= clock_cycles + 1;
                    end if;

                    old_serial_in <= serial_in;
                when START =>
                    if(clock_cycles = 7) then
                        curr_state <= DATA;
                        clock_cycles <= 0;
                    else
                        clock_cycles <= clock_cycles + 1;
                    end if;
                when DATA =>
                    if(clock_cycles = 15) then
                        if(bits_received = 8) then
                            curr_state <= STOP;
                        else
                            parallel_out(bits_received) <= serial_in;
                            bits_received <= bits_received + 1;
                        end if;

                        clock_cycles <= 0;
                    else
                        clock_cycles <= clock_cycles + 1;
                    end if;
                when STOP =>
                    -- validate packet has end bit of 1 
                    if(clock_cycles > 8 and clock_cycles < 24 and serial_in = '1') then
                        valid <= '1';
                        curr_state <= IDLE;
                        old_serial_in <= serial_in;
                    elsif(clock_cycles > 24) then
                        valid <= '0';
                        curr_state <= IDLE;
                        old_serial_in <= serial_in;
                    end if;

                    clock_cycles <= clock_cycles + 1;
                end case;
        end if;
    end process;
end architecture;