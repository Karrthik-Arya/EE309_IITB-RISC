
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
	when "000001"=>--s1
	
		if (op_code="0001" or op_code="0000" or op_code="0010" or op_code="1000" or op_code="1100" or op_code="1101") then
		next_state <= "000010";
				
		elsif (op_code="0011") then
		next_state <= "000111";
				 
		 elsif (op_code="0111" or op_code="0101") then
		next_state <= "001000";
		
		
		
			elsif (op_code="1001") then
		next_state <= "100010";
		
		
			elsif (op_code="1010") then
		next_state <= "100011";
		
		
			elsif (op_code="1011") then
		next_state <= "100100";
		end if;
		
		
	when "000010"=>--s2
	
		if (op_code="0001") then
			if(cz="11") then
				next_state <= "000101";
			else 
			
			next_state <="000011";
			end if;
		
		
		elsif (op_code="0000") then
		next_state <= "000110";
		
		
		elsif(op_code="0010") then
		next_state <="101000";

		
		elsif(op_code="1000") then
		next_state <="101001";
		
		
		elsif(op_code="1100") then
		next_state <="001110";
		
		
		elsif(op_code="1101") then
		next_state <="011000";
		
		end if;
	
		
			
		
		
		
		
		
		
	when "000011"=> --s3
	
		if (op_code="0001") then
			next_state <= "000100";
		end if;
		
		
	
	when "000100"=> --s4
	
		if (op_code="0001" or op_code="0010") then
			next_state <= "000001";
		
		end if;
		
		
	when "000101"=>--s5
	
		if (op_code="0001") then
			next_state <= "000100";
		end if;
		
		
		
	when "000110"=>--s6
	
		if (op_code="0000") then
			next_state <= "100111";
			
		elsif(op_code="0111") then
			next_state <="001010";	
		
		end if;
		
		
	
		when "000111"=> --s7
		
		if(op_code="0011") then
			next_state <="000001";
			
			end if;
			
		when "001000"=> --s8
		 
		 if(op_code="0111") then
			next_state <="000110";
			
			elsif(op_code="0101") then
			next_state <="001100";
		end if;
		
		when "001010"<= --s10
		
		if(op_code="0111") then
			next_state <="001011";
			
			end if;
			
			
		when "001011"<= --s11
		
		if(op_code="0111") then
			next_state <="000001";
			
			end if;
			
			
		when "001100"<= --s12
		
		if(op_code="0101") then
			next_state <="001101";
			
			end if;
			
		when "001101"<= --s13
		
		if(op_code="0101") then
			next_state <="000001";
			
			end if;
			
		when "001110" <= --s14
		 
		
		if(op_code="1100") then
			if (imm(0)="1") then
			
			next_state <="001111";
			end if;
			
			if(imm(1)="1") then
			
				next_state <="010001";
			end if;
			
			if(imm(2)="1") then
			
				next_state <="010010";
			end if;
			
			if(imm(3)="1") then
			
				next_state <="010011";
			end if;
			
			if(imm(4)="1") then
			
				next_state <="010100";
			end if;
			
			if(imm(5)="1") then
			
				next_state <="010101";
			end if;
			
			if(imm(6)="1") then
			
				next_state <="010110";
			end if;
			if(imm(7)="1") then
			
				next_state <="010111";
			end if;
			
			
		end if;
		
			
		when "001111" or "010001" or "010010" or "010011" or "010100" or "010101" or "010110" <= --s15,s17,s18,s19,s20,s21,s22
		
		if(op_code="1100") then
			next_state <="010000";
			
			end if;	
		
		when "010000" => --S16
		 if(op_code="1100") then
			next_state <="001110";
			elsif( op_code="1101") then
			next_state <="
			end if;
			
			
		when "011000"=> --s24
		
		 if(op_code="1101") then
			next_state <="011001";
			
			end if;
			
		when "011001"=> --s25
		
		 if(op_code="1101" and imm(1)="1") then
			next_state <="010000";
			
			end if;
			
		when "011010"=> --s26
		
		 if(op_code="1101" and imm(1)="1") then
			next_state <="010000";
			
			end if;
		 
			
			
	when others =>
		next_state<="000000";
	end case;
end process;


end working;





