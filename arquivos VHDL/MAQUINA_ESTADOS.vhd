library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAQUINA_ESTADOS is
   Port (clk, FAILURE, SUCCESS: in std_logic;
		E:  in std_logic_vector(2 downto 0);
         	S: out std_logic_vector(2 downto 0);
          	encerrando: out std_logic);
end MAQUINA_ESTADOS;

architecture ckt of MAQUINA_ESTADOS is

component ffd is
   port (ck, clr, set, d : in  std_logic;
                       q : out std_logic);
end component;

  	signal saida_ffd: std_logic_vector(2 downto 0);
	signal setFF0,setFF1,setFF2: std_logic;
	signal clearFF0,clearFF1,clearFF2: std_logic;
  
  begin
	
	
	setFF2 <= '1';
	setFF1 <= '1';
	setFF0 <= not success and failure;
	
	clearFF2 <= not success and not failure;
	clearFF1 <= not success and not failure;
	clearFF0 <=  not failure;
	
		

	  F2: ffd port map(cLk, clearFF2,setFF2, E(2), saida_ffd(2));
	  F1: ffd port map(cLk, clearFF1,setFF1, E(1), saida_ffd(1));
	  F0: ffd port map(cLk, clearFF0,setFF0, E(0), saida_ffd(0));
    

    S(2) <= saida_ffd(2);
    S(1) <= saida_ffd(1);
    S(0) <= saida_ffd(0);

    encerrando <= (saida_ffd(0) and not(saida_ffd(1)) and saida_ffd(2)) or (not(saida_ffd(0)) and not(saida_ffd(1)) and not(saida_ffd(2)));

end ckt;