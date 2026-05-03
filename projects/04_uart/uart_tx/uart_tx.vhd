library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx is
    port(
        tx_start  : in std_logic := '0';
        tx_input  : in std_logic_vector (7 downto 0);
        clock     : in std_logic;
        tx_output : out std_logic := '1'
    );
end uart_tx;

architecture rtl of uart_tx is
    
    type all_states is (IDLE, START, DATA, STOP);

    signal curr_state  : all_states := IDLE;
    signal cycle_count : integer := 0;
    signal bits_moved  : integer := 0;

    constant baud_rate_cycles : integer := 5;
 
begin
    handle_state : process(clock, tx_start)
    begin
        if(rising_edge(clock)) then
            cycle_count <= cycle_count + 1;

            case curr_state is
                when IDLE =>
                    tx_output <= '1';
                when START =>
                    tx_output <= '0';
                    
                    if(cycle_count = baud_rate_cycles) then
                        curr_state <= DATA;
                        cycle_count <= 0;
                    end if;
                when STOP =>
                    tx_output <= '1';

                    if(cycle_count = baud_rate_cycles) then
                        curr_state <= IDLE;
                        cycle_count <= 0;
                    end if;
                when DATA =>
                    tx_output <= tx_input(bits_moved);

                    if(cycle_count = baud_rate_cycles) then
                        if(bits_moved = 7) then
                            curr_state <= STOP;
                        else
                            bits_moved <= bits_moved + 1;
                        end if;

                        cycle_count <= 0;
                    end if;
            end case;
        elsif((tx_start = '1') and (curr_state = IDLE)) then
            curr_state  <= START;
        end if;
    end process;        
end rtl;
