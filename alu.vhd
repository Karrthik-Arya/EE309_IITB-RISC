library ieee;
use ieee.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity alu is
	port(state: in std_logic_vector(5 downto 0);
	 t1: in std_logic_vector(15 downto 0);
	 t1_out: out std_logic_vector(15 downto 0);
	 t2: in std_logic_vector(15 downto 0);
	 pc_in: in std_logic_vector(15 downto 0);
	 one_bit_shifter: in std_logic_vector(15 downto 0);
	 sign_extender_10: in std_logic_vector(15 downto 0);
	 sign_extender_7: in std_logic_vector(15 downto 0);
	 t3: out std_logic_vector(15 downto 0);
	 pc_out: out std_logic_vector(15 downto 0)
	 );
	 end entity;
	 
architecture working of alu is
signal carry: std_logic;
signal zero: std_logic;
begin
	compute : process(t1,t2, pc_in, one_bit_shifter, sign_extender_10, sign_extender_7)
	variable temp: integer;
	begin
	 if (state="001101" or state="011001") then
		 --add
		 temp := to_integer(unsigned(t1)) + to_integer(unsigned(t2));
		 if (temp>65535) then
			carry <= '1';
			t3 <= std_logic_vector(to_unsigned(temp-65535,16));
		else
			carry <= '0';
			t3 <= std_logic_vector(to_unsigned(temp,16));
		end if;
	elsif (state="001101") then
		 --adi
		 temp := to_integer(unsigned(t1)) + to_integer(unsigned(sign_extender_10));
		 if (temp>65535) then
			carry <= '1';
			t3 <= std_logic_vector(to_unsigned(temp-65535,16));
		else
			carry <= '0';
			t3 <= std_logic_vector(to_unsigned(temp,16));
		end if;
	elsif (state="001101") then
		 --adl
		 temp := to_integer(unsigned(t1)) + to_integer(unsigned(one_bit_shifter));
		 if (temp>65535) then
			carry <= '1';
			t3 <= std_logic_vector(to_unsigned(temp-65535,16));
		else
			carry <= '0';
			t3 <= std_logic_vector(to_unsigned(temp,16));
		end if;
	elsif(state="001101") then
		--adc
		if (carry='1') then
			temp := to_integer(unsigned(t1)) + to_integer(unsigned(t2));
			 if (temp>65535) then
				carry <= '1';
				t3 <= std_logic_vector(to_unsigned(temp-65535,16));
			else
				carry <= '0';
				t3 <= std_logic_vector(to_unsigned(temp,16));
			end if;
		end if;
	elsif(state="001101") then
		--adz
		if (zero='1') then
			temp := to_integer(unsigned(t1)) + to_integer(unsigned(t2));
			 if (temp>65535) then
				carry <= '1';
				t3 <= std_logic_vector(to_unsigned(temp-65535,16));
			else
				carry <= '0';
				t3 <= std_logic_vector(to_unsigned(temp,16));
			end if;
		end if;
	elsif(state="000001") then
	--pc
		temp := to_integer(unsigned(pc_in)) + 1;
		pc_out <= std_logic_vector(to_unsigned(temp,16));
	elsif(state="001101") then
		--ndc
		if(carry='1') then
			t3 <= t1 nand t2;
			if ((t1 nand t2)= x"0000") then
			zero <= '0';
			end if;
		end if;
	elsif(state="000101" and zero='1') then
		--ndu
			t3 <= t1 nand t2;
			if ((t1 nand t2)= x"0000") then
			zero <= '0';
			end if;
	elsif(state="000101") then
		--nand
		t3 <= t1 nand t2;
		if ((t1 nand t2)= x"0000") then
			zero <= '0';
		end if;
	elsif(state="001101") then
		--cmp
		if (t1 = t2) then
			zero <= '1';
		else
			zero<= '0';
	end if; 
	elsif(state="001101") then
	--pc-1
		temp := to_integer(unsigned(pc_in)) -1;
		t3 <= std_logic_vector(to_unsigned(temp,16));
	end if;
	end process;
end working;