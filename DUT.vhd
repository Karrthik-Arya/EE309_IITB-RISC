library ieee;
use ieee.std_logic_1164.all;
entity DUT is
end entity;

architecture DutWrap of DUT is
	signal state: std_logic_vector(5 downto 0 ):="000000";
	signal next_state: std_logic_vector(5 downto 0 ):="000000";
	signal clk: std_logic;
	signal reset: std_logic;
	signal curr_ins, pc_adr: std_logic_vector(15 downto 0);
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
	
	component ir is 
		port (
		reg_1: out std_logic_vector(2 downto 0);
		reg_2: out std_logic_vector(2 downto 0);
		reg_3: out std_logic_vector(2 downto 0);
		shift7: out std_logic_vector(8 downto 0);
		sign_ex: out std_logic_vector(5 downto 0);
		mem: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		state: in std_logic_vector(5 downto 0)
	) ;
	end component;
	
	component mem is 
	port( addr: in std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0);
	 data_1: in std_logic_vector(15 downto 0);
	 data_2: out std_logic_vector(15 downto 0);
	 ir_adr: in std_logic_vector(15 downto 0);
	 ir_data: out std_logic_vector(15 downto 0);
	 clk : in std_logic
	 );
	end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   stateTrans_instance: ins_decoder
			port map (
					next_state => next_state,
					state => state,
					op_code => curr_ins(15 downto 11),
 					cz => curr_ins(1 downto 0)
 					);
					
	stateSet_instance: ins_setter
		port map (
			clock => clk,
			next_state => next_state,
			state => state,
			reset => reset
		);
		
		ir_instance: ir
			port map(
			clk => clk,
			state => state,
			mem => curr_ins
			);
			
		mem_instance: mem
			port map(
				state => state,
				ir_adr => 
			);
		

end DutWrap;

