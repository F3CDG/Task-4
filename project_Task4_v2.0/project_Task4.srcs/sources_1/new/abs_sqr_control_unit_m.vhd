----------------------------------------------------------------------------------------------
--! @file    	abs_sqr_control_unit_m.vhd
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
--!  Task4 is free software: you can redistribute it and/or modify
--!  it under the terms of the GNU Affero General Public License as published by
--!  the Free Software Foundation, either version 3 of the License, or
--!  (at your option) any later version.
--!
--!  This file is part of Task4.
--!
--!  Task4 is distributed in the hope that it will be useful,
--!  but WITHOUT ANY WARRANTY; without even the implied warranty of
--!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--!  GNU Affero General Public License for more details.
--!
--!  You should have received a copy of the GNU Affero General Public License
--!  along with Linux Driver: Examples. If not, see
--!  <https://www.gnu.org/licenses/agpl-3.0.html>.
--! @brief Questo componente realizza una FSM per il controllo del componente
--!        che si occupa di calcolare il modulo quadro di un numero. Tale macchina
--!        a stati si è resa necessaria, per interfacciare il componente con AXI4 Stream.
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity abs_sqr_control_unit_m is
    Port ( aclk : in STD_LOGIC;                     --! Segnale di temporizzazione della FSM
           aresetn : in STD_LOGIC;                  --! Reset della FSM, sincrono e attivo bass
           s_axis_value_tvalid : in STD_LOGIC;      --! Se alto, vuol dire che il dato di input all'interfaccia slave è valido
           m_axis_abssqr_tready : in STD_LOGIC;     --! Se alto, vuol dire che il componente che si trova a valle è pronto a ricevere il dato di output
           enable_buffer_in : out STD_LOGIC;        --! Se alto, abilita a scrivere nel buffer di input della macchina
           enable_buffer_out : out STD_LOGIC;       --! Se alto, abilita a scrivere nel buffer di output della macchina
           reset_buffer_in_n : out STD_LOGIC;       --! Reset sincrono per il buffer di input della macchina
           reset_buffer_out_n : out STD_LOGIC;      --! Reset sincrono per il buffer di output della macchina
           s_axis_value_tready : out STD_LOGIC;     --! Se alto, vuol dire che l'interfaccia slave è pronta a ricevere un dato
           m_axis_abssqr_tvalid : out STD_LOGIC);   --! Se alto, vuol dire che il dato in uscita dall'interfaccia master è valido
end abs_sqr_control_unit_m;

architecture Behavioral of abs_sqr_control_unit_m is

    type state_type is(RESET,IDLE,RESULT_CALCULATION,WAIT_M_TREADY);
    signal current_state, next_state : state_type := RESET;

begin

------------------------------------------------------------------------
-----------------------------Sync Process-------------------------------
------------------------------------------------------------------------
--! Questo process realizza la sincronizzazione degli stati con il segnale
--! di temporizzazione. Ogni volta che si verifica un rising_edge la FSM
--! entra nello stato definito in next_state
    SYNC_PROCESS : process(aclk)
        begin
            if(rising_edge(aclk))then
                if(aresetn='0')then                 --! Se il segnale di reset è attivo, la FSM entra nello stato di RESET
                    current_state <= RESET;
                else
                    current_state <= next_state;    --! altrimenti entra nello stato definito in next_state
                end if;
            end if;
    end process SYNC_PROCESS;
    
------------------------------------------------------------------------
------------------------Output Decode Process---------------------------
------------------------------------------------------------------------
--! In questo process vengono definiti i valori dei segnali di output 
--! della FSM
    OUTPUT_DECODE : process(current_state)
        begin
            case(current_state) is
                when RESET => 
                    enable_buffer_in <= '0';
                    enable_buffer_out <= '0';
                    s_axis_value_tready <= '0';
                    m_axis_abssqr_tvalid <= '0';
                    reset_buffer_in_n <= '1';
                    reset_buffer_out_n <= '1';
                when IDLE =>
                     enable_buffer_in <= '1';
                     enable_buffer_out <= '0';
                     s_axis_value_tready <= '1';
                     m_axis_abssqr_tvalid <= '0';
                     reset_buffer_in_n <= '1';
                     reset_buffer_out_n <= '0';
                 when RESULT_CALCULATION =>
                     enable_buffer_in <= '0';
                     enable_buffer_out <= '1';
                     s_axis_value_tready <= '0';
                     m_axis_abssqr_tvalid <= '0';
                     reset_buffer_in_n <= '1';
                     reset_buffer_out_n <= '1';
                  when WAIT_M_TREADY =>
                     enable_buffer_in <= '0';
                     enable_buffer_out <= '0';
                     s_axis_value_tready <= '0';
                     m_axis_abssqr_tvalid <= '1';
                     reset_buffer_in_n <= '0';
                     reset_buffer_out_n <= '1';
            end case;
    end process OUTPUT_DECODE;


------------------------------------------------------------------------
--------------------------Next State Process----------------------------
------------------------------------------------------------------------ 
--! In questo process viene definito chi deve essere lo stato successivo
--! in cui la FSM deve entrare, in base ai segnali di input
    NEXT_STATE_DECODE : process(current_state,s_axis_value_tvalid,m_axis_abssqr_tready,aresetn)
        begin
            case(current_state)is
                when RESET =>
                    if(aresetn='0')then
                        next_state <= RESET;
                    else
                        next_state <= IDLE;
                    end if;
                when IDLE =>
                    if(s_axis_value_tvalid='0')then
                        next_state <= IDLE;
                    else
                        next_state <= RESULT_CALCULATION;
                    end if;
                when RESULT_CALCULATION =>
                    next_state <= WAIT_M_TREADY;
                when WAIT_M_TREADY =>
                    if(m_axis_abssqr_tready='0')then
                        next_state <= WAIT_M_TREADY;
                     else
                        next_state <= IDLE;
                    end if;
             end case;
    end process;

end Behavioral;