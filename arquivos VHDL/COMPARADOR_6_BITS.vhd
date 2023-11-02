library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparador6bits is
   Port ( A, B: in STD_LOGIC_VECTOR(5 downto 0);
			verification : IN STD_LOGIC;
         SAeqB,SAmaqB,SAmnqB: out STD_LOGIC);
end comparador6bits;

architecture ckt of comparador6bits is

component comparador1bit is
   Port (A,B, A_IGUAL_B, A_MAIOR_B,A_MENOR_B : in STD_LOGIC;
          AeqB,AmaqB,AmnqB : out STD_LOGIC);
end component;

signal AeqB5,AmaqB5,AmnqB5 : STD_LOGIC;
signal AeqB4,AmaqB4,AmnqB4: STD_LOGIC;
signal AeqB3,AmaqB3,AmnqB3 : STD_LOGIC;
signal AeqB2,AmaqB2,AmnqB2 : STD_LOGIC;
signal AeqB1,AmaqB1,AmnqB1 : STD_LOGIC;
signal AeqB0,AmaqB0,AmnqB0: STD_LOGIC;
begin

	U5: comparador1bit port map (A(5),B(5),'1','0','0',AeqB5,AmaqB5,AmnqB5);
	U4: comparador1bit port map (A(4),B(4),AeqB5,AmaqB5,AmnqB5,AeqB4,AmaqB4,AmnqB4);
	U3: comparador1bit port map (A(3),B(3),AeqB4,AmaqB4,AmnqB4,AeqB3,AmaqB3,AmnqB3);
	U2: comparador1bit port map (A(2),B(2),AeqB3,AmaqB3,AmnqB3,AeqB2,AmaqB2,AmnqB2);
	U1: comparador1bit port map (A(1),B(1),AeqB2,AmaqB2,AmnqB2,AeqB1,AmaqB1,AmnqB1);
	U0: comparador1bit port map (A(0),B(0),AeqB1,AmaqB1,AmnqB1,AeqB0,AmaqB0,AmnqB0);
	 
	 
	SAeqB	 <= verification AND AeqB0;
	SAmnqB <= verification AND AmnqB0;
	SAmaqB <= verification AND AmaqB0;

	
end ckt;

