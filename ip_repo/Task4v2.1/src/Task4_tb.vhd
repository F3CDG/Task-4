----------------------------------------------------------------------------------------------
--! @file    	Task4_tb.vhd
--! @authors	
--!             Colella Gianni      <gian.colella@studenti.unina.it>        <br>
--!             Guida Ciro          <ciro.guida4@studenti.unina.it>         <br>
--!             Lombardi Daniele    <daniele.lombardi@studenti.unina.it>    <br>
--! @version 	V1.0
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
--! @brief Questo file è un semplice test bench del componente Task4_m realizzato.
--!        L'esperimento consiste nel far processare al circuito sintetizzato 2
--!        valori di Sum_Early e Sum_Late generati da uno script Matlab fornito, e
--!        valutare se l'uscita restituita è coerente con il dato calcolato in Matlab.
----------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Task4_tb is
--  Port ( );
end Task4_tb;

architecture Behavioral of Task4_tb is

------------------------------------------------------------------------
----------------------------Task 4 Component----------------------------
------------------------------------------------------------------------
    component Task4_m is
        Port ( aclk : in STD_LOGIC;
               aresetn : in STD_LOGIC;
               s_axis_sum_early_tvalid :  in STD_LOGIC;
               s_axis_sum_early_tready :  out STD_LOGIC;
               s_axis_sum_early_tdata : in STD_LOGIC_VECTOR (63 downto 0);
               s_axis_sum_late_tvalid :  in STD_LOGIC;
               s_axis_sum_late_tready :  out STD_LOGIC;
               s_axis_sum_late_tdata : in STD_LOGIC_VECTOR (63 downto 0);
               m_axis_r_tvalid : out std_logic;
               m_axis_r_tready : in std_logic;
               m_axis_r_tdata : out STD_LOGIC_VECTOR (23 downto 0)
               );
    end component;

    signal aclk : STD_LOGIC;
    signal aresetn : STD_LOGIC := '1';                  --! Il reset viene inizializzato ad 1
    signal s_axis_sum_early_tvalid : STD_LOGIC:='0';
    signal s_axis_sum_early_tready : STD_LOGIC;
    signal s_axis_sum_early_tdata : STD_LOGIC_VECTOR (63 downto 0) := (others => '0');
    signal s_axis_sum_late_tvalid : STD_LOGIC:='0';
    signal s_axis_sum_late_tready : STD_LOGIC;
    signal s_axis_sum_late_tdata : STD_LOGIC_VECTOR (63 downto 0)  := (others => '0');
    signal m_axis_r_tvalid : std_logic;
    signal m_axis_r_tready : std_logic := '0';
    signal m_axis_r_tdata : STD_LOGIC_VECTOR (23 downto 0);


constant clock_period: time := 10 ns;
begin

uut: Task4_m
    Port map( 
         aclk => aclk,
         aresetn => aresetn,
         s_axis_sum_early_tvalid => s_axis_sum_early_tvalid, 
         s_axis_sum_early_tready  => s_axis_sum_early_tready,
         s_axis_sum_early_tdata  => s_axis_sum_early_tdata, 
         s_axis_sum_late_tvalid  => s_axis_sum_late_tvalid,
         s_axis_sum_late_tready => s_axis_sum_late_tready,
         s_axis_sum_late_tdata  => s_axis_sum_late_tdata,
         m_axis_r_tvalid  => m_axis_r_tvalid,
         m_axis_r_tready  => m_axis_r_tready,
         m_axis_r_tdata  => m_axis_r_tdata);
         
-- Clock process definitions
clock_process: process
begin
     aclk <= '0';
     wait for clock_period/2;
     aclk <= '1';
     wait for clock_period/2;
end process;
      
     
-- Stimulus process
stim_proc: process
        begin        
           -- hold reset state for 100 ns.
           wait for 100 ns;
              s_axis_sum_early_tdata<="0000111110000010011110011101011000101001101101101100110001110111";
              s_axis_sum_late_tdata<="1110111100011101111100000000000000011101101110010001101000100011";
    
             
              
              m_axis_r_tready<='1';             --! Viene simulata la situazione in cui il componente
                                                --! a valle del Task 4 sia pronto a ricevere dati                              
           wait for 50 ns;
               s_axis_sum_early_tvalid <='1';
               s_axis_sum_late_tvalid <='1';
           wait for clock_period;               --! il tvalid viene abbassato dopo un colpo di clock
              s_axis_sum_early_tvalid <='0';    --! per simulare il comportamento del protocollo AXI4 Stream
              s_axis_sum_late_tvalid <='0';
           wait for clock_period*20;
           
           wait; 
end process;        
               
end Behavioral;