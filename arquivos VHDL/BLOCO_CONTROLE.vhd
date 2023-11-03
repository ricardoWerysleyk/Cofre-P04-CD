library ieee;
use ieee.std_logic_1164.all;

entity BLOCO_CONTROLE is
	port(clk, BTN_LIGAR, ADD1, TEMP, FAILURE, SUCESS  : in std_logic;
            DISPLAY: out std_logic_vector(1 downto 0);
            encerrando, LED_VERMELHO, LED_AZUL, LED_VERDE : out std_logic);
end BLOCO_CONTROLE;

architecture ckt of BLOCO_CONTROLE is

    component MAQUINA_ESTADOS is
        Port (clk, FAILURE, SUCCESS: in std_logic;
		E:  in std_logic_vector(2 downto 0);
         	S: out std_logic_vector(2 downto 0);
          	encerrando: out std_logic);
    end component;

    component CIRCUITO_COMB is
        port (s0, s1, s2, btn_ligar, temp, add: in  std_logic;
            display_0, display_1, led_vermelho, led_verde, led_azul, E_0, E_1, E_2: out std_logic);
    end component;
    
    	signal S: std_logic_vector(2 downto 0);
        signal E: std_logic_vector(2 downto 0);

    begin

    SMAQUINA_ESTADOS: MAQUINA_ESTADOS port map(clk, FAILURE, SUCESS, E, S, encerrando);

    SCIRCUITO_COMB: CIRCUITO_COMB port map(S(0), S(1), S(2),BTN_LIGAR, TEMP, ADD1,  DISPLAY(0), DISPLAY(1), LED_VERMELHO, LED_VERDE,LED_AZUL,  E(0), E(1), E(2));


end ckt;