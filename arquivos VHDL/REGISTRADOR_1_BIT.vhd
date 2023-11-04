library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REGISTRADOR_1_BIT is
   Port (clk,clr : in STD_LOGIC;
		E :  in STD_LOGIC;
         	S : out STD_LOGIC);
end REGISTRADOR_1_BIT;

architecture ckt of REGISTRADOR_1_BIT is

component FFJK_REG_1BIT is
  port (clk,J,K,prs,clr : in std_logic;
        Q: out std_logic;
        Qnot : out std_logic);
 end component;

signal FFJK0Q,FFJK0Qb : STD_LOGIC;

begin


FF0:FFJK_REG_1BIT port map (clk,E,'0','0',clr,FFJK0Q,FFJK0Qb);


S <=FFJK0Q;

end ckt;