library ieee;
use ieee.std_logic_1164.all;

entity two_one_mux is
	port(
		a : in std_logic;
		b : in std_logic;
		c : in std_logic;
		y : out std_logic
	);
end two_one_mux;

architecture rtl of two_one_mux is
begin
	y <= a when c = '0' else b;
end rtl;
