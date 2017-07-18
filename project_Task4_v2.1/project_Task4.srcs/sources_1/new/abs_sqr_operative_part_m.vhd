----------------------------------------------------------------------------------------------
--! @file    	abs_sqr_operative_part_m.vhd
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
--! @brief Questo componente ingloba in sè tutta la parte operativa del componente
--!        AXI4_Stream_Absolute_Square_m. Al suo interno sono presenti 2 registri,
--!        che funzionano da buffer di ingresso e uscita; la logica comportamentale
--!        che realizza l'operazione di modulo quadro.
----------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity abs_sqr_operative_part_m is
    Port ( s_axis_value_tdata : in STD_LOGIC_VECTOR (63 downto 0);      --! Valore di ingresso di cui si vuole calcolare il modulo quadro
           aresetn : in STD_LOGIC;                                      --! Reset sincrono esterno, attivo basso
           aclk : in STD_LOGIC;                                         --! Segnale di temporizzazione della macchina
           enable_buffer_in : in STD_LOGIC;                             --! Segnale di enable, che abilita il funzionamento del buffer di ingresso
           enable_buffer_out : in STD_LOGIC;                            --! Segnale di enable, che abilita il funzionamento del buffer di uscita
           reset_buffer_in_n : in STD_LOGIC;                            --! Reset al buffer di ingresso, sincrono, proveniente dalla FSM, attivo basso
           reset_buffer_out_n : in STD_LOGIC;                           --! Reset al buffer di uscita, sincrono, proveniente dalla FSM, attivo basso    
           m_axis_abssqr_tdata : out STD_LOGIC_VECTOR(63 downto 0));    --! Valore di uscita rappresentante il modulo quadro calcolato
end abs_sqr_operative_part_m;

architecture Structural of abs_sqr_operative_part_m is

------------------------------------------------------------------------
------------------------Modulo Quadro Component-------------------------
------------------------------------------------------------------------
    component mod_quad_oper is
    generic(n: natural:=32);
    Port ( Im : in STD_LOGIC_VECTOR (n-1 downto 0);
           Re : in STD_LOGIC_VECTOR (n-1 downto 0);
           modulo2 : out STD_LOGIC_VECTOR (2*n -1 downto 0));
    end component;
    
------------------------------------------------------------------------
--------------------------Register Component----------------------------
------------------------------------------------------------------------    
    component register_m is
        generic(N : natural:=64);
        Port ( data_in : in STD_LOGIC_VECTOR (N-1 downto 0);
               enable : in STD_LOGIC;
               reset_n : in STD_LOGIC;
               data_out : out STD_LOGIC_VECTOR (N-1 downto 0);
               clock : in STD_LOGIC);
    end component;

--! Segnali ausiliari per la gestione del circuito e i corretti collegamenti
--! tra i vari componenti    
    signal real_part : std_logic_vector(31 downto 0):=(others=>'0');
    signal imag_part : std_logic_vector(31 downto 0):=(others=>'0');
    signal result : std_logic_vector(63 downto 0):=(others=>'0');
    signal operand : std_logic_vector(63 downto 0):=(others=>'0');
    signal reset_in_n : std_logic := '1';
    signal reset_out_n : std_logic := '1';
    
begin
    reset_in_n <= aresetn and reset_buffer_in_n;
    BUFFER_IN_INST : register_m port map( 
        data_in => s_axis_value_tdata,
        enable => enable_buffer_in,
        reset_n => reset_in_n,
        data_out => operand,
        clock => aclk);
        
    imag_part <= operand(63 downto 32);
    real_part <= operand(31 downto 0);
    SQUARE_INST :mod_quad_oper port map( 
        Im => imag_part,
        Re => real_part,
        modulo2 => result);
    
    reset_out_n <= aresetn and reset_buffer_out_n;
    BUFFER_OUT_INST : register_m port map( 
        data_in => result,
        enable => enable_buffer_out,
        reset_n => reset_out_n,
        data_out => m_axis_abssqr_tdata,
        clock => aclk);    
     
end Structural;