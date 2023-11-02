library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_6_bits is
   Port (clk,clr: in STD_LOGIC;
         S: out std_LOGIC_VECTOR(5 downto 0));
end contador_6_bits;

architecture ckt of contador_6_bits is

component ffjk is
   port (ck, clr, set, j, k : in  std_logic;
                          q : out std_logic);
end component;

signal FFJK5,FFJK4,FFJK3,FFJK2,FFJK1,FFJK0 :   std_logic;
signal FFJK0Q,FFJK1Q,FFJK2Q,FFJK3Q,FFJK4Q,FFJK5Q :   std_logic;
signal ENABLE , NOTCLR:   std_logic;

begin

ENABLE <= CLK;
NOTCLR <= NOT CLR;

FF0: ffJK  port map (ENABLE,NOTCLR,'1','1','1',FFJK0Q);
FF1: ffJK  port map (FFJK0,NOTCLR,'1','1','1',FFJK1Q);
FF2: ffJK  port map (FFJK1,NOTCLR,'1','1','1',FFJK2Q);
FF3: ffJK  port map (FFJK2,NOTCLR,'1','1','1',FFJK3Q);
FF4: ffJK  port map (FFJK3,NOTCLR,'1','1','1',FFJK4Q);
FF5: ffJK  port map (FFJK4,NOTCLR,'1','1','1',FFJK5Q);

FFJK5<= NOT FFJK5Q;
FFJK4<= NOT FFJK4Q;
FFJK3<= NOT FFJK3Q;
FFJK2<= NOT FFJK2Q;
FFJK1<= NOT FFJK1Q;
FFJK0<= NOT FFJK0Q;


S(5) <= FFJK5Q;
S(4) <= FFJK4Q;
S(3) <= FFJK3Q;
S(2) <= FFJK2Q;
S(1) <= FFJK1Q;
S(0) <= FFJK0Q;

end ckt;
