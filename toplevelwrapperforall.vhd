library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity toplevelwrapperforall is
    Port ( clockin : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           row : in  STD_LOGIC_VECTOR (2 downto 0);
           col : out  STD_LOGIC_VECTOR (3 downto 0);
           data : out  STD_LOGIC_VECTOR (6 downto 0);
           keyP : out  STD_LOGIC;
			  sel  : in std_logic;
			  opcode: in std_logic_vector(3 downto 0);
			  an: out std_logic_vector(3 downto 0);
			  dp: out std_logic);
	end toplevelwrapperforall;

architecture Behavioral of toplevelwrapperforall is

signal clock: std_logic_vector(2 downto 0);
signal data_keypad: std_logic_vector(3 downto 0);
signal key_pressed: std_logic;
signal reset: std_logic;
signal input_to_alu: std_logic_vector (7 downto 0);

signal output_from_alu: std_logic_vector(7 downto 0);
signal bcd_value: std_logic_vector(11 downto 0);
signal input_to_7segdisplay: std_logic_vector(15 downto 0);

BEGIN


clkdiv: entity clkdiv port map (clockin,reset,clock(2),clock(1),clock(0));
microcontroller: entity microcontroller port map(col,row,data_keypad,reset,clock(1),key_pressed);
memoryunit: entity fourbitmemory port map(clock(1),key_pressed,reset,sel,data_keypad,input_to_alu);
arithmeticlogicunit: entity ALU port map(input_to_alu(3 downto 0),input_to_alu(7 downto 4),opcode,output_from_alu);

sevensegdisplay: entity x7segbc port map(input_to_7segdisplay,clock(1),reset,data,an,dp);
binarytobcd: entity BIN2BCD port map(output_from_alu,bcd_value);

input_to_7segdisplay(15 downto 12) <= input_to_alu(3 downto 0);
input_to_7segdisplay(11 downto 8) <= input_to_alu(7 downto 4);
input_to_7segdisplay(7 downto 0) <= bcd_value(7 downto 0);
keyP <= key_pressed;
reset <= clr;

end Behavioral;

