library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity x7segbc is
    Port ( x : in  STD_LOGIC_VECTOR (15 downto 0);
           cclk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           a_to_g : out  STD_LOGIC_VECTOR (6 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           dp : out  STD_LOGIC);
end x7segbc;

architecture x7segbc of x7segbc is

signal s: std_logic_vector(1 downto 0);
signal digit: std_logic_vector(3 downto 0);
signal aen: std_logic_vector(3 downto 0);

begin
	dp <= '1';
	aen(3) <= '1'; --x(15) or x(14) or x(13) or x(12) or '1';
	aen(2) <= '1'; --x(15) or x(14) or x(13) or x(12) or x(11) or x(10) or x(9) or x(8) or '1';
	aen(1) <= '1'; --x(15) or x(14) or x(13) or x(12) or x(11) or x(10) or x(9) or x(8) or x(7) or x(6) or x(5) or x(4);
	aen(0) <= '1';
	
	process(s,x)
	begin
		case s is
			when "00" => digit <= x(3 downto 0);
			when "01" => digit <= x(7 downto 4);
			when "10" => digit <= x(11 downto 8);
			when others => digit <= x(15 downto 12);
		end case;
	end process;
	
	process(digit)
	begin
		case digit is
				when X"0" => a_to_g <= "0000001";
				when X"1" => a_to_g <= "1001111";
				when X"2" => a_to_g <= "0010010";
				when X"3" => a_to_g <= "0000110";
				when X"4" => a_to_g <= "1001100";
				when X"5" => a_to_g <= "0100100";
				when X"6" => a_to_g <= "0100000";
				when X"7" => a_to_g <= "0001101";
				when X"8" => a_to_g <= "0000000";
				when X"9" => a_to_g <= "0000100";
				when X"A" => a_to_g <= "0001000";
				when X"B" => a_to_g <= "1100000";
				when X"C" => a_to_g <= "0110001";
				when X"D" => a_to_g <= "1000010";
				when X"E" => a_to_g <= "0110000";
				when others => a_to_g <= "0111000";
			end case;
		end process;
		
	process(s, aen)
	begin
		an <= "1111";
		if aen(conv_integer(s)) = '1' then
			an(conv_integer(s)) <= '0';
		end if;
		end process;
		
	process(cclk,clr)
	begin
		if clr='1' then
			s <= "00";
		elsif cclk'event and cclk = '1' then
			s <=  s + 1;
		end if;
	end process;

end x7segbc;

