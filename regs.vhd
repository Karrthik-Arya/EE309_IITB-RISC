
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity registers is 
	port (reg_a1: in std_logic_vector(2 downto 0);
			reg_a2: in std_logic_vector(2 downto 0);
			reg_a3: in std_logic_vector(2 downto 0);
			t1: out std_logic_vector(15 downto 0);
			t2: out std_logic_vector(15 downto 0);
			t2_in: in std_logic_vector(15 downto 0);
			t3: in std_logic_vector(15 downto 0);
			shift7: in std_logic_vector(15 downto 0); 
			pc_in: in std_logic_vector(15 downto 0);
			pc_out: out std_logic_vector(15 downto 0);
			clk: in std_logic;
	);
	end entity;
	
architecture working of registers is 
type mem_array is array (0 to 7 ) of std_logic_vector (15 downto 0);
signal regs: mem_array :=(
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
   ); 
begin

regs_read: process(reg_a1, reg_a2)
begin 
	if (state = "000010") then
		t1 <= regs(to_integer(unsigned(reg_a1)));
		t2 <= regs(to_integer(unsigned(reg_a2)));
	end if;
 end process;
 
regs_write: process(clk)
begin
 if (falling_edge(clk)) then
	if (state = "000111") then
		regs(to_integer(unsigned(reg_a3)))<= t3;
	elsif (state="") then
		regs(to_integer(unsigned(reg_a3)))<= shift7;
	end if;
	end if;
end process;
end working;