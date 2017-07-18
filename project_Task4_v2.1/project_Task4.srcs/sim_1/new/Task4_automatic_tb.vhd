----------------------------------------------------------------------------------------------
--! @file    	Task4_automatic_tb.vhd
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
--! @brief Con questo file si effettua un test bench su un numero significativo di
--!        elementi, pari a 1000. I dati in input al componente Task 4 vengono letti
--!        da 2 file generati da uno script Matlab (inputEarly.txt e inputLate.txt)
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;             --! Package necessario per la lettura e scrittura di file
use ieee.std_logic_textio.all; 

entity Task4_automatic_tb is
--  Port ( );
end Task4_automatic_tb;

architecture Behavioral of Task4_automatic_tb is

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
    signal aresetn : STD_LOGIC := '1';
    signal s_axis_sum_early_tvalid : STD_LOGIC:='0';
    signal s_axis_sum_early_tready : STD_LOGIC;
    signal s_axis_sum_early_tdata : STD_LOGIC_VECTOR (63 downto 0) := (others => '0');
    signal s_axis_sum_late_tvalid : STD_LOGIC:='0';
    signal s_axis_sum_late_tready : STD_LOGIC;
    signal s_axis_sum_late_tdata : STD_LOGIC_VECTOR (63 downto 0)  := (others => '0');
    signal m_axis_r_tvalid : std_logic;
    signal m_axis_r_tready : std_logic := '1';
    signal m_axis_r_tdata : STD_LOGIC_VECTOR (23 downto 0);

    --! Vengono definiti i nomi dei file da utilizzare durante il test bench
	file data_early : text;        --! Questo è il file in cui sono presenti i dati di Sum_Early
	file data_late : text;         --! Questo è il file in cui sono presenti i dati di Sum_Late
	file data_r : text;            --! Questo è il file in cui saranno salvati i risultati di R

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
         
--! Clock process definitions
clock_process :process
    begin
     aclk <= '0';
     wait for clock_period/2;
     aclk <= '1';
     wait for clock_period/2;
end process;
      
     
--! Stimulus process
	stim_proc: process
		
		--! Variabili utilizzate per la lettura e scrittura dei file 
		variable early_file_line : line;      --! Variabile associata alla linea letta dal file data_early
		variable late_file_line : line;       --! Variabile associata alla linea letta dal file data_late
		variable r_file_line : line;          --! Variabile associata alla linea scritta nel file data_r

		variable read_sum_early : std_logic_vector (63 downto 0) := (others=>'0');   --!Variabile associata al valore letto di sum_early
		variable read_sum_late : std_logic_vector (63 downto 0) := (others=>'0');    --!Variabile associata al valore letto di sum_late
		
		variable write_r : std_logic_vector (23 downto 0) := (others => '0');        --!Variabile associata al valore scritto di r 
		

		begin        
		   -- hold reset state for 100 ns.
		   wait for clock_period*10;
	
            
			file_open(data_early, "/home/daniele/Scrivania/Task4/testing2.0/inputEarly.txt",  read_mode);   --! apertura del file inputEarly
			file_open(data_late, "/home/daniele/Scrivania/Task4/testing2.0/inputLate.txt", read_mode);      --! apertura del file inputLate
			file_open(data_r, "/home/daniele/Scrivania/Task4/testing2.0/outputR_Vivadov2.1.1.txt", write_mode);   --! apertura del file outputR


			while not endfile(data_early) loop       --! Il ciclo serve per leggere tutti i dati contenuti nei file di input
			                                         --! poichè la loro dimensione è la stessa, la condizione di terminazione
			                                         --! del ciclo può essere fatta indifferentemente usando la funzione 
			                                         --! endfile(   ) su uno dei due file.
				readline(data_early,early_file_line);
				read(early_file_line,read_sum_early);
				s_axis_sum_early_tdata<=read_sum_early;
				
				readline(data_late,late_file_line);
				read(late_file_line,read_sum_late);
				s_axis_sum_late_tdata<=read_sum_late;
				
				s_axis_sum_early_tvalid <='1';       --! Senza perdere di generalità si suppone che i segnali tvalid dei dati 
			    s_axis_sum_late_tvalid <='1';        --! in input arrivino contemporaneamente
			    
				wait for clock_period;               --! Per simulare il comportamento del protocollo AXI4 Stream
			      	s_axis_sum_early_tvalid <='0';   --! dopo un colpo di clock i segnali tvalid sono messi a zero
			      	s_axis_sum_late_tvalid <='0';
			
				wait until m_axis_r_tvalid = '1';    --! Qui il test deve arrestarsi in attesa che il segnale tvalid sull'interfaccia
			                                         --! AXI4 Stream sia alto. Ciò sta a significare che il componente ha finito di
				                                     --! processare i segnali che ha ricevuto in ingresso
				write(r_file_line, m_axis_r_tdata, right, 24); 
				writeline(data_r, r_file_line);
	    
		     	end loop;
		     
		    --! Chiusura dei file precedentemente aperti  
		 	file_close(data_early);
			file_close(data_late);
			file_close(data_r);
		   wait; 
		end process;        
               
end Behavioral;