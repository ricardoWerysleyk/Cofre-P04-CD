library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4_1_4_bits is
   Port (entrada_0, entrada_1, entrada_2, entrada_3: in std_logic_vector(3 downto 0);
			sel:  in std_logic_vector(1 downto 0);
         saida: out std_logic_vector(3 downto 0));
end mux_4_1_4_bits;

architecture ckt of mux_4_1_4_bits is

	signal teste_0, teste_1, teste_2, teste_3: std_logic;
	
	begin
			teste_0 <= (entrada_0(0) and not(sel(1)) and not(sel(0))) or (entrada_1(0) and not(sel(1)) and sel(0)) or (entrada_2(0) and sel(1) and not(sel(0))) or (entrada_3(0) and sel(1) and sel(0));
			teste_1 <= (entrada_0(1) and not(sel(1)) and not(sel(0))) or (entrada_1(1) and not(sel(1)) and sel(0)) or (entrada_2(1) and sel(1) and not(sel(0))) or (entrada_3(1) and sel(1) and sel(0));
			teste_2 <= (entrada_0(2) and not(sel(1)) and not(sel(0))) or (entrada_1(2) and not(sel(1)) and sel(0)) or (entrada_2(2) and sel(1) and not(sel(0))) or (entrada_3(2) and sel(1) and sel(0));
			teste_3 <= (entrada_0(3) and not(sel(1)) and not(sel(0))) or (entrada_1(3) and not(sel(1)) and sel(0)) or (entrada_2(3) and sel(1) and not(sel(0))) or (entrada_3(3) and sel(1) and sel(0));
			
			saida <= teste_3 & teste_2 & teste_1 & teste_0;
		
		

end ckt;

