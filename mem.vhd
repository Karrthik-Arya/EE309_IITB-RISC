library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
	port( addr: in std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0);
	 data_1: in std_logic_vector(15 downto 0);
	 data_2: out std_logic_vector(15 downto 0);
	 ir_data: out std_logic_vector(15 downto 0);
	 ins_addr: in std_logic_vector(15 downto 0);
	 clk : in std_logic
	 );
	 end entity;
	 
architecture working of mem is
	type mem_array is array (0 to 31 ) of std_logic_vector (15 downto 0);
	signal mem_data: mem_array :=(
   x"0000",x"0000", x"0001", x"0002",
	x"0003",x"0004", x"0005", x"0006",
	x"0007",x"0008", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000"
   ); 
	
	--b"0001000001010000",
	signal mem_ins: mem_array := (
	b"1100000001111110", x"FFFF", x"0000", x"0000",
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
	if (falling_edge(clk) and (state="001101")) then
	 mem_data(to_integer(unsigned(addr))) <= data_1;
	end if;
	end process;
	data_2 <= mem_data(to_integer(unsigned(addr)));
	ir_data <= mem_ins(to_integer(unsigned(ins_addr)));
end working;
	
	
	
	