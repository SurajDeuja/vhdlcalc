library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
 
entity BIN2BCD is 
    port (
          BIN : in STD_LOGIC_VECTOR (7 downto 0);
          BCD: out STD_LOGIC_VECTOR (11 downto 0) 
         ); 
end BIN2BCD;
 
architecture IFSC of BIN2BCD is 
 
begin 
  bcd1: process(BIN) 
     variable z: STD_LOGIC_VECTOR (20 downto 0);       
  begin 
  z := (OTHERS=>'0');
  z(8 downto 1) := BIN(7 downto 0); 
 
  for i in 0 to 7 loop 
   if z(12 downto 9) > 4 then  
       z(12 downto 9) := z(12 downto 9) + 3; 
   end if; 
   if z(16 downto 13) > 4 then  
       z(16 downto 13) := z(16 downto 13) + 3; 
   end if; 
   z(20 downto 1) := z(19 downto 0); 
  end loop; 
 
 BCD <= z(20 downto 9);  
  end process bcd1;             
end IFSC;