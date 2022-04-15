
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pc is 
	port (alu_c: in std_logic_vector(15 downto 0);
			alu_a: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(5 downto 0);
			clk: in std_logic;
	);
	end entity;
	
architecture working of pc is 
signal regs: std_logic_vector; 
begin

pc_read: process(alu_c)
begin 
	if (state = "000010") then
		alu_a <= regs;
	end if;
 end process;
 
regs_write: process(clk)
begin
 if (falling_edge(clk)) then
	if (state = "000111") then
		regs <= alu_c;
	end if;
end if;	
end process;
end working;