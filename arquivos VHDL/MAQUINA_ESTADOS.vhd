library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAQUINA_ESTADOS is
   Port (clk, FAILURE, SUCCESS: in std_logic;
		      E:  in std_logic_vector(2 downto 0);
         	S: out std_logic_vector(2 downto 0)
          encerrando: out std_logic);
end MAQUINA_ESTADOS;

architecture ckt of MAQUINA_ESTADOS is

  COMPONENT ffd is
   port (clk, clr, set, d : in  std_logic;
                       q : out std_logic);
  end COMPONENT;

  signal clear: std_logic;
  signal saida_ffd: std_logic_vector(2 downto 0);
  
  begin
	  F2: flipflopd port map(cLk, clear, '0', E(2), saida_ffd(2));
	  F1: flipflopd port map(cLk, clear, '0', E(1), saida_ffd(1));
	  F0: flipflopd port map(cLk, FAILURE, SUCCESS, E(0), saida_ffd(0));
    
    clear <= FAILURE and SUCCESS;
    S(2) <= saida_ffd(2);
    S(1) <= saida_ffd(1);
    S(0) <= saida_ffd(0);
    encerrando <= (saida_ffd(0) and not(saida_ffd(1)) and saida_ffd(2)) or 
                  (not(saida_ffd(0)) and not(saida_ffd(1)) and not(saida_ffd(2)));

end ckt;