library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fourbitmemory is
    Port ( clock : in  STD_LOGIC;
           tomemory : in  STD_LOGIC;
			  reset: in STD_LOGIC;
			  sel : in STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (3 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end fourbitmemory;

architecture Behavioral of fourbitmemory is
begin
	process (clock)
	begin
		if (clock = '1' and clock'EVENT) then
			if (tomemory = '1' and sel='0') then
				data_out(3 downto 0) <= data_in;
			elsif (tomemory = '1' and sel='1') then
				data_out(7 downto 4) <= data_in;
			else
			end if;
		end if;
		
	end process;
end Behavioral;

