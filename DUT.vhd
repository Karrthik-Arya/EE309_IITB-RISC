library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(3 downto 0);
       	output_vector: out std_logic_vector(0 downto 0));
end entity;

architecture DutWrap of DUT is
	signal state: std_logic_vector(5 downto 0 ):="000000";
	signal next_state: std_logic_vector(5 downto 0 ):="000000";
   component stateTrans is
     port(next_state: out std_logic_vector(5 downto 0);
		  state: in std_logic_vector(5 downto 0);
		  op_code: in std_logic_vector(4 downto 0);
		  cz: in std_logic_vector(1 downto 0););
   end component;
	
	component stateSet is 
		port(   reset,clock:in std_logic;
        next_state: in std_logic_vector(5 downto 0);
		  state: out std_logic_vector(5 downto 0);
		  );
	end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   stateTrans_instance: stateTrans
			port map (
					I => input_vector,
					O => output_vector(0));
					
	stateSet_instance: stateSet
		port_map (
		));

end DutWrap;

