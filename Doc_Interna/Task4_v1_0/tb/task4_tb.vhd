----------------------------------------------------------------------------------------------
--! @file    	Task4_v1_0/tb/task4_tb.vhd
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
--! @brief Questo file realizza il primo test bench effettuato sul componente 
--!        Task4. Inizialmente sono stati forniti in ingresso 2 numeri di piccole
--!        dimensioni per verificare facilmente il corretto funzionamento. In un
--!        secondo momento sono stati dati in ingresso 2 valori di Sum_Early e Sum_Late
--!        generati da uno script Matlab, il risultato è stato confrontato con quello
--!        ottenuto in Matlab.
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity task4_tb is
--  Port ( );
end task4_tb;

architecture Behavioral of task4_tb is

component Task4 is
    Port ( Sum_Early : in STD_LOGIC_VECTOR (63 downto 0);
           Sum_Late : in STD_LOGIC_VECTOR (63 downto 0);
           dividend_tvalid : in STD_LOGIC;
           divisor_tvalid : in STD_LOGIC;
           dividend_tready : out STD_LOGIC;
           divisor_tready : out STD_LOGIC;
           radix_tready: in std_logic;
           r : out STD_LOGIC_VECTOR (23 downto 0);
           reset : in std_logic;
           r_tvalid: out std_logic;
           clk : in STD_LOGIC);
end component;

signal Sum_Early : STD_LOGIC_VECTOR (63 downto 0):=(others=>'0');
signal Sum_Late : STD_LOGIC_VECTOR (63 downto 0):=(others=>'0');
signal dividend_tvalid : STD_LOGIC:='0';
signal divisor_tvalid : STD_LOGIC:='0';
signal dividend_tready : STD_LOGIC;
signal divisor_tready : STD_LOGIC;
signal radix_tready:  std_logic:='0';
signal r :  STD_LOGIC_VECTOR (23 downto 0);
signal clk : STD_LOGIC:='0';
signal r_tvalid: std_logic;
signal reset : std_logic:='0';

constant clock_period: time := 10 ns;
begin

uut: Task4 
    Port map( 
            Sum_Early=>Sum_Early,
            Sum_Late=>Sum_Late,
           dividend_tvalid=>dividend_tvalid,
           divisor_tvalid=>divisor_tvalid,
           radix_tready=>radix_tready,
           dividend_tready=>dividend_tready,
           divisor_tready=>divisor_tready,
           reset=>reset,
           r=>r,
           r_tvalid=>r_tvalid,
           clk=>clk
           );
--! Clock process definitions
clock_process: process
begin
     clk <= '0';
     wait for clock_period/2;
     clk <= '1';
     wait for clock_period/2;
end process;
      
     
--! Stimulus process
stim_proc: process
        begin        
           --! hold reset state for 100 ns.
           wait for 10 ns;
            --! Segnali di prova generati dallo script Matlab
            Sum_Early<="1101010100010110101011010100010011001100110110111011011001010000";
            Sum_Late<="1111101110011011101011001111011000001011101101100100101100011101";
            
            --! Segnali di prova di piccole dimensioni
                -- Sum_Early(63 downto 32)<=x"00000003";
                -- Sum_Early(31 downto 0)<=x"00000004";
                -- Sum_Late(63 downto 32)<=x"00000002"; 
                -- Sum_Late(31 downto 0)<=x"00000001";
           wait for 30 ns;
               dividend_tvalid<='1';
               divisor_tvalid<='1';
           wait for 30 ns;         --! I segnali di valid vengono abbassati dopo 30 ns
               dividend_tvalid<='0';
               divisor_tvalid<='0';
               radix_tready<='1';
            wait for 1350 ns;               
               radix_tready<='0';
           wait for clock_period*20;
           wait; 
        end process;                   
       
end Behavioral;
