library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem(
	port( addr: in std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0);
	 data_1: in std_logic_vector(15 downto 0);
	 data_2: out std_logic_vector(15 downto 0);
	 clk : in std_logic;
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
	
	mem_action: process(clk)
	begin
	if (rising_edge(clk)) then
	 if (state="001101" or state="011001") then
	 ram_data(to_integer(unsigned(addr)) <= data_1;
	 end if;
	end if;
	end process;
	data_2 <= ram_data(to_integer(unsigned(addr));
end working;
	
	
	
	