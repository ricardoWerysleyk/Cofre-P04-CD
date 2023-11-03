library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cofre is
   Port (
			clk, ADD, START: in std_logic;
			SENHA:  in std_logic_vector(5 downto 0);
			SEG0, SEG1: out std_logic_vector(3 downto 0);
			LED_VERMELHO, LED_AZUL, LED_VERDE: out std_logic
		);
end cofre;

architecture ckt of cofre is

	component cofre_ckt is
		Port (
				clk, ADD, START: in std_logic;
				SENHA:  in std_logic_vector(5 downto 0);
				SEG0, SEG1: out std_logic_vector(3 downto 0);
				LED_VERMELHO, LED_AZUL, LED_VERDE: out std_logic
			);
	end component;
begin
		IHM: cofre_ckt port map(clk, ADD, START, SENHA, SEG0, SEG1, LED_VERMELHO, LED_AZUL, LED_VERDE);
end ckt;