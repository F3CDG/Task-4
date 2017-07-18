%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%! @file    	error_evaluation.m
%%! @authors	
%%!             Colella Gianni      <gian.colella@studenti.unina.it>        <br>
%%!             Guida Ciro          <ciro.guida4@studenti.unina.it>         <br>
%%!             Lombardi Daniele    <daniele.lombardi@studenti.unina.it>    <br>
%%! @version 	V1.0
%%! @date    	17%July%2017
%%! @copyright
%%!  Copyright (C) 2017      
%%!  Colella Gianni      <gian.colella@studenti.unina.it>        <br>
%%!  Guida Ciro          <ciro.guida4@studenti.unina.it>         <br>
%%!  Lombardi Daniele    <daniele.lombardi@studenti.unina.it>    <br>
%%!  This file is part of Task4. It is realized from Group IV of Embedded System 
%%!  Class, University of Naples "Federico II", in the academic year 2016/17.
%%!
%%!  This file is part of Task4.
%%!
%%!  Task4 is free software: you can redistribute it and/or modify
%%!  it under the terms of the GNU Affero General Public License as published by
%%!  the Free Software Foundation, either version 3 of the License, or
%%!  (at your option) any later version.
%%!
%%!  Task4 is distributed in the hope that it will be useful,
%%!  but WITHOUT ANY WARRANTY; without even the implied warranty of
%%!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%!  GNU Affero General Public License for more details.
%%!
%%!  You should have received a copy of the GNU Affero General Public License
%%!  along with Linux Driver: Examples. If not, see
%%!  <https://www.gnu.org/licenses/agpl%3.0.html>.
%%! @brief Questo semplice script è utilizzato per il calcolo dell'errore relativo
%%!   	   e dell'errore assoluto commesso dal dispositivo hardware sintetizzato
%%!	   rispetto ai valori generati dallo script T4_data_generator.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% CALCOLO ERRORI
% Con questo piccolo script in codice MATLAB si vuole calcolare l'errore
% relativo e l'errore assoluto dei valori di output del TASK 4.
% Tali valutazioni sono effettuate confrontando i
% valori di R generati dal codice MATLAB e forniti al gruppo IV da chi ha
% commissionato questo progetto, con i valori ottenuti dall'IP%core custom,
% sotto ambiente Vivado, realizzato ad hoc per rispettare le specifiche di
% progetto.

q=quantizer([24 13]);
[bin_r_mat,dec_r_mat]=range(q);
[bin_r_viv,dec_r_viv]=range(q);

format longE;
r_file_matlab = 'outputR_Matlab.txt';
r_file_vivado = 'outputR_Vivado.txt';
error_abs_file = 'error_abs.txt';
error_rel_file = 'error_rel.txt';

%leggi e carica i dati binari dai file
%trasformo i dati in decimale cosi' da poter fare un confronto e valutare l'errore relativo e assoluto
r_mat=textread(r_file_matlab,'%s');
bin_r_mat= r_mat(1:1:end);
dec_r_mat=bin2num(q,bin_r_mat);%r in decimale signed su 13 bit intero e 11 parte decimale


r_viv=textread(r_file_matlab,'%s');
bin_r_viv= r_viv(1:1:end);
dec_r_viv=bin2num(q,bin_r_viv);%r in decimale signed su 13 bit intero e 11 parte decimale

dec_r_viv=cell2mat(dec_r_viv);
dec_r_mat=cell2mat(dec_r_mat);

error_abs_dec= abs(dec_r_viv % dec_r_mat);
dlmwrite(error_abs_file,error_abs_dec,' ');
error_rel_dec= abs(dec_r_viv%dec_r_mat)./dec_r_mat;
dlmwrite(error_rel_file,error_abs_dec,' ');
