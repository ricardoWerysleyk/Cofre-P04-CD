library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cofre_ckt is
   Port (
			clk, ADD, START: in std_logic;
			SENHA:  in std_logic_vector(5 downto 0);
			SEG0, SEG1: out std_logic_vector(3 downto 0);
			LED_VERMELHO, LED_AZUL, LED_VERDE: out std_logic
		);
end cofre_ckt;

architecture ckt of cofre_ckt is

	component REGISTRADOR_1_BIT is
		Port (
				clk,clr : in STD_LOGIC;
				E :  in STD_LOGIC;
         	S : out STD_LOGIC
				);
	end component;
	
	component comparador6bits is
		Port ( A, B: in STD_LOGIC_VECTOR(5 downto 0);
				verification : IN STD_LOGIC;
				SAeqB,SAmaqB,SAmnqB: out STD_LOGIC);
	end component;
	
	component binbcd is
		port(sw: in std_logic_vector (7 downto 0);
			 bcd: out std_logic_vector (11 downto 0));
	end component;

  	signal BTN_LIGAR, LIGADO, ENCERRANDO, ENCERRANDO_BLOCO_CONTROLE, ADD_INTERNO, SenhaINeqSenhaBank: std_logic;
	SIGNAL SENHA_OUT_MUX: STD_LOGIC_VECTOR(5 downto 0);
	SIGNAL PADRAO_CANCEL, PADRAO_SUCESS: STD_LOGIC_VECTOR(3 downto 0);
	signal SeletorMuxSeg0, SeletorMuxSeg1, SeletorMuxSenhas: STD_LOGIC_VECTOR(1 downto 0);
	signal Entrada0MuxSeg0, Entrada1MuxSeg0, Entrada2MuxSeg0, Entrada3MuxSeg0: STD_LOGIC_VECTOR(3 downto 0);
	signal Entrada0MuxSeg1, Entrada1MuxSeg1, Entrada2MuxSeg1, Entrada3MuxSeg1: STD_LOGIC_VECTOR(3 downto 0);
	signal Entrada0MuxSenha, Entrada1MuxSenha, Entrada2MuxSenha, Entrada3MuxSenha: STD_LOGIC_VECTOR(3 downto 0);
	signal EntryBinBCD: STD_LOGIC_VECTOR(7 downto 0);
	signal OutBinBCD: STD_LOGIC_VECTOR(11 downto 0);
  
  begin
		
		PADRAO_CANCEL <= '1' & '1' & '1' & '0';
		PADRAO_SUCESS <= '1' & '0' & '1' & '0';
		Entrada0MuxSenha <= '0' & '0' & '0' & '0' & '0' & '1';
		Entrada1MuxSenha <= '0' & '0' & '0' & '0' & '1' & '1';
		Entrada2MuxSenha <= '0' & '0' & '0' & '1' & '1' & '1';
		Entrada3MuxSenha <= '0' & '0' & '0' & '0' & '0' & '0';
		
		EntryBinBCD <= '0' & '0' & SENHA;
		Entrada1MuxSeg0 <= OutBinBCD(3) & OutBinBCD(2) & OutBinBCD(1) & OutBinBCD(0);
		Entrada1MuxSeg1 <= OutBinBCD(7) & OutBinBCD(6) & OutBinBCD(5) & OutBinBCD(4);
		Entrada2MuxSeg0 <= PADRAO_CANCEL;
		Entrada2MuxSeg1 <= PADRAO_CANCEL;
		Entrada3MuxSeg0 <= PADRAO_SUCESS;
		Entrada3MuxSeg1 <= PADRAO_SUCESS;
		
		BTN_LIGAR <= START;
		REGI01: REGISTRADOR_1_BIT port map(cLk, ENCERRANDO, START, LIGADO);
		ADD_INTERNO <= ADD AND LIGADO AND LED_VERMELHO;
		
		COMP01: comparador6bits PORT MAP(SENHA, SENHA_OUT_MUX, ADD_INTERNO, SenhaINeqSenhaBank);
		binbcd1: binbcd port map(EntryBinBCD, OutBinBCD);
	  
end ckt;