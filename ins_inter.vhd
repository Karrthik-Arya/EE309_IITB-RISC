
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ins_setter is
port(   reset,clock:in std_logic;
        next_state: in std_logic_vector(5 downto 0);
		  state: out std_logic_vector(5 downto 0)
		  );
end ins_setter;

architecture working of ins_setter is
begin

clock_proc:process(clock,reset)
begin
    if(clock='1' and clock' event) then
        if(reset='1') then
            state<="000000";
        else
            state<=next_state;
        end if;
    end if;
    
end process;

end working;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ins_decoder is
port(
        next_state: out std_logic_vector(5 downto 0);
		  state: in std_logic_vector(5 downto 0);
		  op_code: in std_logic_vector(3 downto 0);
		  cz: in std_logic_vector(1 downto 0)
		  );
end ins_decoder;

architecture working of ins_decoder is
begin
next_state_process: process(state)
begin
	case state is
	when "000000"=>
		if (op_code="0011") then
			next_state <= "000001";
		end if;
	when "000001"=>
		if (op_code="0011") then
			next_state <= "000111";
		end if;
	when "000111"=>
		if (op_code="0011") then
			next_state <= "000001";
		end if;
	when others =>
		next_state<="000000";
	end case;
end process;


end working;





