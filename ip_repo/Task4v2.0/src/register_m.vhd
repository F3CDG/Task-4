----------------------------------------------------------------------------------------------
--! @file    	register_m.vhd
--! @authors	
--!             Colella Gianni      <gian.colella@studenti.unina.it>        <br>
--!             Guida Ciro          <ciro.guida4@studenti.unina.it>         <br>
--!             Lombardi Daniele    <daniele.lombardi@studenti.unina.it>    <br>
--! @version 	V2.0
--! @date    	17-July-2017
--! @copyright
--!  Copyright (C) 2017      
--!  Colella Gianni      <gian.colella@studenti.unina.it>        <br>
--!  Guida Ciro          <ciro.guida4@studenti.unina.it>         <br>
--!  Lombardi Daniele    <daniele.lombardi@studenti.unina.it>    <br>
--!  This file is part of Task4. It is realized from Group IV of Embedded System 
--!  Class, University of Naples "Federico II", in the academic year 2016/17.
--!
--!  This file is part of Task4.
--!
--!  Task4 is free software: you can redistribute it and/or modify
--!  it under the terms of the GNU Affero General Public License as published by
--!  the Free Software Foundation, either version 3 of the License, or
--!  (at your option) any later version.
--!
--!  Task4 is distributed in the hope that it will be useful,
--!  but WITHOUT ANY WARRANTY; without even the implied warranty of
--!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--!  GNU Affero General Public License for more details.
--!
--!  You should have received a copy of the GNU Affero General Public License
--!  along with Linux Driver: Examples. If not, see
--!  <https://www.gnu.org/licenses/agpl-3.0.html>.
--! @brief Attraverso una descrizione hardware puramente comportamentale
--!         viene implementato un registro semplice per la memorizzazione
--!         dei dati
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_m is
    generic(N : natural:=32);                               --! Definisce la dimensione N del registro che viene istanziato
    Port ( data_in : in STD_LOGIC_VECTOR (N-1 downto 0);    --! Valore di ingresso al registro espresso su N bit
           enable : in STD_LOGIC;                           --! Segnale di abilitazione utilizzato per la scrittura nel registro
           reset_n : in STD_LOGIC;                          --! Reset del registro, definito attivo basso e sincrono col segnale di temporizzazione
           data_out : out STD_LOGIC_VECTOR (N-1 downto 0);  --! Segnale di temporizzazione del registro
           clock : in STD_LOGIC);
end register_m;

architecture Behavioral of register_m is

begin

    process(clock)
    
        begin
            if rising_edge(clock) then
                if reset_n='0' then                 --! Se il reset è attivo
                   data_out <= (others=>'0');       --! il valore memorizzato nel registro viene portato a 0.
                elsif enable = '1' then             --! Altrimenti, se il segnale di enable è pari ad 1
                   data_out <= data_in;             --! il valore nel registro viene aggiornato col dato di ingresso
                end if;
            end if;
        end process;

end Behavioral;