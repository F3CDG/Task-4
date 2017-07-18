----------------------------------------------------------------------------------------------
--! @file    	AXI4_Stream_Square_Root_m.vhd
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
--! @brief Tale componente, attraverso una FSM, realizza il calcolo della radice
--!        quadrata di un numero.
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AXI4_Stream_Square_Root_m is
    Port ( aclk    : in   STD_LOGIC;                                    --! Segnale di temporizzazione
           aresetn : in   STD_LOGIC;                                    --! Reset sincrono, attivo basso
           -- Slave signal interface
           s_axis_value_tvalid  : in   STD_LOGIC;                       --! Se alto, il tdata in input è valido
           s_axis_value_tready   : out  STD_LOGIC;                      --! Se alto, il componente è pronto a ricevere il tdata
           s_axis_value_tdata  : in   STD_LOGIC_VECTOR (47 downto 0);   --! Valore di cui si vuole calcolare la radice

           -- Master signal interface
           m_axis_result_tvalid : out STD_LOGIC;                        --! Se alto, il tdata in output è valido
           m_axis_result_tready : in STD_LOGIC;                         --! Se alto, il componente a valle è pronto a ricevere il dato
           m_axis_result_tdata : out  STD_LOGIC_VECTOR (23 downto 0));  --! Valore della radice calcolato
end AXI4_Stream_Square_Root_m;

architecture Behavioral of AXI4_Stream_Square_Root_m is

    --! Segnali ausiliari utili al funzionamento dell'algoritmo
    signal op  : unsigned(47 downto 0); --! In questo segnale viene memorizzato inizialmente il valore di cui si vuole calcolare la radice
    signal res : unsigned(47 downto 0); --! Qui viene memorizzato il risultato temporaneo dell'operazione
    signal one : unsigned(47 downto 0); --! Valore iniziale di confronto
    
    --! Deinizione degli stati della FSM
    type state is (idle, shift, calc, wait_tready); --! Il tipo stato può assumere i valori idle, shift, calc, wait_tready
    signal next_state : state;                      --! Creazione di un segnale next_state di tipo state

begin
    
    ROOT_ALG : process
        
         begin
         
          wait until rising_edge(aclk);
          
              case next_state is 
                
                 when idle => 
                     if (aresetn = '0') then            --! Se il reset è attivo
                        s_axis_value_tready <= '0';     --! il tready deve essere portato a zero
                     else
                         s_axis_value_tready <= '1';    --! altrimenti è settato a 1
                     end if;
                   
                     m_axis_result_tvalid <= '0';       --! Il tvalid del master è posto a zero     
              
                    --! Inizializzazione segnali ausiliari all'algoritmo                    
                    one <= x"400000000000";
                    op  <= unsigned(s_axis_value_tdata);
                    res <= (others=>'0');   
                   
                    if (s_axis_value_tvalid='1') then   --! se il t valid dello slave è pari ad 1 inizia un nuovo calcolo
                       next_state <= shift;             --! e la FSM passa nello stato di SHIFT                       
                    end if;
        
                 when shift =>
                    if (aresetn = '0') then             --! Se il reset è attivo
                       next_state <= idle;              --! si torna nello stato di idle
                    end if;
                    
                    s_axis_value_tready <= '0';
        
                    if (one > op) then
                       one <= one/4;
                    else
                       next_state   <= calc;
                    end if;
        
                 when calc =>
                    if (aresetn = '0') then             --! Se il reset è attivo
                        next_state <= idle;             --! si torna nello stato di idle
                     end if;
                     
                    if (one /= 0) then                  
                       if (op >= res+one) then         
                          op   <= op - (res+one);
                          res  <= res/2 + one;
                       else
                          res  <= res/2;
                       end if;
                       one <= one/4;
                    else
                       next_state  <= wait_tready;
                    end if;
                    
                 when wait_tready =>
                    if (aresetn = '0') then             --! Se il reset è attivo
                        next_state <= idle;             --! si torna nello stato di idle
                    end if;
                    
                    m_axis_result_tvalid <= '1';
               
                    --! Conserva il dato calcolato finchè non arriva un tready sul master     
                    if (m_axis_result_tready='1') then 
                       next_state <= idle; 
                    end if;
              end case;
       end process;
   
   --! Salvataggio del risultato sui segnali di uscita
   m_axis_result_tdata <= std_logic_vector(res(m_axis_result_tdata'range));
   
end Behavioral;