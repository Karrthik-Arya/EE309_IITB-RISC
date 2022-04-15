library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(15 downto 0);
       	output_vector: out std_logic_vector(5 downto 0));
end entity;

architecture DutWrap of DUT is
	signal state: std_logic_vector(5 downto 0 ):="000000";
	signal next_state: std_logic_vector(5 downto 0 ):="000000";
	signal clk: std_logic;
	signal reset: std_logic;
   component ins_decoder is
     port(next_state: out std_logic_vector(5 downto 0);
		  state: in std_logic_vector(5 downto 0);
		  op_code: in std_logic_vector(4 downto 0);
		  cz: in std_logic_vector(1 downto 0));
   end component;
	
	component ins_setter is 
		port(   reset,clock:in std_logic;
        next_state: in std_logic_vector(5 downto 0);
		  state: out std_logic_vector(5 downto 0)
		  );
	end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   stateTrans_instance: ins_decoder
			port map (
					next_state => next_state,
					state => state,
					op_code => input_vector(15 downto 11),
 					cz => input_vector(1 downto 0)
 					);
					
	stateSet_instance: ins_setter
		port map (
			clock => clk,
			next_state => next_state,
			state => state,
			reset => reset
		);

end DutWrap;

