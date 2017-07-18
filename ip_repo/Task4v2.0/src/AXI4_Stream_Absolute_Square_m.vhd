----------------------------------------------------------------------------------------------
--! @file    	AXI4_Stream_Absolute_Square_m.vhd
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
--! @brief Il componente riceve in ingresso un segnale complesso, avente parte reale
--!        e parte immaginaria su 32 bit, e ne calcola il modulo quadro. Esso, 
--!        attraverso l'utilizzo dei segnali tvalid, tready  e tdata, è compatibile
--!        con interfaccia AXI4 Stream.
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AXI4_Stream_Absolute_Square_m is
    Port ( aresetn : in STD_LOGIC;                                  --! Reset del componente, sincrono e attivo basso
           aclk : in STD_LOGIC;                                     --! Segnale di temporizzazione
           -- Interfaccia AXI4 Stream Slave
           s_axis_value_tdata : in STD_LOGIC_VECTOR (63 downto 0);  --! Dato in ingresso espresso su 64 bit (32 Im, 32 Re)
           s_axis_value_tvalid : in STD_LOGIC;                      --! Se alto, il dato in input è valido
           s_axis_value_tready : out STD_LOGIC;                     --! Se alto, si è pronti ad accettare il tdata in input
           -- Interfaccia AXI4 Stream Master
           m_axis_abssqr_tdata : out STD_LOGIC_VECTOR (63 downto 0);--! Valore del modulo quadro calcolato
           m_axis_abssqr_tvalid : out STD_LOGIC;                    --! Se alto, il segnale tdata in output è valido
           m_axis_abssqr_tready : in STD_LOGIC);                    --! Se alto il componente a valle è pronto ad accettare il tdata in output
end AXI4_Stream_Absolute_Square_m;

architecture Structural of AXI4_Stream_Absolute_Square_m is

------------------------------------------------------------------------
------------------------Control Unit Component--------------------------
------------------------------------------------------------------------
    component abs_sqr_control_unit_m is
    Port ( aclk : in STD_LOGIC;
           aresetn : in STD_LOGIC;
           s_axis_value_tvalid : in STD_LOGIC;
           m_axis_abssqr_tready : in STD_LOGIC;
           enable_buffer_in : out STD_LOGIC;
           enable_buffer_out : out STD_LOGIC;
           reset_buffer_in_n : out STD_LOGIC;
           reset_buffer_out_n : out STD_LOGIC;
           s_axis_value_tready : out STD_LOGIC;
           m_axis_abssqr_tvalid : out STD_LOGIC);
    end component;

------------------------------------------------------------------------
----------------------Operative Part Component--------------------------
------------------------------------------------------------------------   
    component abs_sqr_operative_part_m is
        Port ( s_axis_value_tdata : in STD_LOGIC_VECTOR (63 downto 0);
               aresetn : in STD_LOGIC;
               aclk : in STD_LOGIC;
               enable_buffer_in : in STD_LOGIC;
               enable_buffer_out : in STD_LOGIC;
               reset_buffer_in_n : in STD_LOGIC;
               reset_buffer_out_n : in STD_LOGIC;
               m_axis_abssqr_tdata : out STD_LOGIC_VECTOR(63 downto 0));
    end component;
    
    
    --! Segnali ausiliari per collegare la Parte Operativa alla parte di controllo
    signal enable_buffer_in : std_logic :='0';
    signal enable_buffer_out : std_logic :='0';
    signal reset_buffer_in_n : STD_LOGIC:='1';
    signal reset_buffer_out_n : STD_LOGIC:='1';
    
begin

    CONTROL_UNIT_INST : abs_sqr_control_unit_m port map( 
        aclk => aclk,
        aresetn => aresetn,
        s_axis_value_tvalid => s_axis_value_tvalid,
        m_axis_abssqr_tready => m_axis_abssqr_tready,
        enable_buffer_in => enable_buffer_in,
        enable_buffer_out => enable_buffer_out,
        s_axis_value_tready => s_axis_value_tready,
        reset_buffer_out_n => reset_buffer_out_n,
        reset_buffer_in_n => reset_buffer_in_n,
        m_axis_abssqr_tvalid => m_axis_abssqr_tvalid);
        
    OPERATIVE_UNIT_INST : abs_sqr_operative_part_m port map( 
        s_axis_value_tdata => s_axis_value_tdata,
        aresetn => aresetn,
        aclk => aclk,
        enable_buffer_in => enable_buffer_in,
        enable_buffer_out => enable_buffer_out,
        reset_buffer_out_n => reset_buffer_out_n,
        reset_buffer_in_n => reset_buffer_in_n,
        m_axis_abssqr_tdata => m_axis_abssqr_tdata);

end Structural;