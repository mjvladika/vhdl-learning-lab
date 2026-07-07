library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	port(
		rst, clk : in std_logic;
		output : out std_logic_vector(3 downto 0)
	);
end counter;

architecture rtl of counter is

signal count : unsigned(3 downto 0) := "0000";
signal counter : unsigned(25 downto 0) := "00000000000000000000000000";

begin
	process(rst, clk)
	begin
		if(rst = '1') then 
		  count <= "0000";
		  counter <= "00000000000000000000000000";
		elsif(rising_edge(clk)) then 
		  counter <= counter + 1;
		  
		  if(counter = 50000000) then
		      count <= count + 1;
		      counter <= "00000000000000000000000000";
		  end if;
		end if;
	end process;
	
	output <= std_logic_vector(count);
end rtl;
