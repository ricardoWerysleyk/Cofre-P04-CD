library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity temporizador_5s is
   Port (clk,clr,entry : in STD_LOGIC;
		temp5 : out STD_LOGIC);
end temporizador_5s;

architecture ckt of temporizador_5s is

component contador_6_bits is
   Port (clk,clr : in STD_LOGIC;
         	S: out std_LOGIC_VECTOR(5 downto 0));
end component;

COMPONENT REGISTRADOR_1_BIT is

   Port (clk,clr : in STD_LOGIC;
		E :  in STD_LOGIC;
         	S : out STD_LOGIC);

end COMPONENT;


signal CLRcont,CLKcont, Sreg :   std_logic;
signal Scont : std_LOGIC_VECTOR(5 downto 0);

begin

U0: contador_6_bits port map (CLKcont,clr,Scont);
U1: REGISTRADOR_1_BIT port map (clk,clr,CLRcont,Sreg);

CLKcont <= (clk and entry );
CLRcont <= ((NOT Scont(0)) and (NOT Scont(1)) and Scont(2));
temp5 	<= Sreg; 


end ckt;
