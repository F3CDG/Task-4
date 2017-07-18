----------------------------------------------------------------------------------------------
--! @file    	Task4.vhd
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
--! @brief Questo componente include tutte le funzionalità che deve eseguire il
--!        Task 4. In particolare, in ingresso al componente vengono forniti
--!        2 segnali complessi espressi su 64 bit (32 Im, 32 Re); in uscita,
--!        invece, è reso disponibile un segnale contenente la radice del
--!        rapporto del modulo quadro dei due segnali di ingresso. Tale segnale
--!        è espresso su 24 bit (4 parte intera, 20 parte decimale). Tutto il
--!        componente è realizzato in modo tale da essere compatibile con
--!        interfaccia AXI4 Stream.
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Task4 is
    Port ( Sum_Early : in STD_LOGIC_VECTOR (63 downto 0);   --! Segnale signed di Sum_Early espresso su 64 bit (32 Im, 32 Re)
           Sum_Late : in STD_LOGIC_VECTOR (63 downto 0);    --! Segnale signed di Sum_Late espresso su 64 bit (32 Im, 32 Re)
           dividend_tvalid : in STD_LOGIC;                  --! Se alto, il dividendo in ingresso al divisore è valido
           divisor_tvalid : in STD_LOGIC;                   --! Se alto, il divisore in ingresso al divisore è valido
           dividend_tready : out STD_LOGIC;                 --! Se alto, il divisore è pronto a ricevere il dato del dividendo
           divisor_tready : out STD_LOGIC;                  --! Se alto, il divisore è pronto a ricevere il dato del divisore
           radix_tready: in std_logic;                      --! Se alto, segnala che il componente a valle è pronto a ricevere il dato calcolato
           r : out STD_LOGIC_VECTOR (23 downto 0);          --! Valore di R calcolato dal Task 
           r_tvalid:out std_logic;                          --! Se alto, il valore di R proposto in output è valido
           reset: in std_logic;                             --! Reset sincrono, attivo alto
           clk : in STD_LOGIC);                             --! Segnale di tempificazione
end Task4;

architecture Behavioral of Task4 is

------------------------------------------------------------------------
-----------------------------Square Component---------------------------
------------------------------------------------------------------------
    component modulo_quadro is
        Port ( Re_Early : in STD_LOGIC_VECTOR (31 downto 0);
               Im_Early : in STD_LOGIC_VECTOR (31 downto 0);
               Re_Late : in STD_LOGIC_VECTOR (31 downto 0);
               Im_Late : in STD_LOGIC_VECTOR (31 downto 0);        
               Early2 : out STD_LOGIC_VECTOR (63 downto 0);
               Late2 : out STD_LOGIC_VECTOR (63 downto 0);
               reset: in std_logic;
               clk : in STD_LOGIC);
    end component;

------------------------------------------------------------------------
----------------------------Divider Component---------------------------
------------------------------------------------------------------------
component DIVISORE IS
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_divisor_tvalid : IN STD_LOGIC;
    s_axis_divisor_tready : OUT STD_LOGIC;
    s_axis_divisor_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_dividend_tvalid : IN STD_LOGIC;
    s_axis_dividend_tready : OUT STD_LOGIC;
    s_axis_dividend_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tready : IN STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(103 DOWNTO 0)
  );
END component;

------------------------------------------------------------------------
--------------------------Square Root Component-------------------------
------------------------------------------------------------------------
component SQRT IS
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tready : OUT STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tready : IN STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END component;


--! Segnali ausiliari per collegare il componente modulo quadro al divisore
signal late2buffer: std_logic_vector(63 downto 0);
signal early2buffer: std_logic_vector(63 downto 0);
signal dividend_tvalid_buffer : STD_LOGIC:='0';
signal divisor_tvalid_buffer : STD_LOGIC:='0';

--! Segnali ausiliari per collegare il componente divisore al componente che realizza la radice quadrata
signal rapporto_tdata: std_logic_vector(103 downto 0);
signal rapporto_tready: std_logic;
signal rapporto_tvalid: std_logic;

--! Segnali ausiliari in uscita al componente che realizza la radice quadrata
signal radix_tdata_buffer : STD_LOGIC_VECTOR (31 downto 0);
signal radix_tvalid_buffer :  STD_LOGIC;

--! Segnale di reset attivo basso
signal reset_buffer_n: std_logic;


begin

reset_buffer_n<= not reset; --! Il reset di ingresso viene negato per essere utilizzato nei componenti che richiedono un reset at

SQUARE: modulo_quadro
    Port map(
     clk=>clk,
     reset=>reset,
     Re_Early=>Sum_Early(31 downto 0),
     Im_Early=>Sum_Early(63 downto 32),

     Re_Late=>Sum_Late(31 downto 0),
     Im_Late=>Sum_Late(63 downto 32),

     Early2=>early2buffer,
     Late2=>late2buffer
     );

DIVISOR: DIVISORE
  PORT MAP (
    aclk =>clk,
    aresetn=>reset_buffer_n,
    s_axis_dividend_tvalid=>dividend_tvalid,
    s_axis_dividend_tready=>dividend_tready, --
    s_axis_dividend_tdata=>early2buffer, 

    s_axis_divisor_tvalid=>divisor_tvalid,
    s_axis_divisor_tready=>divisor_tready,
    s_axis_divisor_tdata =>late2buffer,

    m_axis_dout_tvalid=>rapporto_tvalid,
    m_axis_dout_tready =>rapporto_tready,
    m_axis_dout_tdata=>rapporto_tdata
  );

SQUARE_ROOT: SQRT
  PORT MAP (
    aclk =>clk,
     aresetn=>reset_buffer_n,

    s_axis_cartesian_tvalid=>rapporto_tvalid,
    s_axis_cartesian_tready=>rapporto_tready,
    s_axis_cartesian_tdata =>rapporto_tdata(47 downto 0),

    m_axis_dout_tvalid=>radix_tvalid_buffer,
    m_axis_dout_tready =>radix_tready,
    m_axis_dout_tdata=>radix_tdata_buffer
  );

r_tvalid<=radix_tvalid_buffer;
r<=radix_tdata_buffer(23 downto 0);

end Behavioral;
