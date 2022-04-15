library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity temp_1 is 
	port(
		alu: out std_logic_vector(15 downto 0);
		reg: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		data_1: out std_logic_vector(15 downto 0);
		data_2: in std_logic_vector(15 downto 0);
		state: in std_logic_vector(5 downto 0);
		t1: in std_logic_vector(15 downto 0);
	);
end temp_1;

architecture working of temp_1 is
signal t1: std_logic_vector(15 downto 0);
begin
	read_proc: process(t1)
	begin
		if (state="000000") then
		alu <= t1;

		elsif (state="001101" or state="011001") then
		data_1 <= t1;
		end if;
	end process;

	write_proc: process(clk)
	begin 
		if(falling_edge(clk)) then
			if (state="000000") then
				t1 <= reg;
			elsif (state="001101" or state="011001") then
				t1 <= data_2;
			end if;
		end if;
	end process;
end working;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity temp_2 is 
	port(
		alu: out std_logic_vector(15 downto 0);
		reg_in: in std_logic_vector(15 downto 0);
		reg_out: out std_logic_vector(15 downto 0);
		clk: in std_logic;
		data_1: out std_logic_vector(15 downto 0);
		data_2: in std_logic_vector(15 downto 0);
		state: in std_logic_vector(5 downto 0)
	);
end temp_2;

architecture working2 of temp_2 is
signal t2: std_logic_vector(15 downto 0);
begin
	read_proc: process(t2)
	begin
		if (state="000000") then
		alu <= t2;

		elsif (state="001101" or state="011001") then
		data_1 <= t2;

		elsif (state="000000") then
		reg_out <= t2;
		end if;
	end process;

	write_proc: process(clk)
	begin 
		if(falling_edge(clk)) then
		if (state="000000") then
		t2 <= reg_in;

		elsif (state="001101" or state="011001") then
		t2 <= data_2;
			
		end if;
		end if;
	end process;
end working2;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity temp_3 is 
	port(
		alu: in std_logic_vector(15 downto 0);
		reg: out std_logic_vector(15 downto 0);
		clk: in std_logic;
		data_1: out std_logic_vector(15 downto 0);
		state: in std_logic_vector(5 downto 0)
	);
end temp_3;

architecture working3 of temp_3 is
signal t3: std_logic_vector(15 downto 0);
begin
	read_proc: process(t3)
	begin
		if (state="000000") then
			reg <= t3;

		elsif (state="001101" or state="011001") then
			data_1 <= t3;
			end if;
	end process;

	write_proc: process(clk)
	begin 
		if(falling_edge(clk)) then
		if (state="000000") then
			t3 <= alu;	
		end if;
		end if;
	end process;
end working3;