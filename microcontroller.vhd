----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:22:49 11/21/2012 
-- Design Name: 
-- Module Name:    microcontroller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microcontroller is
    Port ( col : out  STD_LOGIC_VECTOR (3 downto 0);
           row : in  STD_LOGIC_VECTOR (2 downto 0);
			  data : out STD_LOGIC_VECTOR (3 downto 0);
			  nreset	:	in STD_lOGIC;
			  clk	: in STD_LOGIC;
			  keyP : out STD_LOGIC);
			  
end microcontroller;

architecture FSM of microcontroller is
	TYPE detector_state IS (col1set, col2set, col3set, col4set);
	signal state, next_state: detector_state;

begin
process (clk,nReset)
begin
if (nReset = '1') then
	state <= col1set;
elsif (clk'EVENT and clk='1') then
	state <= next_state;
end if;
end process;

process (state)
begin
	case state is
	
			when col1set =>
				col <= "1110"; --set column 1 to zero
				keyP <= '0';
						if row = "110" then --row 1 is low so button 1 is pressed
							data <= "0001"; -- value 1
							keyP <= '1'; -- button was pressed
						elsif row = "101" then --row 2 is low  so button 2 is pressed
							data <= "0010"; --value 2
							keyP <= '1'; -- button was pressed
						elsif row = "011" then  --row 3 is low so button 3 is pressed
							data <= "0011";
							keyP <= '1'; -- button was pressed
						--elsif row = "111" then
						--	next_state <= col2set;
						else
							data <= "0000";
							next_state <= col2set;
						end if;

			when col2set => --set column 2 to zero
				col <= "1101";
				keyP <= '0';
						if row = "110" then --row 1 is low so button 4 is pressed
							data <= "0100"; -- value 4
							keyP <= '1'; -- button was pressed
						elsif row = "101" then --row 2 is low  so button 5 is pressed
							data <= "0101"; --value 2
							keyP <= '1';
						elsif row = "011" then --row 3 is low so button 6 is pressed
							data <= "0110";
							keyP <= '1'; -- button was pressed
						--elsif row <= "111" then
							next_state <= col3set;
						else
							data <= "0000";
							next_state <= col3set;
					end if;
				
			when col3set => --set column 2 to zero
				col <= "1011";
				keyP <= '0';
						if row = "110" then --row 1 is low so button 7 is pressed
							data <= "0111"; -- value 7
							keyP <= '1'; -- button was pressed
						elsif row = "101" then --row 2 is low  so button 8 is pressed
							data <= "1000"; --value 2
							keyP <= '1';
						elsif row = "011" then --row 3 is low so button 9 is pressed
							data <= "1001";
							keyP <= '1'; -- button was pressed
					--	elsif row = "111" then
				--			next_state <= col4set;
						else
							data <= "0000";
							next_state <= col4set;
					end if;
					
			when col4set => --set column 4 to zero
				col <= "0111";
				keyP <= '0';
						if row = "110" then--row 1 is low so button * is pressed
							data <= "1010"; -- value 4
							keyP <= '1'; -- button was pressed
						elsif row = "101" then --row 2 is low  so button 0 is pressed
							keyP <= '1'; -- button was pressed
							data <= "0000"; --value 2
						elsif row = "011" then --row 3 is low so button # is pressed
							data <= "1011";
							keyP <= '1'; -- button was pressed
				--		elsif row="111" then
				--			next_state <= col1set;
					else
							data <= "0000";
							next_state <= col1set;
					end if;
				end case;
		
	case state is
		when col1set => 
			next_state <= col2set;
		when col2set =>
			next_state <= col3set;
		when col3set => 
			next_state <= col4set;
		when col4set =>
			next_state <= col1set;
		when others =>
			next_state <= col1set;
	end case;
		
	
	end process;
end FSM;

