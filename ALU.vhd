library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity ALU is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           opcode : in  STD_LOGIC_VECTOR (3 downto 0);
           y : out  STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is
signal p: std_logic_vector(7 downto 0);
signal q: std_logic_vector(7 downto 0);

begin
	p(3 downto 0) <= a;
	q(3 downto 0) <= b;
	p(7 downto 4) <= "0000";
	q(7 downto 4) <= "0000";
	with opcode select
		y <= p+q when "0000",
				p-q when "0001",
				--p-q when "0010",
				p*q when others;
		--y(7 downto 4) <= "0000";
end Behavioral;

