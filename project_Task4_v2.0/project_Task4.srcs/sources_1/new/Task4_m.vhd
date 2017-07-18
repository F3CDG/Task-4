----------------------------------------------------------------------------------------------
--! @file    	Task4_m.vhd
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
--!  Task4 is distributed in the hope that it will be useful,
--!  but WITHOUT ANY WARRANTY; without even the implied warranty of
--!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--!  GNU Affero General Public License for more details.
--!
--!  You should have received a copy of the GNU Affero General Public License
--!  along with Linux Driver: Examples. If not, see
--!  <https://www.gnu.org/licenses/agpl-3.0.html>.
--! @brief Questo componente include tutte le funzionalità che deve eseguire il
--!        Task 4. In particolare, in ingresso al componente vengono forniti
--!        2 segnali complessi espressi su 64 bit (32 Im, 32 Re); in uscita,
--!        invece, è reso disponibile un segnale contenente la radice del
--!        rapporto del modulo quadro dei due segnali di ingresso. Tale segnale
--!        è espresso su 24 bit, di cui 13 sono la parte intera, 11 quella
--!        decimale. Tutto il componente è realizzato in modo tale da essere 
--!        compatibile con interfaccia AXI4 Stream.
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Task4_m is
    Port ( aclk : in STD_LOGIC;                                         --! Segnale di temporizzazione
           aresetn : in STD_LOGIC;                                      --! Reset sincrono, attivo basso
           -- Interfaccia Slave del componente
           s_axis_sum_early_tvalid :  in STD_LOGIC;                     --! Se alto, il dato sum_early è valido
           s_axis_sum_early_tready :  out STD_LOGIC;                    --! Se alto il componente è pronto a ricevere sum_early
           s_axis_sum_early_tdata : in STD_LOGIC_VECTOR (63 downto 0);  --! Segnale di input rappresentante sum_early
           s_axis_sum_late_tvalid :  in STD_LOGIC;                      --! Se alto, il dato sum_late è valido
           s_axis_sum_late_tready :  out STD_LOGIC;                     --! Se alto il componente è pronto a ricevere sum_late
           s_axis_sum_late_tdata : in STD_LOGIC_VECTOR (63 downto 0);   --! Segnale di input rappresentante sum_late
           -- Interfaccia Master del componente
           m_axis_r_tvalid: out std_logic;                              --! Se alto, il dato r in output è valido
           m_axis_r_tready: in std_logic;                               --! Se alto, il componente a valle è pronto a ricevere il dato r
           m_axis_r_tdata : out STD_LOGIC_VECTOR (23 downto 0)          --! Segnale di output rappresentante r
           );
end Task4_m;

architecture Structural of Task4_m is
------------------------------------------------------------------------
-----------------------Absolute Square Component------------------------
------------------------------------------------------------------------
    component AXI4_Stream_Absolute_Square_m is
        Port ( aresetn : in STD_LOGIC;
               aclk : in STD_LOGIC;
               -- Interfaccia Slave del componente
               s_axis_value_tdata : in STD_LOGIC_VECTOR (63 downto 0);
               s_axis_value_tvalid : in STD_LOGIC;
               s_axis_value_tready : out STD_LOGIC;
               -- Interfaccia Master del componente
               m_axis_abssqr_tdata : out STD_LOGIC_VECTOR (63 downto 0);
               m_axis_abssqr_tvalid : out STD_LOGIC;
               m_axis_abssqr_tready : in STD_LOGIC);
    end component;

------------------------------------------------------------------------
---------------------------Divisor Component----------------------------
------------------------------------------------------------------------
   component AXI4_Stream_Divider_m IS
      PORT (
        aclk : IN STD_LOGIC;
        aresetn : IN STD_LOGIC;
        -- Interfaccia Slave del componente
        s_axis_divisor_tvalid : IN STD_LOGIC;
        s_axis_divisor_tready : OUT STD_LOGIC;
        s_axis_divisor_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        s_axis_dividend_tvalid : IN STD_LOGIC;
        s_axis_dividend_tready : OUT STD_LOGIC;
        s_axis_dividend_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        -- Interfaccia Master del componente
        m_axis_dout_tvalid : OUT STD_LOGIC;
        m_axis_dout_tready : IN STD_LOGIC;
        m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(103 DOWNTO 0)
      );
    END component;
        
------------------------------------------------------------------------
--------------------------Square Root Component-------------------------
------------------------------------------------------------------------
    component AXI4_Stream_Square_Root_m is
        Port ( aclk    : in   STD_LOGIC;
               aresetn : in   STD_LOGIC;
               -- Slave signal interface
               s_axis_value_tvalid  : in   STD_LOGIC;
               s_axis_value_tready   : out  STD_LOGIC;
               s_axis_value_tdata  : in   STD_LOGIC_VECTOR (47 downto 0);   
               -- Master signal interface
               m_axis_result_tvalid : out STD_LOGIC;
               m_axis_result_tready : in STD_LOGIC;
               m_axis_result_tdata : out  STD_LOGIC_VECTOR (23 downto 0));
    end component;

--! Segnali ausiliari per i due componenti che realizzano il modulo quadro di Sum_Early e Sum_Late
signal late2buffer: std_logic_vector(63 downto 0);
signal late2tvalid : std_logic;
signal late2tready : std_logic;
signal early2buffer: std_logic_vector(63 downto 0);
signal early2tvalid : std_logic;
signal early2tready : std_logic;

--! Segnali ausiliari per il componente che realizza la divisione tra il modulo di Sum_Early e il modulo di Sum_Late
signal quozient_tdata : std_logic_vector(103 downto 0);
signal quozient_tvalid : std_logic;
signal quozient_tready : std_logic;

--! Segnale ausiliare per gestire il dato in uscita da rappresentare su 24 bit,
--! di cui 13 costituiscono la parte intera e 11 quella decimale.
signal root_value : std_logic_vector (23 downto 0);

begin

ABS_SQR_EARLY:  AXI4_Stream_Absolute_Square_m
        PORT MAP ( 
               aresetn => aresetn,
               aclk => aclk,
               s_axis_value_tdata => s_axis_sum_early_tdata,
               s_axis_value_tvalid => s_axis_sum_early_tvalid,
               s_axis_value_tready => s_axis_sum_early_tready,
               m_axis_abssqr_tdata => early2buffer,
               m_axis_abssqr_tvalid => early2tvalid,
               m_axis_abssqr_tready => early2tready);
               
ABS_SQR_LATE:  AXI4_Stream_Absolute_Square_m
       PORT MAP ( 
              aresetn => aresetn,
              aclk => aclk,
              s_axis_value_tdata => s_axis_sum_late_tdata,
              s_axis_value_tvalid => s_axis_sum_late_tvalid,
              s_axis_value_tready => s_axis_sum_late_tready,
              m_axis_abssqr_tdata => late2buffer,
              m_axis_abssqr_tvalid => late2tvalid,
              m_axis_abssqr_tready => late2tready);

DIVIDER: AXI4_Stream_Divider_m
          PORT MAP(
                aclk => aclk,
                aresetn => aresetn,
                s_axis_divisor_tvalid => late2tvalid,
                s_axis_divisor_tready => late2tready,
                s_axis_divisor_tdata => late2buffer,
                s_axis_dividend_tvalid => early2tvalid,
                s_axis_dividend_tready => early2tready,
                s_axis_dividend_tdata => early2buffer,
                m_axis_dout_tvalid => quozient_tvalid,
                m_axis_dout_tready => quozient_tready,
                m_axis_dout_tdata => quozient_tdata);

SQUARE_ROOT: AXI4_Stream_Square_Root_m
        PORT MAP ( 
              aclk => aclk,
              aresetn => aresetn,
              s_axis_value_tvalid => quozient_tvalid,
              s_axis_value_tready => quozient_tready,
              s_axis_value_tdata => quozient_tdata(47 downto 0),     
              m_axis_result_tvalid => m_axis_r_tvalid,
              m_axis_result_tready => m_axis_r_tready,
              m_axis_result_tdata => root_value);
              
m_axis_r_tdata <= "000000000" & root_value(23 downto 9);

end Structural;