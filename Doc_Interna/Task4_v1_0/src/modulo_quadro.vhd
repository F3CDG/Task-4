----------------------------------------------------------------------------------------------
--! @file    	Task4_v1_0/src/modulo_quadro.vhd
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
--! @brief Il componente realizza il modulo quadro di un segnale complesso.
--!        Esso è realizzato utilizzando unicamente IP-Core messi a disposizione
--!        dalla Xilinx. Pertanto, la filosofia di progetto utilizzata è quella 
--!        Strutturale.
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modulo_quadro is
    Port ( Re_Early : in STD_LOGIC_VECTOR (31 downto 0);    --! Parte reale del segnale Sum_Early
           Im_Early : in STD_LOGIC_VECTOR (31 downto 0);    --! Parte immaginaria del segnale Sum_Early
           Re_Late : in STD_LOGIC_VECTOR (31 downto 0);     --! Parte reale del segnale Sum_Late
           Im_Late : in STD_LOGIC_VECTOR (31 downto 0);     --! Parte immaginaria del segnale Sum_Late  
           Early2 : out STD_LOGIC_VECTOR (63 downto 0);     --! Modulo quadro del segnale Sum_Early
           Late2 : out STD_LOGIC_VECTOR (63 downto 0);      --! Modulo quadro del segnale Sum_Late
           reset: in std_logic;                             --! Reset sincrono, attivo alto
           clk : in STD_LOGIC);                             --! Segnale di temporizzazione
end modulo_quadro;

architecture Behavioral of modulo_quadro is

------------------------------------------------------------------------
------------------------Moltiplicator Component-------------------------
------------------------------------------------------------------------
    component Square IS
      PORT (
        CLK : IN STD_LOGIC;
        SCLR : IN STD_LOGIC;
        A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        P : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
      );
    END component;

------------------------------------------------------------------------
-----------------------------Adder Component----------------------------
------------------------------------------------------------------------
    COMPONENT c_addsub_0 IS
      PORT (
        A : IN STD_LOGIC_VECTOR(62 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(62 DOWNTO 0);
        CLK : IN STD_LOGIC;
        SCLR : IN STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
      );
    END COMPONENT;

    --! Segnali ausiliari utilizzati per collegare i 2 moltiplicatori con l'addizionatore, per realizzare il singolo modulo quadro
    signal ReL2_buffer: std_logic_vector(63 downto 0);  --! Quadrato della parte reale di Sum_Late
    signal ImL2_buffer: std_logic_vector(63 downto 0);  --! Quadrato della parte immaginaria di Sum_Late
    signal ReE2_buffer: std_logic_vector(63 downto 0);  --! Quadrato della parte reale di Sum_Early
    signal ImE2_buffer: std_logic_vector(63 downto 0);  --! Quadrato della parte immaginaria di Sum_Early

begin

--! Moltiplicatore che realizza il quadrato della parte reale di Sum_Early
RE2E: Square
  PORT map(
    CLK=>clk,
    A=>Re_Early,
    B=>Re_Early,
    SCLR=>reset,
    P=>ReE2_buffer
  );

--! Moltiplicatore che realizza il quadrato della parte immaginaria di Sum_Early
IM2E: Square
  PORT map(
    CLK=>clk,
    A=>Im_Early,
    B=>Im_Early,
    SCLR=>reset,
    P=>ImE2_buffer
  );

--! Addizionatore che, sommando il quadrato della parte reale e immaginaria di Sum_Early, realizza il modulo quadro del segnale in oggetto
E2: c_addsub_0
  PORT map(
    CLK=>clk,
    SCLR=>reset,
    A=>ReE2_buffer(62 downto 0),
    B=>ImE2_buffer(62 downto 0),
    S=>Early2
  );

--! Moltiplicatore che realizza il quadrato della parte reale di Sum_Late
RE2L: Square
  PORT map(
    CLK=>clk,
    SCLR=>reset,
    A=>Re_Late,
    B=>Re_Late,
    P=>ReL2_buffer
  );

--! Moltiplicatore che realizza il quadrato della parte immaginaria di Sum_Late
IM2L: Square
  PORT map(
    CLK=>clk,
    SCLR=>reset,
    A=>Im_Late,
    B=>Im_Late,
    P=>ImL2_buffer
  );

--! Addizionatore che, sommando il quadrato della parte reale e immaginaria di Sum_Late, realizza il modulo quadro del segnale in oggetto
L2: c_addsub_0
  PORT map(
    CLK=>clk,
    SCLR=>reset,
    A=>ReL2_buffer(62 downto 0),
    B=>ImL2_buffer(62 downto 0),
    S=>Late2
  );

end Behavioral;
