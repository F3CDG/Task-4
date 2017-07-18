----------------------------------------------------------------------------------------------
--! @file    	Task4_v2_0/src/mod_quad_oper.vhd
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
--! @brief Questo componente realizza il modulo quadro di un numero compmlesso.
--!        Si presuppone che sia la parte reale sia quella immaginaria del numero 
--!        siano rappresentate entrambe sullo stesso numero di bit, in notazione
--!        signed integer. Si precisa, a tal proposito, che ai fini del progetto,
--!        essendo il modulo un numero positivo e nell'ottica del risparmio di spazio,
--!        questo componente tronca l'ultimo bit di uscita, che si sa apriori
--!        essere nullo.
--!        Per la sua realizzazione, è stata utilizzata una filosofia di progetto 
--!        dataflow, in questo modo il sintetizzatore UG901 di Vivado cerca di 
--!        inferire, lì dove possibile, le DSP48E presenti sulla Zynq Zybo.
----------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_quad_oper is
    generic(n: natural:=32);                                    --! Specifica la dimensione, n, su cui deve essere rappresentata la parte reale e immaginaria del numero
    Port ( Im : in STD_LOGIC_VECTOR (n-1 downto 0);             --! Specifica la parte immaginaria del numero, espressa su n bit
           Re : in STD_LOGIC_VECTOR (n-1 downto 0);             --! Specifica la parte reale del numero, espressa su n bit
           modulo2 : out STD_LOGIC_VECTOR (2*n -1 downto 0));   --! Specifica il modulo quadro calcolato 
end mod_quad_oper;

architecture Dataflow of mod_quad_oper is

   --! Affinchè le stringhe di bit in ingresso vengano trattate come numeri signed, 
   --! vengono utilizzati i seguenti segnali ausiliari definiti signed.
        signal data_im:  signed(n-1 downto 0);                      
        signal data_re:  signed(n-1 downto 0);
        
    --! Per garantire il corretto calcolo dell'operazione di addizione di numeri signed,
    --! sono definiti i segneìali seguenti.
        signal data_im2:  signed(2*n-1 downto 0);   --! Im^2
        signal data_re2:  signed(2*n-1 downto 0);   --! Re^2
    
    --! Il segnale data_mod, invecec, conterrà il risultato dell'addizione signed
    --! tra data_im2 e data_re2
    signal data_mod:  signed(2*n-1 downto 0);         --! Im^2 + Re^2

begin

    data_im<=signed(Im);    --! Casting da std_logic_vector a signed
    data_re<=signed(Re);

    --! Calcolo del quadrato della parte immaginaria
    data_im2<=data_im*data_im;                   --32 bit_signed * 32 bit_signed= 64 bit_signed
    --! Calcolo del quadrato della parte reale
    data_re2<=data_re*data_re;                   --32 bit_signed * 32 bit_signed= 64 bit_signed
    
    --! Somma dei due quadrati per ottenere il modulo del numero.
    data_mod<=data_im2+data_re2;                  --64 bit_signed + 64 bit _signed = 65 bit_signed = 64 bit unsigned (poichè il valore è senz'altro positivo) 
    
    --! Il valore calcolato viene portato in uscita a meno dell'ultimo bit
    modulo2<=std_logic_vector(data_mod(2*n-1 downto 0));    

end Dataflow;
