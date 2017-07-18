%% BENCH TEST:
% import some data generated in ISE into matlab and plot it;
% then generate some data in matlab and export in ISE compatible
% format.
%
% DATA LOADING EXAMPLE:
% myFile='output_results.txt';    % Filename
% fid = fopen(myFile);            % Open file
% i=0;                            % Init line counter
% tline = fgetl(fid);             % Load first line
% while ischar(tline)     % While new line is good
%     i=i+1;              % Increment counter
%     disp(tline);        % Show binary string loaded
%     n(i)=bin2num(q16_1,tline); % Convert & add to array
%     tline = fgetl(fid);	% Get next line
% end % While new line is good
% fclose(fid);            % Close file
% figure(1);
% plot(1:length(n),n);    % Plot data
% title('Imported data');
%
% DATA SAVING EXAMPLE:
% fs=20460000;        % Sampling frequency (Hz)
% dt=1/fs;            % Time step (s)
% t_array=0:dt:dt*99; % Time array (100 elements)
% f=-1279323;          % Frequency of test signal
% data=sin(2*pi*t_array*f)*a;   % Generate sine signal, scaled to 16 bit signed
% %% Write data on file
% myFile='output_results1.txt';       % Filename
% fid = fopen(myFile,'w');            % Open file
% for i=1:length(data) % For each data value
%     b = num2bin(q16_1,data(i));     % Generate binary string
%     fwrite(fid,[b char(13) char(10)]); % Remember to add \r\n to end lines!
% end % For each data value
% fclose(fid);                        % Close file
% figure(2);
% plot(1:length(data),data);           % Plot data
% title('Exported data');
% ----------------------------------------------------------------

%% Define quantizer: used to convert from binary string to number
q32_32=quantizer([32 0]); % Define quantizer as (precision, decimal part)
% [a,b]=range(q16_1); % Max & Min value in quantizer range
q24_13=quantizer([24 11]); % Define quantizer as (precision, decimal part)
% [a,b]=range(q16_1); % Max & Min value in quantizer range
q48_26=quantizer([48 22]); % Define quantizer as (precision, decimal part)
% [a,b]=range(q16_1); % Max & Min value in quantizer range

%% Generate output:
n=1000;             % Number of elements for test
fs=20460000;        % Sampling frequency (Hz)
dt=1/fs;            % Time step (s)

% early and late accumulators are 32 bit complex
sigEarly=(2^31)*rand(1,n)+(2^31)*1i*rand(1,n);    % Rand generates signal in [0:1] range
sigEarly=round(sigEarly-mean(sigEarly));       % Compute mean of signal and to remove it
sigLate=(2^31)*rand(1,n)+(2^31)*1i*rand(1,n);    % Rand generates signal in [0:1] range
sigLate=round(sigLate-mean(sigLate));       % Compute mean of signal and to remove it
% Now we have a plausible set of data

% Compute operations
reE2=real(sigEarly).^2;
imE2=imag(sigEarly).^2;
reL2=real(sigLate).^2;
imL2=imag(sigLate).^2;
sE=reE2+imE2;
sL=reL2+imL2;
d1=sE./sL;
R=sqrt(d1);

%% WRITE Early in 64 bit - (Im)<32,32>; (Re) <32,32>
myFile='inputEarly.txt';       % Filename
fid = fopen(myFile,'w');         % Open file
for i=1:length(sigEarly) % For each data value
    b_imag = num2bin(q32_32,imag(sigEarly(i)));  % Generate binary string
    b_real = num2bin(q32_32,real(sigEarly(i)));  % Generate binary string
    fwrite(fid,[b_imag b_real char(13) char(10)]); % Remember to add \r\n to end lines!
end % For each data value
fclose(fid);                     % Close file

%% DRAW Late

figure(1);hold off;
plot(1:length(sigEarly),real(sigEarly));hold on;
plot(1:length(sigEarly),imag(sigEarly));grid on;
legend('Real component','Imaginary component');
title('Signal Early');

%% WRITE Late in 64 bit - (Im)<32,32>; (Re) <32,32>
myFile='inputLate.txt';       % Filename
fid = fopen(myFile,'w');        % Open file
for i=1:length(sigLate) % For each data value
    b_imag = num2bin(q32_32,imag(sigLate(i))); % Generate binary string
    b_real = num2bin(q32_32,real(sigLate(i))); % Generate binary string
    fwrite(fid,[b_imag b_real char(13) char(10)]); % Remember to add \r\n to end lines!
end % For each data value
fclose(fid);                    % Close file

%% DRAW Late
figure(2);hold off;
plot(1:length(sigLate),real(sigLate));hold on;
plot(1:length(sigLate),imag(sigLate));grid on;
legend('Real component','Imaginary component');
title('Signal Late');

%% write in a file r^2 in <48,26> (26 bit parte intera, 22 decimale)  
% myFile='Internal_r2.txt';       % Filename
% fid = fopen(myFile,'w');        % Open file
% for i=1:length(sigLate) % For each data value
%     di2 = num2bin(q48_26,d1(i)); % Generate binary string
%     fwrite(fid,[di2 char(13) char(10)]); % Remember to add \r\n to end lines!
% end % For each data value
% fclose(fid);                    % Close file
%% DRAW r^2

% figure(3);hold off;
% plot(1:length(d1),d1);hold on;
% title('r^2=E^2/R^2 value');

%% WRITE R in <24,13> precision
myFile='outputR_Matlab.txt';       % Filename
fid = fopen(myFile,'w');        % Open file
for i=1:length(R) % For each data value
    b = num2bin(q24_13,R(i)); % Generate binary string
    fwrite(fid,[b char(13) char(10)]); % Remember to add \r\n to end lines!
end % For each data value
fclose(fid);                    % Close file
%% DRAW R
figure(4);hold off;
plot(1:length(R),R);hold on;
title('R value');
