library ieee;
use ieee.std_logic_1164.all;

entity bnt_sincrono is
    port(clk, BTN: in std_logic;
        saida: out std_logic);
end bnt_sincrono;

architecture ckt of bnt_sincrono is

    component ffd is
        port (ck, clr, set, d : in  std_logic;
                q : out std_logic);
    end component;

    signal S1, S2: std_logic;

begin

FFD1: ffd port map(clk,'0', '0',BTN,S1);
FFD2: ffd port map(clk,'0', '0', '1', S2);

saida <= S1 and S2;