library ieee;
use ieee.std_logic_1164.all;
entity DUT is
port ( input_vector : in std_logic_vector(0 downto 0);
			output_vector: out std_logic_vector(0 downto 0));
end entity;

architecture DutWrap of DUT is
	signal state: std_logic_vector(5 downto 0 ):="000000";
	signal next_state: std_logic_vector(5 downto 0 ):="000000";
	signal clk: std_logic;
	signal reset: std_logic;
	signal curr_ins, w_alu_pcout, w_dout, w_addr, w_din_t1, w_din_t2, w_din_t3, w_shift7_reg, w_t3_in, w_t1, w_t2, w_t2_in, w_pc_aluin,  w_pc_reg, w_pcout_reg, w_alu_t1, w_alu_t3, w_t1_alu, w_t2_alu, w_t2_1s, w_1s, w_se10, w_se7: std_logic_vector(15 downto 0);
	signal w1,w2,w3: std_logic_vector(2 downto 0);
	signal w4: std_logic_vector(8 downto 0);
	signal w5: std_logic_vector(5 downto 0);
   component ins_decoder is
     port(next_state: out std_logic_vector(5 downto 0);
		  state: in std_logic_vector(5 downto 0);
		  op_code: in std_logic_vector(3 downto 0);
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
	 t1: in std_logic_vector(15 downto 0);
	 t2: in std_logic_vector(15 downto 0);
	 t3: in std_logic_vector(15 downto 0);
	 data_2: out std_logic_vector(15 downto 0);
	 ir_data: out std_logic_vector(15 downto 0);
	 clk : in std_logic
	 );
	end component;
	
	component registers is 
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
			state: in std_logic_vector(5 downto 0)
	);
	end component;
	
	component temp_1 is
		port(
		alu: out std_logic_vector(15 downto 0);
		reg: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		data_1: out std_logic_vector(15 downto 0);
		data_2: in std_logic_vector(15 downto 0);
		state: in std_logic_vector(5 downto 0);
		alu_in: in std_logic_vector(15 downto 0)
	);
	end component;
	
	
	component sign_extender_7_component is
	port(ir_8_0: in std_logic_vector(8 downto 0);
	 alu: out std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0)
	 
	 );
	end component;
	
	
	component sign_extender_10_component is
	port(ir_5_0: in std_logic_vector(5 downto 0);
	 alu: out std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0)
	 );
	end component;
	
	component shifter_7 is 
	port (ir_8_0: in std_logic_vector(8 downto 0);
			rf_d3: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(5 downto 0)
	);
	end component;
	
	
	component shifter_1 is 
	port (t2: in std_logic_vector(15 downto 0);
			alu_a: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(5 downto 0)
	);
	end component;
	
	component pc is 
	port (alu_c: in std_logic_vector(15 downto 0);
			reg: in std_logic_vector(15 downto 0);
			alu_a: out std_logic_vector(15 downto 0);
			data_1: out std_logic_vector(15 downto 0);
			reg_out: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(5 downto 0);
			clk: in std_logic
	);
	end component;
	

component temp_2 is 
	port(
		alu: out std_logic_vector(15 downto 0);
		reg_in: in std_logic_vector(15 downto 0);
		reg_out: out std_logic_vector(15 downto 0);
		clk: in std_logic;
		data_1: out std_logic_vector(15 downto 0);
		data_2: in std_logic_vector(15 downto 0);
		state: in std_logic_vector(5 downto 0);
		shift1: out std_logic_vector(15 downto 0)
	);
end component;


component temp_3 is 
	port(
		alu: in std_logic_vector(15 downto 0);
		reg: out std_logic_vector(15 downto 0);
		clk: in std_logic;
		data_1: out std_logic_vector(15 downto 0);
		state: in std_logic_vector(5 downto 0)
	);
end component;

component alu is
	port(state: in std_logic_vector(5 downto 0);
	 t1: in std_logic_vector(15 downto 0);
	 t2: in std_logic_vector(15 downto 0);
	 pc_in: in std_logic_vector(15 downto 0);
	 one_bit_shifter: in std_logic_vector(15 downto 0);
	 sign_extender_10: in std_logic_vector(15 downto 0);
	 sign_extender_7: in std_logic_vector(15 downto 0);
	 t3: out std_logic_vector(15 downto 0);
	 t1_out: out std_logic_vector(15 downto 0);
	 pc_out: out std_logic_vector(15 downto 0)
	 );
	 end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file
	clk<= input_vector(0);
	output_vector<="0";
   stateTrans_instance: ins_decoder
			port map (
					next_state => next_state,
					state => state,
					op_code => curr_ins(15 downto 12),
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
			mem => curr_ins,
			shift7 => w4,
			reg_1=> w1,
			reg_2 => w2,
			reg_3 => w3,
			sign_ex => w5
			);
			
		mem_instance: mem
			port map(
				state => state,
				clk => clk,
				t1 => w_din_t1,
				t2 => w_din_t2,
				t3 => w_din_t3,
				addr => w_addr,
				data_2 => w_dout,
				ir_data => curr_ins
			);
			
			reg_instance: registers
				port map(
					reg_a1 => w1,
					reg_a2 => w2,
					reg_a3 => w3,
					state => state,
					clk => clk,
					pc_in => w_pc_reg,
					shift7 => w_shift7_reg,
					t3 => w_t3_in,
					t2_in => w_t2_in,
					t1 => w_t1,
					t2 => w_t2,
					pc_out => w_pcout_reg
				);
				
			t1_instance: temp_1
				port map (
					state => state,
					clk => clk,
					reg => w_t1,
					data_2 => w_dout,
					alu_in => w_alu_t1,
					alu => w_t1_alu,
					data_1 => w_din_t1
				);
				
				
				t2_instance: temp_2
					port map (
						state => state,
						clk => clk,
						data_2 => w_dout,
						reg_in => w_t2,
						reg_out => w_t2_in,
						data_1 => w_din_t2,
						alu => w_t2_alu,
						shift1 => w_t2_1s
					);
				
				t3_instance: temp_3
					port map(
						state=> state,
						clk => clk,
						alu => w_alu_t3,
						reg => w_t3_in,
						data_1 => w_din_t3
					);
					
				alu_instance: alu
					port map(
						state => state,
						t1 => w_t1_alu,
						t2 => w_t2_alu,
						pc_in => w_pc_aluin,
						one_bit_shifter=> w_1s,
						sign_extender_10=> w_se10,
						sign_extender_7 => w_se7,
						t3 => w_alu_t3,
						pc_out => w_alu_pcout,
						t1_out => w_alu_t1
					);
					
				pc_instance: pc
					port map (
					state=> state,
					clk => clk,
					alu_c => w_alu_pcout,
					reg=> w_pcout_reg,
					reg_out => w_pc_reg,
					alu_a=> w_pc_aluin,
					data_1=> w_addr
					);
					
				shift1_instance: shifter_1
					port map (
						state=> state,
						t2=> w_t2_1s,
						alu_a=>w_1s
					);
					
				shift7_instance: shifter_7
					port map (
					 state=> state,
					 ir_8_0=> w4,
					 rf_d3=>w_shift7_reg
					);
					
				sign_ex10_instance: sign_extender_10_component
					port map (
						state=> state,
						ir_5_0=> w5,
						alu=> w_se10
					);
					
				sign_ex7_instance: sign_extender_7_component
					port map (
						state=> state,
						ir_8_0=> w4,
						alu=> w_se7
					);
				
					
end DutWrap;

