library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_divider is
	port(
		rst, clk : in std_logic;
		clk_out : out std_logic
	);
end clock_divider;

architecture rtl of clock_divider is

signal count : integer := 1;
signal clk_out_tick : std_logic := '0';

begin
	process(rst, clk)
	begin
		if(rst = '1') then 
		    count <= 1;
		    clk_out_tick <= '0';
		elsif(rising_edge(clk)) then 
		    count <= count + 1;

		    if(count = 5) then
		        clk_out_tick <= not clk_out_tick;
                count <= 0;
		    end if;
		end if;
	end process;

    clk_out <= clk_out_tick;
end rtl;
