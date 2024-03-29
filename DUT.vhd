library ieee;
use ieee.std_logic_1164.all;
entity DUT is
port ( input_vector : in std_logic_vector(0 downto 0);
			output_vector: out std_logic_vector(6 downto 0));
end entity;

architecture DutWrap of DUT is
	signal state: std_logic_vector(5 downto 0 ):="000001";
	signal next_state: std_logic_vector(5 downto 0 ):="000001";
	signal clk: std_logic;
	signal reset: std_logic;
	signal curr_ins, w_addr1, w_addr3,  w_t1_reg_forg, w_alu_pcout, w_dout, w_din_t1, w_din_t2, w_shift7_reg, w_t3_in, w_t1, w_t2, w_t2_in, w_pc_aluin,  w_pc_reg, w_pcout_reg, w_alu_t1, w_alu_t3, w_t1_alu, w_t2_alu, w_t2_1s, w_1s, w_se10, w_se7, w_ins_addr: std_logic_vector(15 downto 0);
	signal w1,w2,w3: std_logic_vector(2 downto 0);
	signal w4: std_logic_vector(8 downto 0);
	signal w5: std_logic_vector(5 downto 0);
	signal carry, zero: std_logic;
   component ins_decoder is
     port(next_state: out std_logic_vector(5 downto 0);
		  state: in std_logic_vector(5 downto 0);
		  op_code: in std_logic_vector(3 downto 0);
		  cz: in std_logic_vector(1 downto 0);
		  imm: in std_logic_vector(8 downto 0);
		  op_out: out std_logic_vector(3 downto 0);
		  carry: in std_logic;
		  zero: in std_logic;
		  test_out: out std_logic_vector(0 downto 0)
		  );
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
	port( t1_addr: in std_logic_vector(15 downto 0);
	t3_addr: in std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0);
	 data_t1: in std_logic_vector(15 downto 0);
	 data_t2: in std_logic_vector(15 downto 0);
	 data_2: out std_logic_vector(15 downto 0);
	 ir_data: out std_logic_vector(15 downto 0);
	 ins_addr: in std_logic_vector(15 downto 0);
	 clk : in std_logic
	 );
	end component;
	
	component registers is 
	port (reg_a1: in std_logic_vector(2 downto 0);
			reg_a2: in std_logic_vector(2 downto 0);
			reg_a3: in std_logic_vector(2 downto 0);
			t1: out std_logic_vector(15 downto 0);
			t1_in: in std_logic_vector(15 downto 0);
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
		alu_in: in std_logic_vector(15 downto 0);
		reg_out: out std_logic_vector(15 downto 0);
		mem_a: out std_logic_vector(15 downto 0)
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
	 carry_out: out std_logic;
	 zero_out: out std_logic;
	 pc_out: out std_logic_vector(15 downto 0)
	 );
	 end component;
begin
	output_vector(5 downto 0) <= state;
	output_vector(6) <= carry;
   stateTrans_instance: ins_decoder
			port map (
					next_state => next_state,
					state => state,
					op_code => curr_ins(15 downto 12),
 					cz => curr_ins(1 downto 0),
					imm => curr_ins(8 downto 0),
					carry=> carry,
					zero=> zero
 					);
					
	stateSet_instance: ins_setter
		port map (
			clock => input_vector(0),
			next_state => next_state,
			state => state,
			reset => reset
		);
		
		ir_instance: ir
			port map(
			clk => input_vector(0),
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
				clk => input_vector(0),
				t1_addr => w_addr1,
				t3_addr => w_addr3,
				data_t1 => w_din_t1,
				data_t2=> w_din_t2,
				data_2 => w_dout,
				ir_data => curr_ins,
				ins_addr => w_ins_addr
			);
			
			reg_instance: registers
				port map(
					reg_a1 => w1,
					reg_a2 => w2,
					reg_a3 => w3,
					state => state,
					clk => input_vector(0),
					pc_in => w_pc_reg,
					shift7 => w_shift7_reg,
					t3 => w_t3_in,
					t2_in => w_t2_in,
					t1 => w_t1,
					t2 => w_t2,
					pc_out => w_pcout_reg,
					t1_in => w_t1_reg_forg
				);
				
			t1_instance: temp_1
				port map (
					state => state,
					clk => input_vector(0),
					reg => w_t1,
					data_2 => w_dout,
					alu_in => w_alu_t1,
					alu => w_t1_alu,
					data_1 => w_din_t1,
					reg_out => w_t1_reg_forg,
					mem_a => w_addr1
				);
				
				
				t2_instance: temp_2
					port map (
						state => state,
						clk => input_vector(0),
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
						clk => input_vector(0),
						alu => w_alu_t3,
						reg => w_t3_in,
						data_1 => w_addr3
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
						carry_out=> carry,
						zero_out=> zero,
						t1_out => w_alu_t1
					);
					
				pc_instance: pc
					port map (
					state=> state,
					clk => input_vector(0),
					alu_c => w_alu_pcout,
					reg=> w_pcout_reg,
					reg_out => w_pc_reg,
					alu_a=> w_pc_aluin,
					data_1=> w_ins_addr
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

