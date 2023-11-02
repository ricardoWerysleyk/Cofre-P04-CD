library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparador1bit is
   Port (A,B, A_MAIOR_B,A_MENOR_B,A_IGUAL_B : in STD_LOGIC;
          AeqB,AmaqB,AmnqB : out STD_LOGIC);
end comparador1bit;

architecture ckt of comparador1bit is

begin
	AeqB <= (A XNOR B) and A_IGUAL_B;--A igual a B
	AmaqB <= ((A and (not B)) and  A_IGUAL_B) or A_MAIOR_B;	--A maior que B
	AmnqB <= (((not A) and B) and A_IGUAL_B) or A_menor_B; -- A menor que B
end ckt;