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
	
	component mux_4_1_4_bits is
		Port (entrada_0, entrada_1, entrada_2, entrada_3: in std_logic_vector(3 downto 0);
				sel:  in std_logic_vector(1 downto 0);
				saida: out std_logic_vector(3 downto 0));
	end component;
	
	component mux_4_1_6_bits is
		Port (entrada_0, entrada_1, entrada_2, entrada_3: in std_logic_vector(5 downto 0);
				sel:  in std_logic_vector(1 downto 0);
				saida: out std_logic_vector(5 downto 0));
	end component;
	
	component contador_2_bits is
		Port (clk,clr: in STD_LOGIC;
				S: out std_LOGIC_VECTOR(1 downto 0));
	end component;
	
	component temporizador_5s is
		Port (clk,clr,entry : in STD_LOGIC;
			temp5 : out STD_LOGIC);
	end component;
	
	component temporizador_20s is
		Port (clk,clr,entry : in STD_LOGIC;
			temp20 : out STD_LOGIC);
	end component;
	
	component BLOCO_CONTROLE is
		port(clk, BTN_LIGAR, ADD1, TEMP, FAILURE, SUCESS  : in std_logic;
					DISPLAY: out std_logic_vector(1 downto 0);
					encerrando, LED_VERMELHO, LED_AZUL, LED_VERDE : out std_logic);
	end component;	

  	signal BTN_LIGAR, LIGADO, ENCERRANDO, ADD_INTERNO, SenhaINeqSenhaBank, desligango, resete: std_logic;
	signal tempLedAzul, clrTemp5, tempLedVerde, failure, sucess, sucess_inter, TEMP, encerrbc, sinal_vermelho, sinal_azul, sinal_verde: std_logic;
	SIGNAL PADRAO_CANCEL, PADRAO_SUCESS: STD_LOGIC_VECTOR(3 downto 0);
	signal SeletorMuxSeg, SeletorMuxSenhas, S0S1, displayBC, SelMuxSenhas: STD_LOGIC_VECTOR(1 downto 0);
	signal Entrada0MuxSeg0, Entrada1MuxSeg0, Entrada2MuxSeg0, Entrada3MuxSeg0, SaidaMuxSeg0: STD_LOGIC_VECTOR(3 downto 0);
	signal Entrada0MuxSeg1, Entrada1MuxSeg1, Entrada2MuxSeg1, Entrada3MuxSeg1, SaidaMuxSeg1: STD_LOGIC_VECTOR(3 downto 0);
	signal Entrada0MuxSenha, Entrada1MuxSenha, Entrada2MuxSenha, Entrada3MuxSenha, SaidaMuxSenha: STD_LOGIC_VECTOR(5 downto 0);
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
		Entrada0MuxSeg0 <= '1' & '1' & '0' & '1';
		Entrada0MuxSeg1 <= '1' & '1' & '0' & '1';
		Entrada1MuxSeg0 <= OutBinBCD(3) & OutBinBCD(2) & OutBinBCD(1) & OutBinBCD(0);
		Entrada1MuxSeg1 <= OutBinBCD(7) & OutBinBCD(6) & OutBinBCD(5) & OutBinBCD(4);
		Entrada2MuxSeg0 <= PADRAO_CANCEL;
		Entrada2MuxSeg1 <= PADRAO_CANCEL;
		Entrada3MuxSeg0 <= PADRAO_SUCESS;
		Entrada3MuxSeg1 <= PADRAO_SUCESS;
		
		BTN_LIGAR <= START;
		REGI01: REGISTRADOR_1_BIT port map(cLk, ENCERRANDO, START, LIGADO);
		LED_VERMELHO <= sinal_vermelho;
		LED_AZUL <= sinal_azul;
		LED_VERDE <= sinal_verde;
		ADD_INTERNO <= ADD AND LIGADO AND sinal_vermelho;
		
		COMP01: comparador6bits PORT MAP(SENHA, SaidaMuxSenha, ADD_INTERNO, SenhaINeqSenhaBank);
		binbcd1: binbcd port map(EntryBinBCD, OutBinBCD);
		
		
		muxSeg0: mux_4_1_4_bits port map(Entrada0MuxSeg0, Entrada1MuxSeg0,Entrada2MuxSeg0,Entrada3MuxSeg0,SeletorMuxSeg,SaidaMuxSeg0);
		muxSeg1: mux_4_1_4_bits port map(Entrada0MuxSeg1, Entrada1MuxSeg1,Entrada2MuxSeg1,Entrada3MuxSeg1,SeletorMuxSeg,SaidaMuxSeg1);
	   muxSenha: mux_4_1_6_bits port map(Entrada0MuxSenha, Entrada1MuxSenha,Entrada2MuxSenha,Entrada3MuxSenha,SeletorMuxSenhas,SaidaMuxSenha);
		SEG0 <= SaidaMuxSeg0;
		SEG1 <= SaidaMuxSeg1;
		desligango <= ENCERRANDO or resete;
		
		cont2bits1: contador_2_bits port map(SenhaINeqSenhaBank, desligango, SelMuxSenhas);
		cont2bits2: contador_2_bits port map(ADD_INTERNO, desligango, S0S1);
		SeletorMuxSenhas <= SelMuxSenhas;
		
		clrTemp5 <= sinal_vermelho or sinal_verde;
		temp5s: temporizador_5s port map(clk, clrTemp5, sinal_azul, tempLedAzul);
		temp20s: temporizador_20s port map(clk, sinal_vermelho, sinal_verde, tempLedVerde);
		
		sucess_inter <= S0S1(0) and S0S1(1) and SeletorMuxSenhas(0) and SeletorMuxSenhas(1);
		failure <= not(sucess_inter) and S0S1(0) and S0S1(1) and tempLedAzul;
		sucess <= sucess_inter and tempLedAzul;
		
		resete <= (failure or sucess) and (tempLedVerde or tempLedAzul);
		
		ENCERRANDO <= encerrbc AND (tempLedAzul or tempLedVerde);
		TEMP <= TEMpLedAzul OR TEMpLedVerde;
		SeletorMuxSeg <= displayBC(0) & displayBC(1);
		blocoControle: bloCO_CONTROLE port map(clk, START, ADD_INTERNO, TEMP, failure, sucess, displayBC, encerrbc, sinal_vermelho, sinal_azul, sinal_verde);
	end ckt;