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
