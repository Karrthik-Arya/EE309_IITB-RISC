library ieee;
use ieee.std_logic_1164.all;
library work;
use ieee.numeric_std.all;
use work.Adder_4Bit.all;
use work.Gates.all;

entity sign_extender_7_component(
	port(ir_8_0: in std_logic_vector(8 downto 0);
	 alu: out std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0);
	 );
end entity;
	 
architecture working of sign_extender_7_component is
begin
	process(ir_8_0)
	variable temp: integer;
	begin
	 if (add states) then
		 temp := to_integer(unsigned(ir_8_0));
		 alu <= std_logic_vector(to_unsigned(temp, 16));
		end if;
	end process;
end working;