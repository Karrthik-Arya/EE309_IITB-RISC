library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
	port( addr: in std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0);
	 t1: in std_logic_vector(15 downto 0);
	 t2: in std_logic_vector(15 downto 0);
	 t3: in std_logic_vector(15 downto 0);
	 data_2: out std_logic_vector(15 downto 0);
	 ir_data: out std_logic_vector(15 downto 0);
	 clk : in std_logic
	 );
	 end entity;
	 
architecture working of mem is
	type mem_array is array (0 to 31 ) of std_logic_vector (15 downto 0);
	signal mem_data: mem_array :=(
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000"
   ); 
	
	signal mem_ins: mem_array := (
	 b"0011000000000001",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000"
	);
	begin
	mem_action: process(clk)
	begin
	if (falling_edge(clk) and (state="001101" or state="011001")) then
	 mem_data(to_integer(unsigned(addr))) <= t1;
	end if;
	end process;
	data_2 <= mem_data(to_integer(unsigned(addr)));
	ir_data <= mem_ins(to_integer(unsigned(addr)));
end working;
	
	
	
	