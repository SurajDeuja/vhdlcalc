library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity clkdiv is
    Port (
				mclk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           clk25 : out  STD_LOGIC;
           clk190 : out  STD_LOGIC;
           clk3 : out  STD_LOGIC
   				);
				
end clkdiv;  --      clk_p745 : out  STD_LOGIC;architecture Behavioral of clk_div26 is

architecture clkdiv of clkdiv is

signal q: STD_LOGIC_VECTOR(23 downto 0);

begin
		--clock divider
		process (mclk, clr)
		begin
			if clr = '1' then
						q <= X"000000";
						elsif mclk'event and mclk = '1' then
						q <= q +1;
						
						end if;
		end process;
		
		clk25 <= q(0);			--25 MHz
		clk190 <= q(17);		--190 Hz
		clk3	<= q(23);		--3 Hz
--		clk_p745 <= q(25);	--.745Hz
		


end clkdiv;
