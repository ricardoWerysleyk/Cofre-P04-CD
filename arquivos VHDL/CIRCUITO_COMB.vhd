library ieee;
use ieee.std_logic_1164.all;

entity circuito_comb is
    port (s0, s1, s2, btn_ligar, temp, add: in  std_logic;
            display_0, display_1, led_vermelho, led_verde, led_azul, E_0, E_1, E_2: out std_logic);
end circuito_comb;

architecture ckt of CIRCUITO_COMB is

begin
   E_0 <= ((not temp) and s0) or (s1 and (not s2) and btn_ligar);
   E_1 <= (s1 and (not btn_ligar)) or (s1 and s2) or ((not s0) and s2 and temp);
   E_2 <= (s2 and (not temp)) or ((not s0) and (not s2) and btn_ligar) or (s1 and (not s2) and add);
   display_0 <= s0;
   display_1 <= s1 or (s0 and (not s2));
   led_vermelho <= (not s0) and (not s2);
   led_verde <= s0 and (not s2); 
   led_azul <= s2;
  
end ckt;