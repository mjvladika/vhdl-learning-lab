library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	port(
		rst, clk : in std_logic;
		output : out std_logic_vector(0 to 3)
	);
end counter;

architecture rtl of counter is
signal count : unsigned(0 to 3) := "0000";
begin
	process(rst, clk)
	begin
		if(rst = '1') then count <= "0000";
		elsif(rising_edge(clk)) then count <= count + 1;
		end if;
	end process;
	output <= std_logic_vector(count);
end rtl;
