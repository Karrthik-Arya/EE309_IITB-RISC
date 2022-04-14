library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ir is
	port (
		reg_1: out std_logic_vector(2 downto 0);
		reg_2: out std_logic_vector(2 downto 0);
		reg_3: out std_logic_vector(2 downto 0);
		shift7: out std_logic_vector(8 downto 0);
		sign_ex: out std_logic_vector(5 downto 0);
		mem: in std_logic_vector(15 downto 0);
		clk: in std_logic;
	) 
end ir;

architecture working of ir is
signal ir_store: std_logic_vector(15 downto 0);
begin
	write_proc: process(clk)
	begin
	if(falling_edge(clk)) then
		if() then
			ir_store <= mem;
	end if;
	end if;
	end process;
	
	read_proc: process(ir_store)
	begin
	if() then
		reg_1<= ir(11 downto 9);
		reg_2<= ir(8 downto 6);
	elsif() then
		reg_3 <= ir(8 downto 6);
	elsif() then	
		reg_3 <= ir(5 downto 3);
	elsif() then
		shift7 <= ir(8 downto 0);
	elsif() then
		sign_ex <= ir(5 downto 0);
	elsif() then
		reg_3 <= ir(11 downto 9);
	elsif() then
		reg_1 <= ir(8 downto 6);
	end if;
	end process;

